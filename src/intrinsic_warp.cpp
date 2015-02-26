
#include "intrinsic_warp.hpp"
#include "vmachine.hpp"

using namespace usagi;

// This function register function that will be called at after warp.
bool IntrinsicWarp::at_after_warp(VMachine& vm, Thread& th, IntrinsicFuncParam p,
				  vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  vaddr_t func = VMachine::read_intrinsic_param_ptr(src, &seek);
  // Size of src must be same as parameter read.
  assert(static_cast<signed>(src.size()) == seek);

  th.funcs_at_after_warp.push_back(func);

  *reinterpret_cast<vm_int_t*>(vm.get_raw_addr(dst)) = 0;
  return false;
}

// This function register function that will be called at befor warp.
bool IntrinsicWarp::at_befor_warp(VMachine& vm, Thread& th, IntrinsicFuncParam p,
				  vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  vaddr_t func = VMachine::read_intrinsic_param_ptr(src, &seek);
  // Size of src must be same as parameter read.
  assert(static_cast<signed>(src.size()) == seek);

  th.funcs_at_befor_warp.push_back(func);

  *reinterpret_cast<vm_int_t*>(vm.get_raw_addr(dst)) = 0;
  return false;
}

// This function check to warp is requested.
bool IntrinsicWarp::poll_warp_request(VMachine& vm, Thread& th, IntrinsicFuncParam p,
				      vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  // Size of src must be same as parameter read.
  assert(static_cast<signed>(src.size()) == seek);

  if (vm.status == VMachine::WAIT_WARP) {
    vm.warp_stack_size = th.stackinfos.size();
    vm.warp_call_count = 0;
    vm.status = VMachine::BEFOR_WARP;
    th.stackinfos.back()->pc ++;
    return true;
    
  } else {
    return false;
  }
}

// This function register library functions in virtual machine.
void IntrinsicWarp::regist(VMachine& vm) {
  vm.regist_intrinsic_func("at_befor_warp", IntrinsicWarp::at_befor_warp, 0);
  vm.regist_intrinsic_func("at_after_warp", IntrinsicWarp::at_after_warp, 0);
  vm.regist_intrinsic_func("poll_warp_request", IntrinsicWarp::poll_warp_request, 0);
  vm.regist_intrinsic_func("set_processwarp_param", IntrinsicWarp::set_processwarp_param, 0);
}

// This function set a parameter to warp function.
bool IntrinsicWarp::set_processwarp_param(VMachine& vm, Thread& th, IntrinsicFuncParam p,
					  vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  int64_t key = static_cast<int64_t>(VMachine::read_intrinsic_param_i64(src, &seek));
  int64_t val = static_cast<int64_t>(VMachine::read_intrinsic_param_i64(src, &seek));
  // Size of src must be same as parameter read.
  assert(static_cast<signed>(src.size()) == seek);

  // TODO validate key & val.
  th.warp_parameter[key] = val;
  
  *reinterpret_cast<vm_int_t*>(vm.get_raw_addr(dst)) = 0;
  return false;
}
