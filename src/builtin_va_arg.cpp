
#include <memory>

#include "builtin_va_arg.hpp"
#include "process.hpp"
#include "type_store.hpp"

using namespace processwarp;

// __builtin_va_arg関数。
BuiltinPost BuiltinVaArg::arg(Process& proc, Thread& thread, BuiltinFuncParam p,
			      vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  // i8* arglistを取り出す。
  vaddr_t arglist = Process::read_builtin_param_ptr(src, &seek);
  // i64 sizeof argumentを取り出す。
  uint64_t arg_size =Process::read_builtin_param_size(src, &seek);
  
  vaddr_t va_arg = thread.memory->get<vaddr_t>(arglist);
  // 型情報を取得
  vaddr_t type = thread.memory->get<vaddr_t>(va_arg);
  std::unique_ptr<TypeStore> type_store(std::move(TypeStore::read(*thread.memory, type)));
  // 値のアドレスを取得
  vaddr_t value;
  if (arg_size <= sizeof(vaddr_t)) {
    // 引数のサイズが(おそらく)ポインタサイズより小さい場合は
    // 型情報に続く値のアドレスを取得
    value = va_arg + sizeof(vaddr_t);

  } else {
    // 引数のサイズがポインタサイズより大きい場合は、値のアドレスが渡されるので
    // ポインタを1回多く剥く
    value = thread.memory->get<vaddr_t>(va_arg + sizeof(vaddr_t));;
  }
  
  // 戻り値として値のアドレスを設定
  thread.memory->set<vaddr_t>(dst, value);
  // arglistに格納してあるアドレスを更新
  thread.memory->set<vaddr_t>(arglist, va_arg + sizeof(vaddr_t) + type_store->size);
  
  return BP_NORMAL;
}

// llvm.va_copy関数。
BuiltinPost BuiltinVaArg::copy(Process& proc, Thread& thread, BuiltinFuncParam p,
			       vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  // i8* destarglistを取り出す。
  vaddr_t dstarglist = Process::read_builtin_param_ptr(src, &seek);
  // i8* srcarglistを取り出す。
  vaddr_t srcarglist = Process::read_builtin_param_ptr(src, &seek);

  // srcからdestへポインタでさした中身をコピーする
  thread.memory->set<vaddr_t>(dstarglist, thread.memory->get<vaddr_t>(srcarglist));
  
  return BP_NORMAL;
}

// llvm.va_end関数。
BuiltinPost BuiltinVaArg::end(Process& proc, Thread& thread, BuiltinFuncParam p,
			      vaddr_t dst, std::vector<uint8_t>& src) {
  // 資源の解放などは無いので、何もしなくて良い。
  return BP_NORMAL;
}

// llvm.va_start関数。
BuiltinPost BuiltinVaArg::start(Process& proc, Thread& thread, BuiltinFuncParam p,
				vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  // i8* arglistを取り出す
  vaddr_t arglist = Process::read_builtin_param_ptr(src, &seek);

  // arglistで指定したアドレスに可変長引数の先頭アドレスを格納しておく
  thread.memory->set<vaddr_t>(arglist, thread.get_stackinfo(-1).var_arg);
  
  return BP_NORMAL;
}

// VMにライブラリを登録する。
void BuiltinVaArg::regist(VMachine& vm) {
  vm.regist_builtin_func("__builtin_va_arg", BuiltinVaArg::arg, 0);
  vm.regist_builtin_func("llvm.va_start", BuiltinVaArg::start, 0);
  vm.regist_builtin_func("llvm.va_end", BuiltinVaArg::end, 0);
  vm.regist_builtin_func("llvm.va_copy", BuiltinVaArg::copy, 0);
}
