
#include <cassert>

#include "builtin_warp.hpp"
#include "process.hpp"

using namespace processwarp;

// This function register function that will be called at after warp.
BuiltinPost BuiltinWarp::at_after_warp(Process& proc, Thread& thread, BuiltinFuncParam p,
				       vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  vaddr_t func = Process::read_builtin_param_ptr(src, &seek);
  assert(static_cast<signed>(src.size()) == seek);

  thread.funcs_at_after_warp.push_back(func);

  thread.memory->set<vm_int_t>(dst, 0);

  return BP_NORMAL;
}

// This function register function that will be called at befor warp.
BuiltinPost BuiltinWarp::at_befor_warp(Process& proc, Thread& thread, BuiltinFuncParam p,
				       vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  vaddr_t func = Process::read_builtin_param_ptr(src, &seek);
  assert(static_cast<signed>(src.size()) == seek);

  thread.funcs_at_befor_warp.push_back(func);

  thread.memory->set<vm_int_t>(dst, 0);

  return BP_NORMAL;
}

// This function check to warp is requested.
BuiltinPost BuiltinWarp::poll_warp_request(Process& proc, Thread& thread, BuiltinFuncParam p,
					   vaddr_t dst, std::vector<uint8_t>& src) {
  //int seek = 0;
  assert(static_cast<signed>(src.size()) == 0);

  if (thread.status == Thread::WAIT_WARP) {
    thread.warp_stack_size = thread.stackinfos.size();
    thread.warp_call_count = 0;
    thread.status = Thread::BEFOR_WARP;
    thread.stackinfos.back()->pc ++;

    return BP_RE_ENTRY;
    
  } else {
    return BP_NORMAL;
  }
}

// This function set a parameter to warp function.
BuiltinPost BuiltinWarp::set_processwarp_param(Process& proc, Thread& thread, BuiltinFuncParam p,
					       vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  vm_int_t key = static_cast<vm_int_t>(Process::read_builtin_param_i(src, &seek));
  vm_int_t val = static_cast<vm_int_t>(Process::read_builtin_param_i(src, &seek));
  assert(static_cast<signed>(src.size()) == seek);

  /// TODO:validate key & val.
  thread.warp_parameter[key] = val;
  
  thread.memory->set<vm_int_t>(dst, 0);

  return BP_NORMAL;
}

// This function register library functions in virtual machine.
void BuiltinWarp::regist(VMachine& vm) {
  vm.regist_builtin_func("at_befor_warp", BuiltinWarp::at_befor_warp, 0);
  vm.regist_builtin_func("at_after_warp", BuiltinWarp::at_after_warp, 0);
  vm.regist_builtin_func("poll_warp_request", BuiltinWarp::poll_warp_request, 0);
  vm.regist_builtin_func("set_processwarp_param", BuiltinWarp::set_processwarp_param, 0);
}
