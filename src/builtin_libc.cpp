
#include <cassert>
#include <cinttypes>
#include <cstring>
#include <vector>

#ifdef __EMSCRIPTEN__
#include <emscripten.h>
#include <emscripten/bind.h>
#endif

#include "builtin_libc.hpp"
#include "process.hpp"

namespace processwarp {

inline int64_t get_psize(int64_t size, std::vector<uint8_t>& src, int* seek) {
  switch (size) {
#define M_CASE_SIZE(BITS, CONTAINER)                                    \
    case (BITS): {                                                      \
      CONTAINER size_tmp = Process::read_builtin_param_i##BITS(src, seek); \
      return static_cast<int64_t>(size_tmp);                            \
    } break;

    M_CASE_SIZE(8,  uint8_t);
    M_CASE_SIZE(16, uint16_t);
    M_CASE_SIZE(32, uint32_t);
    M_CASE_SIZE(64, uint64_t);
#undef M_CASE_SIZE

    default: {
      assert(false);
      return 0;
    } break;
  }
}

// atexit関数。
BuiltinPost BuiltinLibc::atexit(Process& proc, Thread& thread,
                                BuiltinFuncParam p, vaddr_t dst,
                                std::vector<uint8_t>& src) {
  int seek = 0;
  // コピー先アドレスを取得
  vaddr_t func = Process::read_builtin_param_ptr(src, &seek);
  assert(static_cast<signed>(src.size()) == seek);

  // 終了処理時に呼び出す関数一覧
  proc.calls_at_exit.push(func);

  thread.memory->write<vm_int_t>(dst, 0);

  return BP_NORMAL;
}

// calloc関数。データ領域の確保とクリアを行う。
BuiltinPost BuiltinLibc::calloc(Process& proc, Thread& thread,
                                BuiltinFuncParam p, vaddr_t dst,
                                std::vector<uint8_t>& src) {
  int seek = 0;
  uint64_t count = Process::read_builtin_param_size(src, &seek);
  uint64_t size = Process::read_builtin_param_size(src, &seek);
  assert(static_cast<signed>(src.size()) == seek);

  vaddr_t allocated = thread.memory->alloc(count * size);
  thread.memory->write_fill(allocated, 0, count * size);

  thread.memory->write<vaddr_t>(dst, allocated);

  return BP_NORMAL;
}

// exit関数。
BuiltinPost BuiltinLibc::exit(Process& proc, Thread& thread, BuiltinFuncParam p,
                              vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  // コピー先アドレスを取得
  vm_uint_t ret = Process::read_builtin_param_i(src, &seek);
  assert(static_cast<signed>(src.size()) == seek);

  // 終了コードを設定する
  thread.memory->write<uint32_t>(thread.stackinfos.at(0)->stack, ret);

  // スタックを1段残して開放する
  while (thread.stackinfos.size() > 1) {
    StackInfo& top = thread.get_stackinfo(-1);
    thread.memory->free(top.stack);
    for (vaddr_t addr : top.alloca_addrs) thread.memory->free(addr);
    thread.pop_stack();
  }

  return BP_RE_ENTRY;
}

// free関数。指定データ領域を開放する。
BuiltinPost BuiltinLibc::free(Process& proc, Thread& thread, BuiltinFuncParam p,
                              vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  vaddr_t ptr = Process::read_builtin_param_ptr(src, &seek);
  assert(static_cast<signed>(src.size()) == seek);

  thread.memory->free(ptr);

  return BP_NORMAL;
}

// longjmp関数。保存されたスタックコンテキストへの非局所的なジャンプ。
BuiltinPost BuiltinLibc::longjmp(Process& proc, Thread& thread,
                                 BuiltinFuncParam p, vaddr_t dst,
                                 std::vector<uint8_t>& src) {
  int seek = 0;
  // 引数を開く。
  vaddr_t env = Process::read_builtin_param_ptr(src, &seek);
  vm_int_t val = Process::read_builtin_param_i(src, &seek);
  assert(static_cast<signed>(src.size()) == seek);

  int seek2 = 0;
  // stack_count
  vm_uint_t stack_count = thread.memory->read<vm_uint_t>(env + seek2);
  seek2 += sizeof(vm_int_t);
  // setjmpした時よりスタックが少ない場合エラー
  if (thread.stackinfos.size() < stack_count) {
    throw_error(Error::SEGMENT_FAULT);
  }

  // 余分なスタックを開放
  while (thread.stackinfos.size() > stack_count) {
    const StackInfo& si = thread.get_stackinfo(-1);
    // スタック領域を解放
    thread.memory->free(si.stack);
    // alloca領域を開放
    for (vaddr_t addr : si.alloca_addrs) {
      thread.memory->free(addr);
    }

    thread.pop_stack();
  }
  StackInfo& si = thread.get_stackinfo(-1);
  // ret_addrのアドレスにvalで指定された値を設定
  thread.memory->write<uint32_t>(thread.memory->read<vaddr_t>(env + seek2), val);
  seek2 += sizeof(vaddr_t);
  // レジスタの値を戻す。
  // pc
  si.pc = thread.memory->read<vm_uint_t>(env + seek2);
  seek2 += sizeof(vm_uint_t);
  // phi
  si.phi0 = thread.memory->read<vm_uint_t>(env + seek2);
  seek2 += sizeof(vm_uint_t);
  si.phi1 = thread.memory->read<vm_uint_t>(env + seek2);
  seek2 += sizeof(vm_uint_t);
  // type
  si.type = thread.memory->read<vaddr_t>(env + seek2);
  seek2 += sizeof(vaddr_t);
  si.type_operator = nullptr;
  si.type_store.reset(nullptr);
  // alignment
  si.alignment = thread.memory->read<vm_uint_t>(env + seek2);
  seek2 += sizeof(vm_int_t);
  // output
  si.output = thread.memory->read<vaddr_t>(env + seek2);
  seek2 += sizeof(vaddr_t);
  // value
  si.value = thread.memory->read<vaddr_t>(env + seek2);
  seek2 += sizeof(vaddr_t);
  // address
  si.address = thread.memory->read<vaddr_t>(env + seek2);
  seek2 += sizeof(vaddr_t);

  return BP_RE_ENTRY;
}

// malloc関数。データ領域の確保を行う。
BuiltinPost BuiltinLibc::malloc(Process& proc, Thread& thread,
                                BuiltinFuncParam p, vaddr_t dst,
                                std::vector<uint8_t>& src) {
  int seek = 0;
  uint64_t size = Process::read_builtin_param_size(src, &seek);
  assert(static_cast<signed>(src.size()) == seek);

  thread.memory->write<vaddr_t>(dst, thread.memory->alloc(size));

  return BP_NORMAL;
}

// memcpy関数。
BuiltinPost BuiltinLibc::memcpy(Process& proc, Thread& thread,
                                BuiltinFuncParam p, vaddr_t dst,
                                std::vector<uint8_t>& src) {
  int seek = 0;
  // コピー先アドレスを取得
  vaddr_t p_dst = Process::read_builtin_param_ptr(src, &seek);
  // コピー元アドレスを取得
  vaddr_t p_src = Process::read_builtin_param_ptr(src, &seek);

  // コピーサイズを取得
  uint64_t p_size = get_psize(p.i64, src, &seek);
  // アライメントを取得
  /*int32_t p_align =*/Process::read_builtin_param_i32(src, &seek);
  // 実行順番の制約(VMでは実行順番を入れ替えないので無視する)を取得
  /*int8_t p_isvolation =*/Process::read_builtin_param_i8(src, &seek);

  // 読み込んだパラメタ長と渡されたパラメタ長は同じはず
  assert(static_cast<signed>(src.size()) == seek);
  thread.memory->write_copy(p_dst, p_src, p_size);

  return BP_NORMAL;
}

// memmove関数。
BuiltinPost BuiltinLibc::memmove(Process& proc, Thread& thread,
                                 BuiltinFuncParam p, vaddr_t dst,
                                 std::vector<uint8_t>& src) {
  int seek = 0;
  // コピー先アドレスを取得
  vaddr_t p_dst = Process::read_builtin_param_ptr(src, &seek);
  // コピー元アドレスを取得
  vaddr_t p_src = Process::read_builtin_param_ptr(src, &seek);
  assert(static_cast<signed>(src.size()) == seek);

  // コピーサイズを取得
  uint64_t p_size = get_psize(p.i64, src, &seek);
  // アライメントを取得
  /*int32_t p_align =*/Process::read_builtin_param_i32(src, &seek);
  // 実行順番の制約(VMでは実行順番を入れ替えないので無視する)を取得
  /*int8_t p_isvolation =*/Process::read_builtin_param_i8(src, &seek);

  // 読み込んだパラメタ長と渡されたパラメタ長は同じはず
  assert(static_cast<signed>(src.size()) == seek);
  thread.memory->write_copy(p_dst, p_src, p_size);

  return BP_NORMAL;
}

// memset関数。
BuiltinPost BuiltinLibc::memset(Process& proc, Thread& thread,
                                BuiltinFuncParam p, vaddr_t dst,
                                std::vector<uint8_t>& src) {
  int seek = 0;
  // 設定先先アドレスを取得
  vaddr_t p_dst = Process::read_builtin_param_ptr(src, &seek);
  // 設定値を取得
  uint8_t p_val = Process::read_builtin_param_i8(src, &seek);

  // 設定サイズを取得
  uint64_t p_len = get_psize(p.i64, src, &seek);
  // アライメントを取得
  /*int32_t p_align =*/Process::read_builtin_param_i32(src, &seek);
  // 実行順番の制約(VMでは実行順番を入れ替えないので無視する)を取得
  /*int8_t p_isvolation =*/Process::read_builtin_param_i8(src, &seek);

  // 読み込んだパラメタ長と渡されたパラメタ長は同じはず
  assert(static_cast<signed>(src.size()) == seek);
  thread.memory->write_fill(p_dst, p_val, p_len);

  return BP_NORMAL;
}

// realloc関数。データ領域の再確保を行う。
BuiltinPost BuiltinLibc::realloc(Process& proc, Thread& thread,
                                 BuiltinFuncParam p, vaddr_t dst,
                                 std::vector<uint8_t>& src) {
  int seek = 0;
  vaddr_t ptr = Process::read_builtin_param_ptr(src, &seek);
  uint64_t size = Process::read_builtin_param_size(src, &seek);
  assert(static_cast<signed>(src.size()) == seek);

  thread.memory->write<vaddr_t>(dst, thread.memory->realloc(ptr, size));

  return BP_NORMAL;
}

// VMにライブラリを登録する。
void BuiltinLibc::regist(VMachine& vm) {
  vm.regist_builtin_func("atexit", BuiltinLibc::atexit, 0);
  vm.regist_builtin_func("exit", BuiltinLibc::exit, 0);

  vm.regist_builtin_func("calloc", BuiltinLibc::calloc, 0);
  vm.regist_builtin_func("free", BuiltinLibc::free, 0);
  vm.regist_builtin_func("malloc", BuiltinLibc::malloc, 0);
  vm.regist_builtin_func("realloc", BuiltinLibc::realloc, 0);

  vm.regist_builtin_func("setjmp", BuiltinLibc::setjmp, 0);
  vm.regist_builtin_func("longjmp", BuiltinLibc::longjmp, 0);

  vm.regist_builtin_func("strtol", BuiltinLibc::strtol, 0);
  vm.regist_builtin_func("strtoll", BuiltinLibc::strtol, 0);

  vm.regist_builtin_func("llvm.memcpy.p0i8.p0i8.i8",  BuiltinLibc::memcpy, 8);
  vm.regist_builtin_func("llvm.memcpy.p0i8.p0i8.i16", BuiltinLibc::memcpy, 16);
  vm.regist_builtin_func("llvm.memcpy.p0i8.p0i8.i32", BuiltinLibc::memcpy, 32);
  vm.regist_builtin_func("llvm.memcpy.p0i8.p0i8.i64", BuiltinLibc::memcpy, 64);

  vm.regist_builtin_func("llvm.memmove.p0i8.p0i8.i8",  BuiltinLibc::memmove, 8);
  vm.regist_builtin_func("llvm.memmove.p0i8.p0i8.i16", BuiltinLibc::memmove, 16);
  vm.regist_builtin_func("llvm.memmove.p0i8.p0i8.i32", BuiltinLibc::memmove, 32);
  vm.regist_builtin_func("llvm.memmove.p0i8.p0i8.i64", BuiltinLibc::memmove, 64);

  vm.regist_builtin_func("llvm.memset.p0i8.i8",  BuiltinLibc::memset, 8);
  vm.regist_builtin_func("llvm.memset.p0i8.i16", BuiltinLibc::memset, 16);
  vm.regist_builtin_func("llvm.memset.p0i8.i32", BuiltinLibc::memset, 32);
  vm.regist_builtin_func("llvm.memset.p0i8.i64", BuiltinLibc::memset, 64);
}

// setjmp関数。非局所的なジャンプのために、スタックコンテキストを保存する。
BuiltinPost BuiltinLibc::setjmp(Process& proc, Thread& thread,
                                BuiltinFuncParam p, vaddr_t dst,
                                std::vector<uint8_t>& src) {
  int seek = 0;
  // 引数を開く。
  vaddr_t env = Process::read_builtin_param_ptr(src, &seek);
  // 読み込んだパラメタ長と渡されたパラメタ長は同じはず
  assert(static_cast<signed>(src.size()) == seek);

  int seek2 = 0;
  const StackInfo& si = thread.get_stackinfo(-1);
  // stack_count
  thread.memory->write<vm_uint_t>(env + seek2, thread.stackinfos.size());
  seek2 += sizeof(vm_int_t);
  // ret_addr
  thread.memory->write<vaddr_t>(env + seek2, dst);
  seek2 += sizeof(vaddr_t);
  // pc
  thread.memory->write<vm_uint_t>(env + seek2, si.pc + 1);
  seek2 += sizeof(vm_uint_t);
  // phi
  thread.memory->write<vm_uint_t>(env + seek2, si.phi0);
  seek2 += sizeof(vm_uint_t);
  thread.memory->write<vm_uint_t>(env + seek2, si.phi1);
  seek2 += sizeof(vm_uint_t);
  // type
  thread.memory->write<vaddr_t>(env + seek2, si.type);
  seek2 += sizeof(vaddr_t);
  // alignment
  thread.memory->write<vm_uint_t>(env + seek2, si.alignment);
  seek2 += sizeof(vm_int_t);
  // output
  thread.memory->write<vaddr_t>(env + seek2, si.output);
  seek2 += sizeof(vaddr_t);
  // value
  thread.memory->write<vaddr_t>(env + seek2, si.value);
  seek2 += sizeof(vaddr_t);
  // address
  thread.memory->write<vaddr_t>(env + seek2, si.address);
  seek2 += sizeof(vaddr_t);

  // setjmp自体の戻り値は0
  thread.memory->write<int32_t>(dst, 0);

  return BP_RE_ENTRY;
}

// strtol関数。文字列を数値に変換する。
BuiltinPost BuiltinLibc::strtol(Process& proc, Thread& thread,
                                BuiltinFuncParam p, vaddr_t dst,
                                std::vector<uint8_t>& src) {
  int seek = 0;
  // 引数の読み込み
  vaddr_t nptr = Process::read_builtin_param_ptr(src, &seek);
  vaddr_t endptr = Process::read_builtin_param_ptr(src, &seek);
  vm_int_t base = static_cast<vm_int_t>(Process::read_builtin_param_i(src, &seek));
  assert(static_cast<signed>(src.size()) == seek);

  const char* raw_ptr = reinterpret_cast<const char*>(thread.memory->read_raw(nptr));
  if (endptr == VADDR_NULL) {
    // endptrがnullの場合は、戻り値をそのまま渡すだけ
    thread.memory->write<int64_t>(dst, std::strtol(raw_ptr, nullptr, base));

  } else {
    // endptrが指定されている場合、ポインタの書き換えが必要
    char *work_ptr;
    thread.memory->write<int64_t>(dst, std::strtol(raw_ptr, &work_ptr, base));

    if (work_ptr == nullptr) {
      thread.memory->write<vaddr_t>(endptr, VADDR_NULL);

    } else {
      thread.memory->write<vaddr_t>(endptr, nptr + (work_ptr - raw_ptr));
    }
  }

  return BP_NORMAL;
}
}  // namespace processwarp
