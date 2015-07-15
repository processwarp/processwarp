
#include <cassert>

#include "type_store.hpp"

using namespace processwarp;

/*
// 配列型の型情報を作成する。
std::unique_ptr<TypeStore> Process::create_type_array(vaddr_t element, unsigned int num) {
  // サイズ、アライメントを計算
  std::vector<vaddr_t> member(num, element);
  std::pair<size_t, unsigned int> info = calc_type_size(member);
  
  // 領域を確保
  return std::move(TypeStore::alloc_array(proc_memory, TK_ARRAY, info.first, info.second, element, num));
}

// 基本型の型情報を作成する。
std::unique_ptr<TypeStore> Process::create_type_basic(BasicType type) {
  // 基本型はVMにより登録してあるものだけなので、ソレを戻す。
  return std::move(TypeStore::read(proc_memory, type));
}

// 構造体の型情報を作成する。
std::unique_ptr<TypeStore> Process::create_type_struct(const std::vector<vaddr_t>& member) {
  // 領域を確保
  std::pair<size_t, unsigned int> info = calc_type_size(member);
  return std::move(TypeStore::alloc_struct(proc_memory, info.first, info.second, member));
}

// vectorの型情報を作成する。
std::unique_ptr<TypeStore> Process::create_type_vector(vaddr_t element, unsigned int num) {
  std::vector<vaddr_t> member(num, element);
  std::pair<size_t, unsigned int> info = calc_type_size(member);
  // 領域を確保
  return std::move(TypeStore::alloc_array(proc_memory, TK_VECTOR, info.first, info.second, element, num));
}


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
*/

// 型のサイズと最大アライメントを計算する。
std::pair<size_t, unsigned int> TypeStore::calc_type_size(VMemory::Accessor& memory,
							  const std::vector<vaddr_t>& member) {
  size_t size = 0;
  unsigned int max_alignment = 0;
  unsigned int odd;

  for (int i = 0, member_size = member.size(); i < member_size; i ++) {
    std::unique_ptr<TypeStore> type(std::move(TypeStore::read(memory, member.at(i))));
    // メンバ中で一番大きなアライメントを保持
    if (type->alignment > max_alignment) max_alignment = type->alignment;
    // パディングを計算する
    if ((odd = size % type->alignment) != 0) size = size - odd + type->alignment;
    // サイズ分を追加
    size += type->size;
  }
  // 一番大きなアライメントで最後に調整
  if ((odd = size % max_alignment) != 0) size = size - odd + max_alignment;

  return std::make_pair(size, max_alignment);
}

// 型のサイズと最大アライメントを計算する。
std::pair<size_t, unsigned int> TypeStore::calc_type_size(VMemory::Accessor& memory,
							  vaddr_t type) {
  std::unique_ptr<TypeStore> t(std::move(TypeStore::read(memory, type)));
  
  return std::make_pair(t->size, t->alignment);
}
