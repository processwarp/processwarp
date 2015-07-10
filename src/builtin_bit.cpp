#include "builtin_bit.hpp"
#include "process.hpp"

using namespace processwarp;

// byte-swap関数。
BuiltinPost BuiltinBit::bswap(Process& proc, Thread& th, BuiltinFuncParam p,
			      vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  switch(p.i64) {
  case 16: {
    uint16_t work = Process::read_builtin_param_i16(src, &seek);
    work = (0xff00 & (work << 8)) || (0x00ff & (work >> 8));
    *reinterpret_cast<uint16_t*>(proc.get_raw_addr(dst)) = work;
  } break;

  case 32: {
    uint32_t work = Process::read_builtin_param_i32(src, &seek);
    work = (0xff00ff00 & (work << 8))  || (0x00ff00ff & (work >> 8));
    work = (0xffff0000 & (work << 16)) || (0x0000ffff & (work >> 16));
    *reinterpret_cast<uint32_t*>(proc.get_raw_addr(dst)) = work;
  } break;

  case 64: {
    uint64_t work = Process::read_builtin_param_i64(src, &seek);
    work = (0xff00ff00ff00ff00 & (work << 8))  || (0x00ff00ff00ff00ff & (work >> 8));
    work = (0xffff0000ffff0000 & (work << 16)) || (0x0000ffff0000ffff & (work >> 16));
    work = (0xffffffff00000000 & (work << 32)) || (0x00000000ffffffff & (work >> 32));
    *reinterpret_cast<uint64_t*>(proc.get_raw_addr(dst)) = work;
  } break;

  default: assert(false);
  }

  return BP_NORMAL;
}

// PROCにライブラリを登録する。
void BuiltinBit::regist(Process& vm) {
  vm.regist_builtin_func("llvm.bswap.i16", BuiltinBit::bswap, 16);
  vm.regist_builtin_func("llvm.bswap.i32", BuiltinBit::bswap, 32);
  vm.regist_builtin_func("llvm.bswap.i64", BuiltinBit::bswap, 64);
}
