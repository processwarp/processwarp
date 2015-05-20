
#include <cstring>
#include <inttypes.h>
#include <iostream>
#include <tuple>

#include "error.hpp"
#include "util.hpp"
#include "vmemory.hpp"

using namespace processwarp;

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
 * 空いているaddressを割り当てる。
 * アドレス指定がVADDR_NON以外かつ、reservedに同一アドレスが指定されていた場合、
 * reservedから該当アドレスを削除する。
 * @param store_map 割り当て済みの領域一覧
 * @param reserved 予約アドレス一覧
 * @param type 割り当てるアドレスの判定フラグ
 * @param last_free 判定フラグに対応した空きアドレス
 * @param addr アドレス指定
 * @return 割り当てアドレス
 */
template<typename T>
vaddr_t assign_addr(std::map<vaddr_t, T>& store_map,
		    std::set<vaddr_t>& reserved,
		    vaddr_t type, vaddr_t* last_free, vaddr_t addr) {
  
  if (addr != VADDR_NON) {
    // タイプが整合していること、アドレスが空いていること。
    if ((type != (addr & AddrType::AD_MASK) &&
	 (type | AddrType::AD_CONSTANT) != (addr & AddrType::AD_MASK)) ||
	store_map.find(addr) != store_map.end()) {
      print_debug("type:%016" PRIx64 ", addr:%016" PRIx64 "\n", type, addr);
      throw_error(Error::SPEC_VIOLATION);
    }

    // reservedにアドレスが含まれたいた場合除去
    auto it = reserved.find(addr);
    if (it != reserved.end()) {
      reserved.erase(it);
    }

    return addr;

  } else {
    // 新しいアドレスを割り当てる
    int lower_bits = LOWER_BITS[type >> 60];
    // 上位ビットの最大値 + 1(フラグ部分の4bitを除く)
    vaddr_t max_upper = static_cast<vaddr_t>(1) << (sizeof(vaddr_t) * 8 - 4 - lower_bits);

    // メモリ空間の空きアドレスを探す
    while (store_map.find(type | (*last_free << lower_bits)) != store_map.end() ||
	   reserved.find (type | (*last_free << lower_bits)) != reserved.end()) {
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

// Check addr is allocated.
bool VMemory::addr_is_used(vaddr_t addr) {
  if (addr_is_func(addr)) {
    return func_store_map.find(addr) != func_store_map.end();

  } else if (addr_is_type(addr)) {
    return type_store_map.find(addr) != type_store_map.end();

  } else {
    auto data = data_store_map.find(get_addr_upper(addr));
    if (data == data_store_map.end()) {
      return false;

    } else {
      return get_addr_lower(addr) < data->second.size;
    }
  }
}

// メモリ空間に新しいデータ領域を確保する。
DataStore& VMemory::alloc_data(uint64_t size, bool is_const, vaddr_t addr) {
  print_debug("alloc_data size:%" PRIx64 ", addr:%016" PRIx64 "\n", size, addr);
  assert(size != 0);

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
  addr = assign_addr(data_store_map, data_reserved, type, &last_free[type >> 60], addr);
  
  return data_store_map.insert(std::make_pair(addr, DataStore(addr, size))).first->second;
}

// メモリ空間に新しい通常の関数領域を確保する。
FuncStore& VMemory::alloc_func(const Symbols::Symbol& name,
			       vaddr_t ret_type,
			       unsigned int arg_num,
			       bool is_var_arg,
			       const FuncStore::NormalProp& normal_prop,
			       vaddr_t addr) {
  print_debug("alloc_func(N) name:%s, addr:%016" PRIx64 "\n", name.str().c_str(), addr);
  // 空きアドレスの検索
  addr = assign_addr(func_store_map, func_reserved,
		     static_cast<vaddr_t>(AddrType::AD_FUNCTION),
		     &last_free[static_cast<vaddr_t>(AddrType::AD_FUNCTION) >> 60],
		     addr);

  return func_store_map.insert
    (std::make_pair(addr, FuncStore
		    (addr, name, ret_type, arg_num, is_var_arg, normal_prop))).first->second;
}

// メモリ空間に新しいVM組み込み関数領域を確保する。
FuncStore& VMemory::alloc_func(const Symbols::Symbol& name,
			       vaddr_t ret_type,
			       unsigned int arg_num,
			       bool is_var_arg,
			       const intrinsic_func_t intrinsic,
			       const IntrinsicFuncParam param,
			       vaddr_t addr) {
  print_debug("alloc_func(I) name:%s, addr:%016" PRIx64 ", param:%016" PRIx64 "\n",
	      name.str().c_str(), addr, param.i64);
  // 空きアドレスの検索
  addr = assign_addr(func_store_map, func_reserved,
		     static_cast<vaddr_t>(AddrType::AD_FUNCTION),
		     &last_free[static_cast<vaddr_t>(AddrType::AD_FUNCTION) >> 60],
		     addr);

  return func_store_map.insert
    (std::make_pair(addr, FuncStore
		    (addr, name, ret_type, arg_num, is_var_arg, intrinsic, param))).first->second;
}

// メモリ空間に新しい外部関数領域を確保する。
FuncStore& VMemory::alloc_func(const Symbols::Symbol& name,
			       vaddr_t ret_type,
			       unsigned int arg_num,
			       bool is_var_arg,
			       vaddr_t addr) {
  print_debug("alloc_func(E) name:%s, addr:%016" PRIx64 "\n", name.str().c_str(), addr);
  // 空きアドレスの検索
  addr = assign_addr(func_store_map, func_reserved,
		     static_cast<vaddr_t>(AddrType::AD_FUNCTION),
		     &last_free[static_cast<vaddr_t>(AddrType::AD_FUNCTION) >> 60],
		     addr);

  return func_store_map.insert
    (std::make_pair(addr, FuncStore(addr, name, ret_type, arg_num, is_var_arg))).first->second;
}

// メモリ空間に配列型領域を確保する。
TypeStore& VMemory::alloc_type_array(size_t size,
				     unsigned int alignment,
				     vaddr_t element,
				     unsigned int num,
				     vaddr_t addr) {
  print_debug("alloc_type_array size:%ld, alignment:%d, element:%016" PRIx64
	      ", num:%d, addr:%016" PRIx64 "\n",
	      size, alignment, element, num, addr);
  // 空きアドレスの検索
  addr = assign_addr(type_store_map, type_reserved,
		     static_cast<vaddr_t>(AddrType::AD_TYPE),
		     &last_free[static_cast<vaddr_t>(AddrType::AD_TYPE) >> 60],
		     addr);

  return type_store_map.insert
    (std::make_pair(addr, TypeStore(addr, TypeKind::TK_ARRAY, size, alignment, element, num))).
    first->second;
}

// メモリ空間に基本型の型領域を確保する。
TypeStore& VMemory::alloc_type_basic(size_t size,
				     unsigned int alignment,
				     vaddr_t addr) {
  print_debug("alloc_type_basic size:%ld, alignment:%d addr:%016" PRIx64 "\n",
	      size, alignment, addr);
  // 基本型はVADDR_NONなし
  assert(addr != VADDR_NON);
  //
  return type_store_map.insert
    (std::make_pair(addr, TypeStore(addr, alignment, size))).first->second;
}

// メモリ空間に構造体の型領域を確保する。
TypeStore& VMemory::alloc_type_struct(size_t size,
				      unsigned int alignment,
				      const std::vector<vaddr_t>& member,
				      vaddr_t addr) {
  print_debug("alloc_type_struct size:%ld, alignment:%d, addr:%016" PRIx64 "\n",
	      size, alignment, addr);
  // 空きアドレスの検索
  addr = assign_addr(type_store_map, type_reserved,
		     static_cast<vaddr_t>(AddrType::AD_TYPE),
		     &last_free[static_cast<vaddr_t>(AddrType::AD_TYPE) >> 60],
		     addr);

  return type_store_map.insert
    (std::make_pair(addr, TypeStore(addr, size, alignment, member))).first->second;
}

// メモリ空間に配列型領域を確保する。
TypeStore& VMemory::alloc_type_vector(uint64_t size,
				      unsigned int alignment,
				      vaddr_t element,
				      unsigned int num,
				      vaddr_t addr) {
  print_debug("alloc_type_vector size:%" PRIx64 ", alignment:%d, element:%016" PRIx64
	      ", num:%d, addr:%016" PRIx64 "\n",
	      size, alignment, element, num, addr);
  // 空きアドレスの検索
  addr = assign_addr(type_store_map, type_reserved,
		     static_cast<vaddr_t>(AddrType::AD_TYPE),
		     &last_free[static_cast<vaddr_t>(AddrType::AD_TYPE) >> 60],
		     addr);

  return type_store_map.insert
    (std::make_pair(addr, TypeStore(addr, TypeKind::TK_VECTOR, size, alignment, element, num))).
    first->second;
}

// 指定されたデータ領域を開放する。
void VMemory::free(vaddr_t addr) {
  if (addr != VADDR_NULL) {
    // アドレスが領域の先頭でなかったり、存在しないアドレスの場合、セグメンテーションフォルト
    if (addr != get_addr_upper(addr) ||
	data_store_map.find(addr) == data_store_map.end()) {
      throw_error_message(Error::SEGMENT_FAULT, Util::vaddr2str(addr));
    }
    // 開放
    data_store_map.erase(addr);
  }
}

// アドレスのupper部分を取り出す。
vaddr_t VMemory::get_addr_upper(vaddr_t addr) {
  return addr & UPPER_MASKS[addr >> 60];
}

// アドレスのlower部分を取り出す。
vaddr_t VMemory::get_addr_lower(vaddr_t addr) {
  return addr & (~UPPER_MASKS[addr >> 60]);
}

// 現在管理しているアドレスすべての集合を作成する。
std::set<vaddr_t> VMemory::get_alladdr() {
  std::set<vaddr_t> all;
  
  for (auto it = data_store_map.begin(); it != data_store_map.end(); it ++) {
    all.insert(it->first);
  }
  for (auto it = func_store_map.begin(); it != func_store_map.end(); it ++) {
    all.insert(it->first);
  }
  for (auto it = type_store_map.begin(); it != type_store_map.end(); it ++) {
    all.insert(it->first);
  }

  return all;
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

// データアドレスを予約する。
void VMemory::reserve_data_addr(vaddr_t addr) {
  assert(data_reserved.find(addr) == data_reserved.end());

  data_reserved.insert(addr);
}

// 関数のアドレスを予約する。
vaddr_t VMemory::reserve_func_addr() {
  // 空きアドレスの検索
  vaddr_t addr = assign_addr(func_store_map, func_reserved,
			     static_cast<vaddr_t>(AddrType::AD_FUNCTION),
			     &last_free[static_cast<vaddr_t>(AddrType::AD_FUNCTION) >> 60],
			     VADDR_NON);
  func_reserved.insert(addr);

  return addr;
}
