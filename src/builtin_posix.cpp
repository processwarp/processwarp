
#include <cassert>
#include <cinttypes>
#include <cstring>

#include "builtin_posix.hpp"
#include "vmachine.hpp"

using namespace processwarp;

// __assert_fail(assertの内部実装)関数。
bool BuiltinPosix::__assert_fail(VMachine& vm, Thread& th, BuiltinFuncParam p,
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
  vm.status = VMachine::ERROR;
  return true;
}

// VMにライブラリを登録する。
void BuiltinPosix::regist(VMachine& vm) {
  vm.regist_builtin_func("__assert_fail", BuiltinPosix::__assert_fail, 0);
}
