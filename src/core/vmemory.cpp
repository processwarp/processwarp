
#include <cstring>
#include <iostream>
#include <tuple>

#include "error.hpp"
#include "util.hpp"
#include "vmemory.hpp"

using namespace usagi;

static const vaddr_t UPPER_MASKS[] = {
  0xFFFFFFFFFFFFFFFF, // 型
  0xFFFFFFFFFFFFFF00,
  0xFFFFFFFFFFFF0000,
  0xFFFFFFFFFF000000,
  0xFFFFFFFF00000000,
  0xFFFFFF0000000000,
  0xFFFF000000000000,
  0x0000000000000000, // dummy
  0x0000000000000000, // dummy
  0xFFFFFFFFFFFFFF00,
  0xFFFFFFFFFFFF0000,
  0xFFFFFFFFFF000000,
  0xFFFFFFFF00000000,
  0xFFFFFF0000000000,
  0xFFFF000000000000,
  0xFFFFFFFFFFFFFFFF, // 関数
};

static const int LOWER_BITS[] = {
  0, // 型
  8,
  16,
  24,
  32,
  40,
  48,
  0, // dummy
  0, // dummy
  8,
  16,
  24,
  32,
  40,
  48,
  0, // 関数
};

/**
 * 空いているaddressを割り当てる
 * @param store_map
 * @param last_free
 * @param addr
 */
template<typename T>
vaddr_t assign_addr(std::map<vaddr_t, T>& store_map,
		    vaddr_t type, vaddr_t* last_free, vaddr_t addr) {
  
  if (addr != VADDR_NON) {
    // タイプが整合していること、アドレスが空いていること。
    if (type != (addr & AddrType::AD_MASK) ||
	store_map.find(addr) != store_map.end()) {
      print_debug("type:%016llx, addr:%016llx\n", type, addr);
      throw_error(Error::SPEC_VIOLATION);
    }
    return addr;

  } else {
    // 新しいアドレスを割り当てる
    int lower_bits = LOWER_BITS[type >> 60];
    // 上位ビットの最大値 + 1(フラグ部分の4bitを除く)
    vaddr_t max_upper = static_cast<vaddr_t>(1) << (sizeof(vaddr_t) * 8 - 4 - lower_bits);

    // メモリ空間の空きアドレスを探す
    while (store_map.find(type | (*last_free << lower_bits)) != store_map.end()) {
      (*last_free) ++;
      if (*last_free >= max_upper) {
	throw_error_message(Error::OUT_OF_MEMORY, Util::vaddr2str(*last_free));
      }
    }

    // アドレスとして、タイプ、上位アドレス、下位アドレス分の0を結合する。
    return type | (((*last_free) ++) << lower_bits);
  }
}
 
// コンストラクタ。
VMemory::VMemory() {
  for (unsigned int i = 0; i < sizeof(last_free) / sizeof(last_free[0]); i ++) {
    last_free[i] = 1;
  }

  // 基本型の最大を初期値にセット
  last_free[AddrType::AD_TYPE >> 60] = BasicType::TY_MAX + 1;
}

// アドレスが関数領域のものかどうか調べる。
bool VMemory::addr_is_func(vaddr_t addr) {
  return (addr & AddrType::AD_MASK) == AddrType::AD_FUNCTION;
}

// アドレスが型領域のものかどうか調べる。
bool VMemory::addr_is_type(vaddr_t addr) {
  return (addr & AddrType::AD_MASK) == AddrType::AD_TYPE;
}

// メモリ空間に新しいデータ領域を確保する。
VMemory::AllocDataRet VMemory::alloc_data(size_t size, bool is_const, vaddr_t addr) {
  print_debug("alloc_data size:%ld, addr:%016llx\n", size, addr);
  // サイズからアドレスタイプを判定する
  vaddr_t type;
  if      (size < (static_cast<vaddr_t>(1) <<  8)) type = AddrType::AD_VALUE_08;
  else if (size < (static_cast<vaddr_t>(1) << 16)) type = AddrType::AD_VALUE_16;
  else if (size < (static_cast<vaddr_t>(1) << 24)) type = AddrType::AD_VALUE_24;
  else if (size < (static_cast<vaddr_t>(1) << 32)) type = AddrType::AD_VALUE_32;
  else if (size < (static_cast<vaddr_t>(1) << 40)) type = AddrType::AD_VALUE_40;
  else if (size < (static_cast<vaddr_t>(1) << 48)) type = AddrType::AD_VALUE_48;
  else throw_error(Error::OUT_OF_MEMORY);
  // 定数フラグ付与
  if (is_const) type |= AddrType::AD_CONSTANT;

  // 空きアドレスの検索
  addr = assign_addr(data_store_map, type, &last_free[type >> 60], addr);
  
  return {addr, data_store_map.insert(std::make_pair(addr, DataStore(size))).first->second};
}

// メモリ空間に新しい通常の関数領域を確保する。
VMemory::AllocFuncRet VMemory::alloc_func(const Symbols::Symbol& name,
					  const FuncStore::NormalProp& normal_prop,
					  vaddr_t addr) {
  print_debug("alloc_func(N) name:%s, addr:%016llx\n", name.str().c_str(), addr);
  // 空きアドレスの検索
  addr = assign_addr(func_store_map,
		     static_cast<vaddr_t>(AddrType::AD_FUNCTION),
		     &last_free[static_cast<vaddr_t>(AddrType::AD_FUNCTION) >> 60],
		     addr);

  return {addr, func_store_map.insert
      (std::make_pair(addr, FuncStore(name, normal_prop))).first->second};
}

// メモリ空間に新しいVM組み込み関数領域を確保する。
VMemory::AllocFuncRet VMemory::alloc_func(const Symbols::Symbol& name,
					  const intrinsic_func_t intrinsic, 
					  vaddr_t addr) {
  print_debug("alloc_func(I) name:%s, addr:%016llx\n", name.str().c_str(), addr);
  // 空きアドレスの検索
  addr = assign_addr(func_store_map,
		     static_cast<vaddr_t>(AddrType::AD_FUNCTION),
		     &last_free[static_cast<vaddr_t>(AddrType::AD_FUNCTION) >> 60],
		     addr);

  return {addr, func_store_map.insert
      (std::make_pair(addr, FuncStore(name, intrinsic))).first->second};
}

// メモリ空間に新しい外部関数領域を確保する。
VMemory::AllocFuncRet VMemory::alloc_func(const Symbols::Symbol& name,
					  vaddr_t addr) {
  print_debug("alloc_func(E) name:%s, addr:%016llx\n", name.str().c_str(), addr);
  // 空きアドレスの検索
  addr = assign_addr(func_store_map,
		     static_cast<vaddr_t>(AddrType::AD_FUNCTION),
		     &last_free[static_cast<vaddr_t>(AddrType::AD_FUNCTION) >> 60],
		     addr);

  return {addr, func_store_map.insert
      (std::make_pair(addr, FuncStore(name))).first->second};
}


// メモリ空間に複合型領域を確保する。
VMemory::AllocTypeRet VMemory::alloc_type(size_t size,
					  unsigned int alignment,
					  const std::vector<vaddr_t>& member,
					  vaddr_t addr) {
  print_debug("alloc_type size:%ld, alignment:%d, addr:%016llx\n", size, alignment, addr);
  // 空きアドレスの検索
  addr = assign_addr(type_store_map,
		     static_cast<vaddr_t>(AddrType::AD_TYPE),
		     &last_free[static_cast<vaddr_t>(AddrType::AD_TYPE) >> 60],
		     addr);

  return {addr, type_store_map.insert
      (std::make_pair(addr, TypeStore(size, alignment, member))).first->second};
}

// メモリ空間に配列型領域を確保する。
VMemory::AllocTypeRet VMemory::alloc_type(size_t size,
					  unsigned int alignment,
					  vaddr_t element,
					  unsigned int num,
					  vaddr_t addr) {
  print_debug("alloc_type size:%ld, alignment:%d, element:%016llx, num:%d, addr:%016llx\n",
	      size, alignment, element, num, addr);
  // 空きアドレスの検索
  addr = assign_addr(type_store_map,
		     static_cast<vaddr_t>(AddrType::AD_TYPE),
		     &last_free[static_cast<vaddr_t>(AddrType::AD_TYPE) >> 60],
		     addr);

  return {addr, type_store_map.insert
      (std::make_pair(addr, TypeStore(size, alignment, element, num))).first->second};
}


// 既存のメモリ空間をコピーして新しいデータ領域を確保する。
VMemory::AllocDataRet VMemory::copy_data(vaddr_t addr, unsigned int size) {
  DataStore& src = get_data(addr);

  // 領域をはみ出している場合NG
  if (get_addr_lower(addr) + size > src.size) {
    throw_error_message(Error::SEGMENT_FAULT, Util::vaddr2str(addr + size));
  }

  // 新しい領域を取得する。
  AllocDataRet dst = alloc_data(size, false);
  // 新しい領域にデータをコピー。
  memcpy(dst.data.head.get(),
	 src.head.get() + get_addr_lower(addr),
	 size);

  print_debug("copy\n");
  print_debug("\tsize\t:%d\n", size);
  print_debug("\tsrc\t:%s\n", Util::vaddr2str(addr).c_str());
  print_debug("\tsrc addr\t:%p\n", src.head.get() + get_addr_lower(addr));
  print_debug("\tdst\t:%s\n", Util::vaddr2str(dst.addr).c_str());
  print_debug("\tdst addr\t:%p\n", dst.data.head.get());

  return dst;
}

// アドレスのupper部分を取り出す。
vaddr_t VMemory::get_addr_upper(vaddr_t addr) {
  return addr & UPPER_MASKS[addr >> 60];
}

// アドレスのlower部分を取り出す。
vaddr_t VMemory::get_addr_lower(vaddr_t addr) {
  return addr & (~UPPER_MASKS[addr >> 60]);
}

// アドレスに対応する領域を取得する。
DataStore& VMemory::get_data(vaddr_t addr) {
  auto data = data_store_map.find(get_addr_upper(addr));

  // 検索失敗 = アクセス違反
  if (data == data_store_map.end()) {
    throw_error_message(Error::SEGMENT_FAULT, Util::vaddr2str(addr));
  }
  
  return data->second;
}

// アドレスに対応する関数領域を取得する。
FuncStore& VMemory::get_func(vaddr_t addr) {
  auto func = func_store_map.find(addr);

  // 検索失敗 = アクセス違反
  if (func == func_store_map.end()) {
    throw_error_message(Error::SEGMENT_FAULT, Util::vaddr2str(addr));
  }
  
  return func->second;
}

// アドレスに対応する型領域を取得する。
TypeStore& VMemory::get_type(vaddr_t addr) {
  auto type = type_store_map.find(addr);

  // 検索失敗 = アクセス違反
  if (type == type_store_map.end()) {
    throw_error_message(Error::SEGMENT_FAULT, Util::vaddr2str(addr));
  }

  return type->second;
}
