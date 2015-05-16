
#include <cassert>

#include "type_store.hpp"

using namespace processwarp;

// コンストラクタ(基本型)。
TypeStore::TypeStore(vaddr_t addr_,
		     size_t size_,
		     unsigned int alignment_) :
  addr(addr_),
  kind(TypeKind::TK_BASIC),
  size(size_),
  alignment(alignment_),
  member(1, BasicType::TY_VOID),
  element(0),
  num(0) {
  // BasicTypeのメンバをsize0, alignment0のTY_VOIDにしておくことで、getelementptrの
  // 計算で余計に計算しても問題が起きない
}

// コンストラクタ(構造体)。
TypeStore::TypeStore(vaddr_t addr_,
		     size_t size_,
		     unsigned int alignment_,
		     const std::vector<vaddr_t>& member_) :
  addr(addr_),
  kind(TypeKind::TK_STRUCT),
  size(size_),
  alignment(alignment_),
  member(member_),
  element(0),
  num(0) {
  //
}

// コンストラクタ(配列/vector)。
TypeStore::TypeStore(vaddr_t addr_,
		     TypeKind kind_,
		     size_t size_,
		     unsigned int alignment_,
		     vaddr_t element_,
		     unsigned int num_) :
  addr(addr_),
  kind(kind_),
  size(size_),
  alignment(alignment_),
  element(element_),
  num(num_) {
  // 型の種類は配列かvectorしか許容しない。
  assert(kind == TypeKind::TK_ARRAY ||
	 kind == TypeKind::TK_VECTOR);
}
