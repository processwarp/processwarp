
#include "func_store.hpp"

using namespace usagi;

static const FuncStore::NormalProp DUMMY_PROP = {};
static const IntrinsicFuncParam DUMMY_INTRINSIC_PARAM = {.ptr = nullptr};

// 通常の関数のコンストラクタ。
FuncStore::FuncStore(vaddr_t addr_,
		     const Symbols::Symbol& name_,
		     vaddr_t ret_type_,
		     const NormalProp& normal_prop_) :
  addr(addr_),
  type(FC_NORMAL),
  name(name_),
  ret_type(ret_type_),
  normal_prop(normal_prop_),
  intrinsic(nullptr),
  intrinsic_param(DUMMY_INTRINSIC_PARAM),
  external(nullptr)
{
}

// VM組み込み関数のコンストラクタ。
FuncStore::FuncStore(vaddr_t addr_,
		     const Symbols::Symbol& name_,
		     vaddr_t ret_type_,
		     const intrinsic_func_t intrinsic_,
		     const IntrinsicFuncParam intrinsic_param_) :
  addr(addr_),
  type(FC_INTRINSIC),
  name(name_),
  ret_type(ret_type_),
  normal_prop(DUMMY_PROP),
  intrinsic(intrinsic_),
  intrinsic_param(intrinsic_param_),
  external(nullptr)
{
}

// 外部の関数のコンストラクタ。
FuncStore::FuncStore(vaddr_t addr_,
		     const Symbols::Symbol& name_,
		     vaddr_t ret_type_) :
  addr(addr_),
  type(FC_EXTERNAL),
  name(name_),
  ret_type(ret_type_),
  normal_prop(DUMMY_PROP),
  intrinsic(nullptr),
  intrinsic_param(DUMMY_INTRINSIC_PARAM),
  external(nullptr)
{
}
