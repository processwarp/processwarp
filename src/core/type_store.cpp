
#include "type_store.hpp"

using namespace usagi;

// コンストラクタ。
TypeStore::TypeStore(size_t size_,
		     unsigned int alignment_,
		     const std::vector<vaddr_t>& member_) :
  size(size_),
  alignment(alignment_),
  member(member_) {
  }
