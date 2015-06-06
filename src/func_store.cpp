
#include "func_store.hpp"

using namespace processwarp;

static const FuncStore::NormalProp DUMMY_PROP = {};
static const BuiltinFuncParam DUMMY_BUILTIN_PARAM = {.ptr = nullptr};

// 通常の関数のコンストラクタ。
FuncStore::FuncStore(vaddr_t addr_,
		     const Symbols::Symbol& name_,
		     vaddr_t ret_type_,
		     unsigned int arg_num_,
		     bool is_var_arg_,
		     const NormalProp& normal_prop_) :
  addr(addr_),
  type(FC_NORMAL),
  name(name_),
  ret_type(ret_type_),
  arg_num(arg_num_),
  is_var_arg(is_var_arg_),
  normal_prop(normal_prop_),
  builtin(nullptr),
  builtin_param(DUMMY_BUILTIN_PARAM),
  external(nullptr)
{
}

// VM組み込み関数のコンストラクタ。
FuncStore::FuncStore(vaddr_t addr_,
		     const Symbols::Symbol& name_,
		     vaddr_t ret_type_,
		     unsigned int arg_num_,
		     bool is_var_arg_,
		     const builtin_func_t builtin_,
		     const BuiltinFuncParam builtin_param_) :
  addr(addr_),
  type(FC_BUILTIN),
  name(name_),
  ret_type(ret_type_),
  arg_num(arg_num_),
  is_var_arg(is_var_arg_),
  normal_prop(DUMMY_PROP),
  builtin(builtin_),
  builtin_param(builtin_param_),
  external(nullptr)
{
}

// 外部の関数のコンストラクタ。
FuncStore::FuncStore(vaddr_t addr_,
		     const Symbols::Symbol& name_,
		     vaddr_t ret_type_,
		     unsigned int arg_num_,
		     bool is_var_arg_) :
  addr(addr_),
  type(FC_EXTERNAL),
  name(name_),
  ret_type(ret_type_),
  arg_num(arg_num_),
  is_var_arg(is_var_arg_),
  normal_prop(DUMMY_PROP),
  builtin(nullptr),
  builtin_param(DUMMY_BUILTIN_PARAM),
  external(nullptr)
{
}
