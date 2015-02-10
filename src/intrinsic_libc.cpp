
#include <cassert>
#include <cinttypes>
#include <cstring>

#include "intrinsic_libc.hpp"
#include "vmachine.hpp"

using namespace usagi;

// memcpy関数。
void IntrinsicLibc::memcpy(VMachine& vm, Thread& th, IntrinsicFuncParam p,
			   vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  // コピー先アドレスを取得
  vaddr_t p_dst = VMachine::read_intrinsic_param_ptr(src, &seek);
  // コピー元アドレスを取得
  vaddr_t p_src = VMachine::read_intrinsic_param_ptr(src, &seek);
  // コピーサイズを取得
  uint64_t p_size;
  switch(p.i64) {
  case 8:  p_size = static_cast<int64_t>(VMachine::read_intrinsic_param_i8 (src, &seek)); break;
  case 16: p_size = static_cast<int64_t>(VMachine::read_intrinsic_param_i16(src, &seek)); break;
  case 32: p_size = static_cast<int64_t>(VMachine::read_intrinsic_param_i32(src, &seek)); break;
  case 64: p_size = static_cast<int64_t>(VMachine::read_intrinsic_param_i64(src, &seek)); break;

  default: {
    print_debug("p.i64 %" PRIu64 "\n", p.i64);
    assert(false);
  } break;
  }
  // アライメントを取得
  /*int32_t p_align =*/VMachine::read_intrinsic_param_i32(src, &seek);
  // 実行順番の制約(VMでは実行順番を入れ替えないので無視する)を取得
  /*int8_t p_isvolation =*/VMachine::read_intrinsic_param_i8(src, &seek);

  // 読み込んだパラメタ長と渡されたパラメタ長は同じはず
  assert(static_cast<signed>(src.size()) == seek);
  std::memcpy(vm.get_raw_addr(p_dst),
	      vm.get_raw_addr(p_src),
	      static_cast<size_t>(p_size));
}

// memmove関数。
void IntrinsicLibc::memmove(VMachine& vm, Thread& th, IntrinsicFuncParam p,
			    vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  // コピー先アドレスを取得
  vaddr_t p_dst = VMachine::read_intrinsic_param_ptr(src, &seek);
  // コピー元アドレスを取得
  vaddr_t p_src = VMachine::read_intrinsic_param_ptr(src, &seek);
  // コピーサイズを取得
  uint64_t p_size;
  switch(p.i64) {
  case 8:  p_size = static_cast<int64_t>(VMachine::read_intrinsic_param_i8 (src, &seek)); break;
  case 16: p_size = static_cast<int64_t>(VMachine::read_intrinsic_param_i16(src, &seek)); break;
  case 32: p_size = static_cast<int64_t>(VMachine::read_intrinsic_param_i32(src, &seek)); break;
  case 64: p_size = static_cast<int64_t>(VMachine::read_intrinsic_param_i64(src, &seek)); break;

  default: {
    print_debug("p.i64 %" PRIu64 "\n", p.i64);
    assert(false);
  } break;
  }
  // アライメントを取得
  /*int32_t p_align =*/VMachine::read_intrinsic_param_i32(src, &seek);
  // 実行順番の制約(VMでは実行順番を入れ替えないので無視する)を取得
  /*int8_t p_isvolation =*/VMachine::read_intrinsic_param_i8(src, &seek);

  // 読み込んだパラメタ長と渡されたパラメタ長は同じはず
  assert(static_cast<signed>(src.size()) == seek);
  std::memmove(vm.get_raw_addr(p_dst),
	       vm.get_raw_addr(p_src),
	       static_cast<size_t>(p_size));
}

// memset関数。
void IntrinsicLibc::memset(VMachine& vm, Thread& th, IntrinsicFuncParam p,
			   vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  // 設定先先アドレスを取得
  vaddr_t p_dst = VMachine::read_intrinsic_param_ptr(src, &seek);
  // 設定値を取得
  uint8_t p_val = VMachine::read_intrinsic_param_i8(src, &seek);
  // 設定サイズを取得
  uint64_t p_len;
  switch(p.i64) {
  case 8:  p_len = static_cast<int64_t>(VMachine::read_intrinsic_param_i8 (src, &seek)); break;
  case 16: p_len = static_cast<int64_t>(VMachine::read_intrinsic_param_i16(src, &seek)); break;
  case 32: p_len = static_cast<int64_t>(VMachine::read_intrinsic_param_i32(src, &seek)); break;
  case 64: p_len = static_cast<int64_t>(VMachine::read_intrinsic_param_i64(src, &seek)); break;

  default: {
    print_debug("p.i64 %" PRIu64 "\n", p.i64);
    assert(false);
  } break;
  }
  // アライメントを取得
  /*int32_t p_align =*/VMachine::read_intrinsic_param_i32(src, &seek);
  // 実行順番の制約(VMでは実行順番を入れ替えないので無視する)を取得
  /*int8_t p_isvolation =*/VMachine::read_intrinsic_param_i8(src, &seek);
  
  // 読み込んだパラメタ長と渡されたパラメタ長は同じはず
  assert(static_cast<signed>(src.size()) == seek);
  std::memset(vm.get_raw_addr(p_dst), p_val, static_cast<size_t>(p_len));
}

// VMにライブラリを登録する。
void IntrinsicLibc::regist(VMachine& vm) {
  vm.regist_intrinsic_func("llvm.memcpy.p0i8.p0i8.i8",  IntrinsicLibc::memcpy, 8);
  vm.regist_intrinsic_func("llvm.memcpy.p0i8.p0i8.i16", IntrinsicLibc::memcpy, 16);
  vm.regist_intrinsic_func("llvm.memcpy.p0i8.p0i8.i32", IntrinsicLibc::memcpy, 32);
  vm.regist_intrinsic_func("llvm.memcpy.p0i8.p0i8.i64", IntrinsicLibc::memcpy, 64);
  
  vm.regist_intrinsic_func("llvm.memmove.p0i8.p0i8.i8",  IntrinsicLibc::memmove, 8);
  vm.regist_intrinsic_func("llvm.memmove.p0i8.p0i8.i16", IntrinsicLibc::memmove, 16);
  vm.regist_intrinsic_func("llvm.memmove.p0i8.p0i8.i32", IntrinsicLibc::memmove, 32);
  vm.regist_intrinsic_func("llvm.memmove.p0i8.p0i8.i64", IntrinsicLibc::memmove, 64);

  vm.regist_intrinsic_func("llvm.memset.p0i8.i8",  IntrinsicLibc::memset, 8);
  vm.regist_intrinsic_func("llvm.memset.p0i8.i16", IntrinsicLibc::memset, 16);
  vm.regist_intrinsic_func("llvm.memset.p0i8.i32", IntrinsicLibc::memset, 32);
  vm.regist_intrinsic_func("llvm.memset.p0i8.i64", IntrinsicLibc::memset, 64);
}
