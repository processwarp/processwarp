
#include "intrinsic_memory.hpp"
#include "vmachine.hpp"

using namespace usagi;

// llvm.lifetime.start関数。
void IntrinsicMemory::lifetime_start(VMachine& vm, Thread& th, IntrinsicFuncParam p,
				     vaddr_t dst, std::vector<uint8_t>& src) {
  // 何もしない
}

// llvm.lifetime.end関数。
void IntrinsicMemory::lifetime_end(VMachine& vm, Thread& th, IntrinsicFuncParam p,
				   vaddr_t dst, std::vector<uint8_t>& src) {
  // 何もしない
}

// llvm.invariant.start関数。
void IntrinsicMemory::invariant_start(VMachine& vm, Thread& th, IntrinsicFuncParam p,
				      vaddr_t dst, std::vector<uint8_t>& src) {
  // 何もしない
}

// llvm.invariant.end関数。
void IntrinsicMemory::invariant_end(VMachine& vm, Thread& th, IntrinsicFuncParam p,
				    vaddr_t dst, std::vector<uint8_t>& src) {
  // 何もしない
}

// VMにライブラリを登録する。
void IntrinsicMemory::regist(VMachine& vm) {
  vm.regist_intrinsic_func("llvm.lifetime.start", IntrinsicMemory::lifetime_start, 0);
  vm.regist_intrinsic_func("llvm.lifetime.end",   IntrinsicMemory::lifetime_end, 0);

  vm.regist_intrinsic_func("llvm.invariant.start", IntrinsicMemory::invariant_start, 0);
  vm.regist_intrinsic_func("llvm.invariant.end",   IntrinsicMemory::invariant_end, 0);
}
