
#include <cassert>
#include <cinttypes>
#include <cstring>

#include "intrinsic_libc.hpp"
#include "vmachine.hpp"

using namespace usagi;

// atexit関数。
bool IntrinsicLibc::atexit(VMachine& vm, Thread& th, IntrinsicFuncParam p,
			   vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  // コピー先アドレスを取得
  vaddr_t func = VMachine::read_intrinsic_param_ptr(src, &seek);
  // 終了処理時に呼び出す関数一覧
  vm.calls_at_exit.push(func);
  return false;
}

// calloc関数。データ領域の確保とクリアを行う。
bool IntrinsicLibc::calloc(VMachine& vm, Thread& th, IntrinsicFuncParam p,
			   vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  uint64_t count = VMachine::read_intrinsic_param_i64(src, &seek);
  uint64_t size = VMachine::read_intrinsic_param_i64(src, &seek);
  vaddr_t allocated = vm.v_malloc(count * size, false);
  // 領域のクリア
  std::memset(vm.get_raw_addr(allocated), 0, count * size);
  *reinterpret_cast<vaddr_t*>(vm.get_raw_addr(dst)) = allocated;
  return false;
}

// exit関数。
bool IntrinsicLibc::exit(VMachine& vm, Thread& th, IntrinsicFuncParam p,
			 vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  // コピー先アドレスを取得
  uint32_t ret = VMachine::read_intrinsic_param_i32(src, &seek);
  
  // 終了コードを設定する
  *reinterpret_cast<uint32_t*>(vm.get_raw_addr(th.stackinfos.at(0)->stack)) = ret;
  
  // スタックを1段残して開放する
  while (th.stackinfos.size() > 1) {
    StackInfo& top = *(th.stackinfos.back());
    vm.vmemory.free(top.stack);
    for (vaddr_t addr : top.alloca_addrs) vm.vmemory.free(addr);
    th.stackinfos.pop_back();
  }

  return true;
}

// free関数。指定データ領域を開放する。
bool IntrinsicLibc::free(VMachine& vm, Thread& th, IntrinsicFuncParam p,
			 vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  vaddr_t ptr = VMachine::read_intrinsic_param_ptr(src, &seek);
  vm.vmemory.free(ptr);
  return false;
}

// malloc関数。データ領域の確保を行う。
bool IntrinsicLibc::malloc(VMachine& vm, Thread& th, IntrinsicFuncParam p,
			   vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  uint64_t size = VMachine::read_intrinsic_param_i64(src, &seek);
  *reinterpret_cast<vaddr_t*>(vm.get_raw_addr(dst)) = vm.v_malloc(size, false);
  return false;
}

// memcpy関数。
bool IntrinsicLibc::memcpy(VMachine& vm, Thread& th, IntrinsicFuncParam p,
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
  return false;
}

// memmove関数。
bool IntrinsicLibc::memmove(VMachine& vm, Thread& th, IntrinsicFuncParam p,
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
  return false;
}

// memset関数。
bool IntrinsicLibc::memset(VMachine& vm, Thread& th, IntrinsicFuncParam p,
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
  return false;
}

// realloc関数。データ領域の再確保を行う。
bool IntrinsicLibc::realloc(VMachine& vm, Thread& th, IntrinsicFuncParam p,
			    vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  vaddr_t ptr = VMachine::read_intrinsic_param_ptr(src, &seek);
  uint64_t size = VMachine::read_intrinsic_param_i64(src, &seek);

  // 新しい領域の確保
  DataStore& new_store = vm.vmemory.alloc_data(size, false);

  if (ptr != VADDR_NULL) {
    // データのコピー
    DataStore& old_store = vm.vmemory.get_data(ptr);
    size_t cp_size = old_store.size < new_store.size ? old_store.size : new_store.size;
    std::memcpy(new_store.head.get(), old_store.head.get(), cp_size);

    // 古い領域の開放
    vm.vmemory.free(ptr);
  }

  *reinterpret_cast<vaddr_t*>(vm.get_raw_addr(dst)) = new_store.addr;
  return false;
}

// VMにライブラリを登録する。
void IntrinsicLibc::regist(VMachine& vm) {
  vm.regist_intrinsic_func("atexit", IntrinsicLibc::atexit, 0);
  vm.regist_intrinsic_func("exit", IntrinsicLibc::exit, 0);

  vm.regist_intrinsic_func("calloc", IntrinsicLibc::calloc, 0);
  vm.regist_intrinsic_func("free", IntrinsicLibc::free, 0);
  vm.regist_intrinsic_func("malloc", IntrinsicLibc::malloc, 0);
  vm.regist_intrinsic_func("realloc", IntrinsicLibc::realloc, 0);

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
