
#include <cassert>
#include <vector>

#include "builtin_warp.hpp"
#include "process.hpp"

namespace processwarp {

// this function register function that will be called at after warp.
BuiltinPostProc::Type BuiltinWarp::at_after_warp(Process& proc, Thread& thread,
                                                 BuiltinFuncParam p, vaddr_t dst,
                                                 std::vector<uint8_t>& src) {
  int seek = 0;
  vaddr_t func = Process::read_builtin_param_ptr(src, &seek);
  assert(static_cast<signed>(src.size()) == seek);

  thread.funcs_at_after_warp.push_back(func);

  thread.memory->write<vm_int_t>(dst, 0);

  return BuiltinPostProc::NORMAL;
}

// This function register function that will be called at befor warp.
BuiltinPostProc::Type BuiltinWarp::at_befor_warp(Process& proc, Thread& thread,
                                                 BuiltinFuncParam p, vaddr_t dst,
                                                 std::vector<uint8_t>& src) {
  int seek = 0;
  vaddr_t func = Process::read_builtin_param_ptr(src, &seek);
  assert(static_cast<signed>(src.size()) == seek);

  thread.funcs_at_befor_warp.push_back(func);

  thread.memory->write<vm_int_t>(dst, 0);

  return BuiltinPostProc::NORMAL;
}

// This function check to warp is requested.
BuiltinPostProc::Type BuiltinWarp::poll_warp_request(Process& proc, Thread& thread,
                                                     BuiltinFuncParam p, vaddr_t dst,
                                                     std::vector<uint8_t>& src) {
  assert(static_cast<signed>(src.size()) == 0);

  if (thread.status == Thread::WAIT_WARP) {
    thread.warp_stack_size = thread.stackinfos.size();
    thread.warp_call_count = 0;
    thread.status = Thread::BEFOR_WARP;
    thread.get_stackinfo(-1).pc++;

    return BuiltinPostProc::RE_ENTRY;

  } else {
    return BuiltinPostProc::NORMAL;
  }
}

// This function set a parameter to warp function.
BuiltinPostProc::Type BuiltinWarp::set_processwarp_param(Process& proc, Thread& thread,
                                                         BuiltinFuncParam p, vaddr_t dst,
                                                         std::vector<uint8_t>& src) {
  int seek = 0;
  vm_uint_t key = Process::read_builtin_param_i(src, &seek);
  vm_uint_t val = Process::read_builtin_param_i(src, &seek);
  assert(static_cast<signed>(src.size()) == seek);

  /// @todo validate key & val.
  thread.warp_parameter[static_cast<vm_int_t>(key)] = static_cast<vm_int_t>(val);

  thread.memory->write<vm_int_t>(dst, 0);

  return BuiltinPostProc::NORMAL;
}

// This function register library functions in virtual machine.
void BuiltinWarp::regist(VMachine& vm) {
  vm.regist_builtin_func("pw_at_befor_warp", BuiltinWarp::at_befor_warp, 0);
  vm.regist_builtin_func("pw_at_after_warp", BuiltinWarp::at_after_warp, 0);
  vm.regist_builtin_func("pw_poll_warp_request", BuiltinWarp::poll_warp_request, 0);
  vm.regist_builtin_func("pw_set_processwarp_param", BuiltinWarp::set_processwarp_param, 0);
}
}  // namespace processwarp
