
#include <cassert>

#include "convert.hpp"
#include "thread.hpp"

using namespace processwarp;

// Constructor with thread-id.
Thread::Thread(vtid_t tid_, std::unique_ptr<VMemory::Accessor> memory_) :
  tid(tid_),
  memory(std::move(memory_)),
  complex_operator(*memory),
  warp_stack_size(0),
  warp_call_count(0),
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

// Allocate thread on memory.
std::pair<vtid_t, std::unique_ptr<Thread>>
	Thread::alloc(std::unique_ptr<VMemory::Accessor> memory, vtid_t tid) {
  picojson::object js_thread;
  
  js_thread.insert(std::make_pair("tid", Convert::vtid2json(tid)));
  js_thread.insert(std::make_pair("status", Convert::int2json<uint8_t>(NORMAL)));
  js_thread.insert(std::make_pair("join_waiting", Convert::vtid2json(JOIN_WAIT_NONE)));
  
  std::string str_thread = picojson::value(js_thread).serialize();
  tid = memory->set_meta_area(str_thread, tid);

  return std::make_pair(tid, Thread::read(tid, std::move(memory)));
}

// Read out thread information from memory.
std::unique_ptr<Thread> Thread::read(vtid_t tid,
				     std::unique_ptr<VMemory::Accessor> memory) {
  std::unique_ptr<Thread> thread(new Thread(tid, std::move(memory)));
  thread->update_info();

  return thread;
}

// Read out and update thread information on instance.
void Thread::update_info() {
  picojson::value js_tmp;
  std::istringstream is(memory->get_meta_area(tid));
  std::string err = picojson::parse(js_tmp, is);
  if (!err.empty()) {
    /// TODO:error
    assert(false);
  }
  picojson::object& js_thread = js_tmp.get<picojson::object>();

  status = static_cast<Status>(Convert::json2int<uint8_t>(js_thread.at("status")));
  join_waiting = Convert::json2vtid(js_thread.at("join_waiting"));
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
