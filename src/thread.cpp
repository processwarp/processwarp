
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
  js_thread.insert(std::make_pair("stack", picojson::value(picojson::array())));
  js_thread.insert(std::make_pair("funcs_at_befor_warp",
				  picojson::value(picojson::array())));
  js_thread.insert(std::make_pair("funcs_at_after_warp",
				  picojson::value(picojson::array())));
  js_thread.insert(std::make_pair("warp_parameter",
				  picojson::value(picojson::object())));
  
  std::string str_thread = picojson::value(js_thread).serialize();
  tid = memory->set_meta_area(str_thread, tid);

  return std::make_pair(tid, Thread::read(tid, std::move(memory)));
}

// Read out thread information from memory.
std::unique_ptr<Thread> Thread::read(vtid_t tid,
				     std::unique_ptr<VMemory::Accessor> memory) {
  std::unique_ptr<Thread> thread(new Thread(tid, std::move(memory)));
  thread->read();

  return thread;
}

// Read out and update thread information on instance.
void Thread::read() {
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
  stack = Convert::json2vaddr_vector(js_thread.at("stack"));
  funcs_at_befor_warp = Convert::json2vaddr_vector(js_thread.at("funcs_at_befor_warp"));
  funcs_at_after_warp = Convert::json2vaddr_vector(js_thread.at("funcs_at_after_warp"));
  warp_parameter.clear();
  for(auto& it : js_thread.at("warp_parameter").get<picojson::object>()) {
    warp_parameter.insert(std::make_pair(Convert::str2int<vm_int_t>(it.first),
					 Convert::json2int<vm_int_t>(it.second)));
  }
}

// Write out thread information to memory.
void Thread::write() {
  picojson::object js_thread;

  js_thread.insert(std::make_pair("tid", Convert::vtid2json(tid)));
  js_thread.insert(std::make_pair("status", Convert::int2json<uint8_t>(status)));
  js_thread.insert(std::make_pair("join_waiting", Convert::vtid2json(join_waiting)));
  js_thread.insert(std::make_pair("stack", Convert::vaddr_vector2json(stack)));
  js_thread.insert(std::make_pair("funcs_at_befor_warp",
				  Convert::vaddr_vector2json(funcs_at_befor_warp)));
  js_thread.insert(std::make_pair("funcs_at_after_warp",
				  Convert::vaddr_vector2json(funcs_at_after_warp)));
  picojson::object js_warp_parameter;
  for (auto &it : warp_parameter) {
    js_warp_parameter.insert(std::make_pair(Convert::int2str<vm_int_t>(it.first),
					    Convert::int2json<vm_int_t>(it.second)));
  }
  js_thread.insert(std::make_pair("warp_parameter", picojson::value(js_warp_parameter)));

  for (auto& it : stack) {
    auto it_stackinfo = stackinfos.find(it);
    if (it_stackinfo != stackinfos.end()) {
      it_stackinfo->second->write(*memory);
    }
  }
  
  memory->update_meta_area(tid, picojson::value(js_thread).serialize());
}

// 型依存の演算インスタンスを取得する。
WrappedOperator* Thread::get_operator(vaddr_t type) {
  // 複合型に対する演算命令
  if ((type & TY_MASK) <
      static_cast<uintmax_t>(sizeof(OPERATORS) / sizeof(OPERATORS[0]))) {
    // 存在する基本型の場合、OPERTORSからインスタンスを取得
    assert(OPERATORS[type & TY_MASK] != nullptr);
    return OPERATORS[type & TY_MASK];
    
  } else {
    // 複合型の場合、complex_operatorを使う。
    complex_operator.type_store = std::move(TypeStore::read(*memory, type));
    return &complex_operator;
  }
}

// Get stack-information by virtual-address.
StackInfo& Thread::get_stackinfo(int idx) {
  if (idx < 0) {
    idx = stack.size() + idx;
  }
  vaddr_t addr = stack.at(idx);
  auto it_stackinfo = stackinfos.find(addr);
  if (it_stackinfo == stackinfos.end()) {
    return *stackinfos.insert
      (std::make_pair(addr,
		      StackInfo::read(*memory, addr))).first->second;

  } else {
    StackInfo& stackinfo = *it_stackinfo->second;
    return stackinfo;
  }
}

// Remoev stack-information at stack top.
void Thread::pop_stack() {
  get_stackinfo(-1).destroy(*memory);
  stackinfos.erase(stack.back());
  memory->free(stack.back());
  stack.pop_back();
}

// Push new stack-information at stack top (without instance).
void Thread::push_stack(vaddr_t addr) {
  stack.push_back(addr);
}

// Push new stack-information at stack top (with instance).
void Thread::push_stack(vaddr_t addr, std::unique_ptr<StackInfo> top) {
  stack.push_back(addr);
  stackinfos.insert(std::make_pair(addr, std::move(top)));
}

// Prepare to warp out.
void Thread::setup_warpout() {
  warp_stack_size = stack.size();
  warp_call_count = 0;

  status = AFTER_WARP;
}

// Prepare to warp in.
bool Thread::setup_warpin(const dev_id_t& dst_device) {
  if (status == BEFOR_WARP || status == WAIT_WARP) {
    warp_dst = dst_device;
    return true;

  } else if (status != NORMAL) {
    // Status must be normal when warp.
    return false;
  }

  if (warp_parameter[PW_KEY_WARP_TIMING] == PW_VAL_ON_ANYTIME) {
    warp_stack_size = stack.size();
    warp_call_count = 0;
    status = BEFOR_WARP;

  } else { // On polling.
    status = WAIT_WARP;
  }

  warp_dst = dst_device;
  
  return true;
}
