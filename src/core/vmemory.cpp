
#include <iostream>

#include "error.hpp"
#include "util.hpp"
#include "vmemory.hpp"

using namespace usagi;

// コンストラクタ。
VMemory::VMemory() {
  for (unsigned int i = 0; i < sizeof(last_free) / sizeof(last_free[0]); i ++)
    last_free[i] = 1;
}

// メモリ空間に新しいデータ領域を確保する。
VMemory::AllocDataRet VMemory::alloc_data(size_t size, bool is_const, vaddr_t addr) {
  // サイズからアドレスタイプを判定する
  vaddr_t log8;
  if      (size < (static_cast<vaddr_t>(1) <<  8)) log8 = 1;
  else if (size < (static_cast<vaddr_t>(1) << 16)) log8 = 2;
  else if (size < (static_cast<vaddr_t>(1) << 24)) log8 = 3;
  else if (size < (static_cast<vaddr_t>(1) << 32)) log8 = 4;
  else if (size < (static_cast<vaddr_t>(1) << 40)) log8 = 5;
  else if (size < (static_cast<vaddr_t>(1) << 48)) log8 = 6;
  else throw_error(Error::OUT_OF_MEMORY);

  vaddr_t type = log8 << (sizeof(vaddr_t) * 8 - 4);
  if (addr != VADDR_NON) {
    // タイプが整合していること、アドレスが空いていること。
    if (type != (addr & AddrType::MASK) ||
	data_store_map.find(addr) != data_store_map.end())
      throw_error(Error::SPEC_VIOLATION);
    
  } else {
    // 新しいアドレスを割り当てる
    if (is_const) type |= AddrType::CONSTANT;
    vaddr_t* last_free = &(this->last_free[log8]);
    // 下位ビット数
    int lower_bit = log8 * 8;
    // 上位ビットの最大値 + 1(フラグ部分の4bitを除く)
    vaddr_t max_upper = static_cast<vaddr_t>(1) << (sizeof(vaddr_t) * 8 - 4 - lower_bit);
    
    // メモリ空間の空きアドレスを探す
    while (data_store_map.find(type | (*last_free << lower_bit)) != data_store_map.end()) {
      (*last_free) ++;
      if (*last_free >= max_upper)
	throw_error(Error::OUT_OF_MEMORY);
    }
    
    // アドレスとして、タイプ、上位アドレス、下位アドレス分の0を結合する。
    addr = type | (((*last_free) ++) << lower_bit);
  }
  
  return {addr, data_store_map.insert(std::make_pair(addr, DataStore(size))).first->second};
}

// メモリ空間に新しい関数領域を確保する。
VMemory::AllocFuncRet VMemory::alloc_func(vaddr_t addr) {
  vaddr_t type = static_cast<vaddr_t>(AddrType::FUNCTION);
  if (addr != VADDR_NON) {
    // タイプが整合していること、アドレスが空いていること。
    if (type != (addr & AddrType::MASK) ||
	func_store_map.find(addr) != func_store_map.end())
      throw_error(Error::SPEC_VIOLATION);
  
  } else {
    // 新しいアドレスを割り当てる
    vaddr_t* last_free = &(this->last_free[0]);
    
    // 最大値
    vaddr_t max = static_cast<vaddr_t>(1) << (sizeof(vaddr_t) * 8 - 4);
    
    // メモリ空間の空きアドレスを探す
    while (func_store_map.find(type | *last_free) != func_store_map.end()) {
      (*last_free) ++;
      if (*last_free >= max) throw_error(Error::OUT_OF_MEMORY);
    }
    
    // アドレスとして、タイプ、アドレスを結合する。
    addr = type | ((*last_free) ++);
  }

  return {addr, func_store_map.insert(std::make_pair(addr, FuncStore())).first->second};
}

// アドレスに対応する領域を取得する。
DataStore& VMemory::get_data(vaddr_t addr) {
  auto data = data_store_map.find(addr);

  if (data == data_store_map.end()) {
    // 検索失敗 = アクセス違反
    throw_error(Error::SEGMENT_FAULT);

  } else {
    return data->second;
  }
}

// アドレスに対応する関数領域を取得する。
FuncStore& VMemory::get_func(vaddr_t addr) {
  auto func = func_store_map.find(addr);

  if (func == func_store_map.end()) {
    // 検索失敗 = アクセス違反
    throw_error(Error::SEGMENT_FAULT);

  } else {
    return func->second;
  }
}











