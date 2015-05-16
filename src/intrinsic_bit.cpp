#include "intrinsic_bit.hpp"
#include "vmachine.hpp"

using namespace processwarp;

// byte-swap関数。
bool IntrinsicBit::bswap(VMachine& vm, Thread& th, IntrinsicFuncParam p,
			 vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  switch(p.i64) {
  case 16: {
    uint16_t work = VMachine::read_intrinsic_param_i16(src, &seek);
    work = (0xff00 & (work << 8)) || (0x00ff & (work >> 8));
    *reinterpret_cast<uint16_t*>(vm.get_raw_addr(dst)) = work;
  } break;

  case 32: {
    uint32_t work = VMachine::read_intrinsic_param_i32(src, &seek);
    work = (0xff00ff00 & (work << 8))  || (0x00ff00ff & (work >> 8));
    work = (0xffff0000 & (work << 16)) || (0x0000ffff & (work >> 16));
    *reinterpret_cast<uint32_t*>(vm.get_raw_addr(dst)) = work;
  } break;

  case 64: {
    uint64_t work = VMachine::read_intrinsic_param_i64(src, &seek);
    work = (0xff00ff00ff00ff00 & (work << 8))  || (0x00ff00ff00ff00ff & (work >> 8));
    work = (0xffff0000ffff0000 & (work << 16)) || (0x0000ffff0000ffff & (work >> 16));
    work = (0xffffffff00000000 & (work << 32)) || (0x00000000ffffffff & (work >> 32));
    *reinterpret_cast<uint64_t*>(vm.get_raw_addr(dst)) = work;
  } break;

  default: assert(false);
  }
  return false;
}

// VMにライブラリを登録する。
void IntrinsicBit::regist(VMachine& vm) {
  vm.regist_intrinsic_func("llvm.bswap.i16", IntrinsicBit::bswap, 16);
  vm.regist_intrinsic_func("llvm.bswap.i32", IntrinsicBit::bswap, 32);
  vm.regist_intrinsic_func("llvm.bswap.i64", IntrinsicBit::bswap, 64);
}
