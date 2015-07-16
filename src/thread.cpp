
#include <cassert>

#include "thread.hpp"

using namespace processwarp;

// Constructor with thread-id.
Thread::Thread(vtid_t tid_, std::unique_ptr<VMemory::Accessor> memory_) :
  tid(tid_),
  status(NORMAL),
  memory(std::move(memory_)),
  warp_stack_size(0),
  warp_call_count(0),
  join_waiting(JOIN_NONE),
  complex_operator(*memory),
  OPERATORS {
    nullptr, // 0
    nullptr, // 1 void
    new WrappedPointerOperator(*memory), // 2 pointer
    nullptr, // 3 function
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr, // 10
    new WrappedPrimitiveOperator<uint8_t>(*memory), // 11 8bit整数型
    new WrappedPrimitiveOperator<uint16_t>(*memory), // 12 16bit整数型
    new WrappedPrimitiveOperator<uint32_t>(*memory), // 13 32bit整数型
    new WrappedPrimitiveOperator<uint64_t>(*memory), // 14 64bit整数型
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr, // 20
    new WrappedPrimitiveOperator<int8_t>(*memory), // 21 8bit整数型
    new WrappedPrimitiveOperator<int16_t>(*memory), // 22 16bit整数型
    new WrappedPrimitiveOperator<int32_t>(*memory), // 23 32bit整数型
    new WrappedPrimitiveOperator<int64_t>(*memory), // 24 64bit整数型
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr,
    nullptr, // 30
    nullptr, // 31
    new WrappedPrimitiveOperator<float>(*memory), // 32 float
    new WrappedPrimitiveOperator<double>(*memory), // 33 double
    nullptr, // 34
    nullptr, // 35 quad
    } {
}

// 型依存の演算インスタンスを取得する。
WrappedOperator* Thread::get_operator(vaddr_t type) {
  // 複合型に対する演算命令
  if (type < sizeof(OPERATORS) / sizeof(OPERATORS[0])) {
    // 存在する基本型の場合、OPERTORSからインスタンスを取得
    assert(OPERATORS[type] != nullptr);
    return OPERATORS[type];
    
  } else {
    // 複合型の場合、complex_operatorを使う。
    complex_operator.type_store = std::move(TypeStore::read(*memory, type));
    return &complex_operator;
  }
}
