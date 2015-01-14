
#include "func_store.hpp"

using namespace usagi;

static const FuncStore::NormalProp DUMMY_PROP = {};

// 通常の関数のコンストラクタ。
FuncStore::FuncStore(const Symbols::Symbol& name_,
		     const NormalProp& normal_prop_) :
  type(FC_NORMAL),
  name(name_),
  normal_prop(normal_prop_),
  intrinsic(nullptr),
  external(nullptr)
{
}

// VM組み込み関数のコンストラクタ。
FuncStore::FuncStore(const Symbols::Symbol& name_,
		     const intrinsic_func_t intrinsic_) :
  type(FC_INTRINSIC),
  name(name_),
  normal_prop(DUMMY_PROP),
  intrinsic(intrinsic_),
  external(nullptr)
{
}

// 外部の関数のコンストラクタ。
FuncStore::FuncStore(const Symbols::Symbol& name_) :
  type(FC_EXTERNAL),
  name(name_),
  normal_prop(DUMMY_PROP),
  intrinsic(nullptr),
  external(nullptr)
{
}
