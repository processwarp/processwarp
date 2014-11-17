
#include <cassert>

#include "value.hpp"
#include "util.hpp"

using namespace usagi;

// コンストラクタ。
Value::Value() :
  type(NORMAL_DATA) {
  inner_value.immediate.value.i64 = 0;
  cache = &inner_value.immediate;
}

/*
// 値の比較を行う。
int Value::compare(const Value& target) const {
  // 呼ばれない
  assert(false);

  return 0;
}

// 変数のコピーを作成する。
vaddr_t Value::copy(VMemory& vmemory, vaddr_t dst) const {
  // 呼ばれない
  assert(false);

  return VADDR_NON;
}

// 型の比較を行う。
int Value::type_compare(const Value& target) const {
  return static_cast<int>(type) - static_cast<int>(target.type);
}
//*/
