
#include "func_store.hpp"
#include "stackinfo.hpp"

using namespace processwarp;

// コンストラクタ。
StackInfo::StackInfo(vaddr_t func_,
		     vaddr_t ret_addr_,
		     unsigned int normal_pc_,
		     unsigned int unwind_pc_,
		     vaddr_t stack_) :
  func(func_),
  ret_addr(ret_addr_),
  normal_pc(normal_pc_),
  unwind_pc(unwind_pc_),
  stack(stack_),
  var_arg(VADDR_NON),
  pc(0),
  phi0(0),
  phi1(0),
  type(VADDR_NON),
  output(VADDR_NON),
  value(VADDR_NON),
  address(VADDR_NON) {
}
