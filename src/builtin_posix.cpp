
#include <cassert>
#include <cinttypes>
#include <cstring>

#include "builtin_posix.hpp"
#include "process.hpp"
#include "std_error.hpp"

using namespace processwarp;

// __assert_fail(assertの内部実装)関数。
BuiltinPost BuiltinPosix::bi_assert_fail(Process& proc, Thread& thread, BuiltinFuncParam p,
					 vaddr_t dst, std::vector<uint8_t>& src) {
  // パタメタを読み取り
  int seek = 0;
  vaddr_t p_assertion = Process::read_builtin_param_ptr(src, &seek);
  vaddr_t p_file = Process::read_builtin_param_ptr(src, &seek);
  vm_int_t p_line = static_cast<vm_int_t>(Process::read_builtin_param_i(src, &seek));
  vaddr_t p_func = Process::read_builtin_param_ptr(src, &seek);
  
  // メッセージを出力
  std::cerr << "Assertion failed: (" << reinterpret_cast<const char*>(thread.memory->get_raw(p_assertion))
	    << "), function " << reinterpret_cast<const char*>(thread.memory->get_raw(p_func))
	    << ", file " << reinterpret_cast<const char*>(thread.memory->get_raw(p_file))
	    << ", line " << p_line << "." << std::endl;
  
  // VMを異常終了させる
  thread.status = Thread::ERROR;

  return BP_RE_ENTRY;
}

// Implement for pthread_create.
BuiltinPost BuiltinPosix::bi_pthread_create(Process& proc, Thread& thread, BuiltinFuncParam p,
					    vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  vaddr_t p_thread = Process::read_builtin_param_ptr(src, &seek);
  // TODO: apply attr
  /*vaddr_t p_attr   =*/Process::read_builtin_param_ptr(src, &seek);
  vaddr_t p_start  = Process::read_builtin_param_ptr(src, &seek);
  vaddr_t p_arg    = Process::read_builtin_param_ptr(src, &seek);
  assert(static_cast<signed>(src.size()) == seek);
  
  thread.memory->set<vtid_t>(p_thread, proc.create_thread(p_start, p_arg));
  thread.memory->set<vm_int_t>(dst, 0);
  
  return BP_NORMAL;
}

// Implement for pthread_exit.
BuiltinPost BuiltinPosix::bi_pthread_exit(Process& proc, Thread& thread, BuiltinFuncParam p,
					  vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  vaddr_t p_retval = Process::read_builtin_param_ptr(src, &seek);
  assert(static_cast<signed>(src.size()) == seek);
 
  proc.exit_thread(thread, p_retval);

  return BP_RE_ENTRY;
}

// Implement for pthread_join.
BuiltinPost BuiltinPosix::bi_pthread_join(Process& proc, Thread& thread, BuiltinFuncParam p,
					  vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  vtid_t  p_thread = Process::read_builtin_param_ptr(src, &seek);
  vaddr_t p_retval = Process::read_builtin_param_ptr(src, &seek);
  assert(static_cast<signed>(src.size()) == seek);
  //vm_int_t& ret = *reinterpret_cast<vm_int_t*>(proc.get_raw_addr(dst));
  
  try {
    thread.memory->set<vm_int_t>(dst, 0);
    if (proc.join_thread(thread.tid, p_thread, p_retval)) {
      return BP_NORMAL;

    } else {
      return BP_RETRY_LATER;
    }

  } catch(StdError& e) {
    thread.memory->set<vm_int_t>(dst, e.std_errno);
    return BP_NORMAL;
  }
}

// VMにライブラリを登録する。
void BuiltinPosix::regist(VMachine& vm) {
  vm.regist_builtin_func("__assert_fail", BuiltinPosix::bi_assert_fail, 0);
  vm.regist_builtin_func("pthread_create", BuiltinPosix::bi_pthread_create, 0);
  vm.regist_builtin_func("pthread_exit", BuiltinPosix::bi_pthread_exit, 0);
  vm.regist_builtin_func("pthread_join", BuiltinPosix::bi_pthread_join, 0);
}

