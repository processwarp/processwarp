
#include <cassert>
#include <cinttypes>
#include <cstring>

#include "builtin_posix.hpp"
#include "std_error.hpp"
#include "vmachine.hpp"

using namespace processwarp;

// __assert_fail(assertの内部実装)関数。
BuiltinPost BuiltinPosix::__assert_fail(VMachine& vm, Thread& th, BuiltinFuncParam p,
				 vaddr_t dst, std::vector<uint8_t>& src) {
  // パタメタを読み取り
  int seek = 0;
  vaddr_t p_assertion = VMachine::read_builtin_param_ptr(src, &seek);
  vaddr_t p_file = VMachine::read_builtin_param_ptr(src, &seek);
  uint32_t p_line = static_cast<unsigned>(VMachine::read_builtin_param_i32(src, &seek));
  vaddr_t p_func = VMachine::read_builtin_param_ptr(src, &seek);
  
  // メッセージを出力
  std::cerr << "Assertion failed: (" << reinterpret_cast<const char*>(vm.get_raw_addr(p_assertion))
	    << "), function " << reinterpret_cast<const char*>(vm.get_raw_addr(p_func))
	    << ", file " << reinterpret_cast<const char*>(vm.get_raw_addr(p_file))
	    << ", line " << p_line << "." << std::endl;
  
  // VMを異常終了させる
  th.status = Thread::ERROR;

  return BP_RE_ENTRY;
}

// Implement for pthread_create.
BuiltinPost BuiltinPosix::pthread_create(VMachine& vm, Thread& th, BuiltinFuncParam p,
				vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  vaddr_t p_thread = VMachine::read_builtin_param_ptr(src, &seek);
  // TODO: apply attr
  /*vaddr_t p_attr   =*/VMachine::read_builtin_param_ptr(src, &seek);
  vaddr_t p_start  = VMachine::read_builtin_param_ptr(src, &seek);
  vaddr_t p_arg    = VMachine::read_builtin_param_ptr(src, &seek);
  assert(static_cast<signed>(src.size()) == seek);
  
  *reinterpret_cast<vtid_t*>(vm.get_raw_addr(p_thread)) = 
    vm.create_thread(p_start, p_arg);

  *reinterpret_cast<vm_int_t*>(vm.get_raw_addr(dst)) = 0;
  
  return BP_NORMAL;
}

// Implement for pthread_exit.
BuiltinPost BuiltinPosix::pthread_exit(VMachine& vm, Thread& th, BuiltinFuncParam p,
				vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  vaddr_t p_retval = VMachine::read_builtin_param_ptr(src, &seek);
  assert(static_cast<signed>(src.size()) == seek);
 
  // vm.exit_thread(th.tid, p_retval);

  return BP_RE_ENTRY;
}

// Implement for pthread_join.
BuiltinPost BuiltinPosix::pthread_join(VMachine& vm, Thread& th, BuiltinFuncParam p,
				vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  vtid_t  p_thread = VMachine::read_builtin_param_i32(src, &seek);
  vaddr_t p_retval = VMachine::read_builtin_param_ptr(src, &seek);
  assert(static_cast<signed>(src.size()) == seek);
  vm_int_t& ret = *reinterpret_cast<vm_int_t*>(vm.get_raw_addr(dst));
  
  try {
    ret = 0;
    if (vm.join_thread(th.tid, p_thread, p_retval)) {
      return BP_NORMAL;

    } else {
      return BP_RETRY_LATER;
    }

  } catch(StdError& e) {
    ret = e.std_errno;
    return BP_NORMAL;
  }
}

// VMにライブラリを登録する。
void BuiltinPosix::regist(VMachine& vm) {
  vm.regist_builtin_func("__assert_fail", BuiltinPosix::__assert_fail, 0);
  vm.regist_builtin_func("pthread_create", BuiltinPosix::pthread_create, 0);
  vm.regist_builtin_func("pthread_exit", BuiltinPosix::pthread_exit, 0);
  vm.regist_builtin_func("pthread_join", BuiltinPosix::pthread_join, 0);
}

