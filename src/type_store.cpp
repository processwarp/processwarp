
#include "type_store.hpp"

using namespace usagi;

// コンストラクタ。
TypeStore::TypeStore(vaddr_t addr_,
		     size_t size_,
		     unsigned int alignment_,
		     const std::vector<vaddr_t>& member_) :
  addr(addr_),
  size(size_),
  alignment(alignment_),
  is_array(false),
  member(member_),
  element(0),
  num(0) {
  }

// コンストラクタ(配列)。
TypeStore::TypeStore(vaddr_t addr_,
		     size_t size_,
		     unsigned int alignment_,
		     vaddr_t element_,
		     unsigned int num_) :
  addr(addr_),
  size(size_),
  alignment(alignment_),
  is_array(true),
  element(element_),
  num(num_) {
  }
