
#include "func_store.hpp"

using namespace processwarp;

static const FuncStore::NormalProp DUMMY_PROP = {};
//static const BuiltinFuncParam DUMMY_BUILTIN_PARAM = {.ptr = nullptr};

//
FuncStore::FuncStore(vaddr_t addr_,
		     FuncType type_,
		     const Symbols::Symbol& name_,
		     vaddr_t ret_type_,
		     unsigned int arg_num_,
		     bool is_var_arg_,
		     const NormalProp& normal_prop_,
		     const builtin_func_t& builtin_,
		     const BuiltinFuncParam& builtin_param_) :
  addr(addr_),
  type(type_),
  name(name_),
  ret_type(ret_type_),
  arg_num(arg_num_),
  is_var_arg(is_var_arg_),
  normal_prop(normal_prop_),
  builtin(builtin_),
  builtin_param(builtin_param_),
  external(nullptr) {
}


// ネイティブ関数を指定アドレスに展開する。
/*
void Process::deploy_function(const std::string& name,
			       vaddr_t ret_type,
			       unsigned int arg_num,
			       bool is_var_arg,
			       vaddr_t addr) {
  auto ifunc = builtin_funcs.find(name);
  if (ifunc == builtin_funcs.end()) {
    // 組み込み関数に名前がなかった場合、ライブラリ関数として展開。
    vmemory.alloc_func(symbols.get(name), ret_type, arg_num, is_var_arg, addr);

  } else {
    // 組み込み関数に名前があった場合組み込み関数として展開。
    vmemory.alloc_func(symbols.get(name), ret_type,
		       arg_num, is_var_arg, ifunc->second.first, ifunc->second.second, addr);
  }
  }*/

// 通常の関数(VMで解釈、実行する)を指定アドレスに展開する。
/*
void Process::deploy_function_normal(const std::string& name,
				      vaddr_t ret_type,
				      unsigned int arg_num,
				      bool is_var_arg,
				      const FuncStore::NormalProp& prop,
				      vaddr_t addr) {
  // 関数領域を確保
  vmemory.alloc_func(symbols.get(name), ret_type, arg_num, is_var_arg, prop, addr);
  }*/
