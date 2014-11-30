
#include <cassert>
#include <cstring>

#include "value.hpp"
#include "vmemory.hpp"
#include "util.hpp"

using namespace usagi;

// コンストラクタ。
Value::Value() :
  type(NORMAL_DATA) {
  memset(&inner_value, 0, sizeof(inner_value));
  cache = &inner_value.immediate.value;
}

// コピーコンストラクタ。
Value::Value(const Value& src) :
  type(src.type),
  inner_value(src.inner_value) {

  if (src.is_immediate()) {
    cache = &inner_value.immediate.value;
  } else {
    cache = src.cache;
  }
}

// =演算子。
Value& Value::operator=(const Value& src) {
  type = src.type;
  inner_value = src.inner_value;

  if (src.is_immediate()) {
    cache = &inner_value.immediate.value;
  } else {
    cache = src.cache;
  }

  return *this;
}

// 値のアドレスを設定する。
void Value::set_address(vaddr_t addr) {
  inner_value.address.upper = VMemory::get_addr_upper(addr);
  inner_value.address.lower = VMemory::get_addr_lower(addr);
  cache = nullptr;
}
