
#include <cassert>
#include <cinttypes>
#include <cstring>

#include "llvm_intrinsic.hpp"
#include "vmachine.hpp"

using namespace usagi;

// memcpy関数。
void LlvmIntrinsic::memcpy(VMachine& vm, Thread& th, IntrinsicFuncParam p,
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
  int32_t p_align = VMachine::read_intrinsic_param_i32(src, &seek);
  p_align = 0; // 利用しないので警告回避用に0を代入
  // 実行順番の制約(VMでは実行順番を入れ替えないので無視する)を取得
  int8_t p_isvolation = VMachine::read_intrinsic_param_i8(src, &seek);
  p_isvolation = 0; // 利用しないので警告回避用に0を代入

  // 読み込んだパラメタ長と渡されたパラメタ長は同じはず
  print_debug("size %ld, read %d\n", src.size(), seek);
  assert(src.size() == seek);
  std::memcpy(vm.get_raw_addr(p_dst),
	      vm.get_raw_addr(p_src),
	      static_cast<size_t>(p_size));
}
