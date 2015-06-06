
#include "builtin_va_arg.hpp"
#include "vmachine.hpp"

using namespace processwarp;

// VMにライブラリを登録する。
void BuiltinVaArg::regist(VMachine& vm) {
  vm.regist_builtin_func("__builtin_va_arg", BuiltinVaArg::arg, 0);
  vm.regist_builtin_func("llvm.va_start", BuiltinVaArg::start, 0);
  vm.regist_builtin_func("llvm.va_end", BuiltinVaArg::end, 0);
  vm.regist_builtin_func("llvm.va_copy", BuiltinVaArg::copy, 0);
}

// __builtin_va_arg関数。
bool BuiltinVaArg::arg(VMachine& vm, Thread& th, BuiltinFuncParam p,
			 vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  // i8* arglistを取り出す。
  vaddr_t arglist = VMachine::read_builtin_param_ptr(src, &seek);
  // i64 sizeof argumentを取り出す。
  uint64_t arg_size =VMachine::read_builtin_param_i64(src, &seek);
  
  vaddr_t va_arg = *reinterpret_cast<vaddr_t*>(vm.get_raw_addr(arglist));
  // 型情報を取得
  vaddr_t type = *reinterpret_cast<vaddr_t*>(vm.get_raw_addr(va_arg));
  TypeStore& type_store = vm.vmemory.get_type(type);
  // 値のアドレスを取得
  vaddr_t value;
  if (arg_size <= sizeof(vaddr_t)) {
    // 引数のサイズが(おそらく)ポインタサイズより小さい場合は
    // 型情報に続く値のアドレスを取得
    value = va_arg + sizeof(vaddr_t);

  } else {
    // 引数のサイズがポインタサイズより大きい場合は、値のアドレスが渡されるので
    // ポインタを1回多く剥く
    value = *reinterpret_cast<vaddr_t*>(vm.get_raw_addr(va_arg + sizeof(vaddr_t)));
  }
  
  // 戻り値として値のアドレスを設定
  *reinterpret_cast<vaddr_t*>(vm.get_raw_addr(dst)) = value;
  // arglistに格納してあるアドレスを更新
  *reinterpret_cast<vaddr_t*>(vm.get_raw_addr(arglist)) =
    va_arg + sizeof(vaddr_t) + type_store.size;

  return false;
}

// llvm.va_copy関数。
bool BuiltinVaArg::copy(VMachine& vm, Thread& th, BuiltinFuncParam p,
			  vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  // i8* destarglistを取り出す。
  vaddr_t destarglist = VMachine::read_builtin_param_ptr(src, &seek);
  // i8* srcarglistを取り出す。
  vaddr_t srcarglist = VMachine::read_builtin_param_ptr(src, &seek);

  // srcからdestへポインタでさした中身をコピーする
  *reinterpret_cast<vaddr_t*>(vm.get_raw_addr(destarglist)) =
    *reinterpret_cast<vaddr_t*>(vm.get_raw_addr(srcarglist));
  
  return false;
}

// llvm.va_end関数。
bool BuiltinVaArg::end(VMachine& vm, Thread& th, BuiltinFuncParam p,
			 vaddr_t dst, std::vector<uint8_t>& src) {
  // 資源の解放などは無いので、何もしなくて良い。
  return false;
}

// llvm.va_start関数。
bool BuiltinVaArg::start(VMachine& vm, Thread& th, BuiltinFuncParam p,
			   vaddr_t dst, std::vector<uint8_t>& src) {
  int seek = 0;
  // i8* arglistを取り出す
  vaddr_t arglist = VMachine::read_builtin_param_ptr(src, &seek);

  // arglistで指定したアドレスに可変長引数の先頭アドレスを格納しておく
  *reinterpret_cast<vaddr_t*>(vm.get_raw_addr(arglist)) = th.stackinfos.back()->var_arg;

  return false;
}










