
#include <cassert>

#include "convert.hpp"
#include "type_store.hpp"

using namespace processwarp;

static const std::vector<vaddr_t> DUMMY_MEMBER;

TypeStore::TypeStore(vaddr_t addr_,
		     TypeKind kind_,
		     size_t size_,
		     unsigned int alignment_,
		     const std::vector<vaddr_t>& member_,
		     vaddr_t element_,
		     unsigned int num_) :
  addr(addr_),
  kind(kind_),
  size(size_),
  alignment(alignment_),
  member(member_),
  element(element_),
  num(num_) {
}

// Allocate a new basic type to memory.
vaddr_t TypeStore::alloc_basic(VMemory::Accessor& memory, unsigned int size,
			       unsigned int alignment, vaddr_t addr) {
  picojson::object js_type;

  js_type.insert(std::make_pair("program_type", Convert::int2json<uint8_t>(PT_TYPE)));
  js_type.insert(std::make_pair("kind", Convert::int2json<uint8_t>(TK_BASIC)));
  js_type.insert(std::make_pair("size", Convert::int2json<unsigned int>(size)));
  js_type.insert(std::make_pair("alignment", Convert::int2json<unsigned int>(alignment)));
  
  memory.set_program_area(addr, picojson::value(js_type).serialize());

  return addr;
}

// Allocate a new strut type to memory.
vaddr_t TypeStore::alloc_struct(VMemory::Accessor& memory, const std::vector<vaddr_t>& member) {
  picojson::object js_type;
  picojson::array js_member;
  std::pair<size_t, unsigned int> type_size = TypeStore::calc_type_size(memory, member);

  js_type.insert(std::make_pair("program_type", Convert::int2json<uint8_t>(PT_TYPE)));
  js_type.insert(std::make_pair("kind", Convert::int2json<uint8_t>(TK_STRUCT)));
  js_type.insert(std::make_pair("size", Convert::int2json<unsigned int>(type_size.first)));
  js_type.insert(std::make_pair("alignment", Convert::int2json<unsigned int>(type_size.second)));

  for (auto it : member) {
    js_member.push_back(Convert::vaddr2json(it));
  }
  js_type.insert(std::make_pair("member", picojson::value(js_member)));

  vaddr_t addr = memory.reserve_program_area();
  memory.set_program_area(addr, picojson::value(js_type).serialize());
  
  return addr;
}

// Allocate a new array type to memory.
vaddr_t TypeStore::alloc_array(VMemory::Accessor& memory, vaddr_t element, unsigned int num) {
  picojson::object js_type;
  std::pair<size_t, unsigned int> type_size = calc_type_size(memory, element);

  js_type.insert(std::make_pair("program_type", Convert::int2json<uint8_t>(PT_TYPE)));
  js_type.insert(std::make_pair("kind", Convert::int2json<uint8_t>(TK_ARRAY)));
  js_type.insert(std::make_pair("size", Convert::int2json<unsigned int>(type_size.first * num)));
  js_type.insert(std::make_pair("alignment", Convert::int2json<unsigned int>(type_size.second)));
  js_type.insert(std::make_pair("element", Convert::vaddr2json(element)));
  js_type.insert(std::make_pair("num", Convert::int2json<unsigned int>(num)));

  vaddr_t addr = memory.reserve_program_area();
  memory.set_program_area(addr, picojson::value(js_type).serialize());
  
  return addr;
}

// Allocate a new vector type to memory.
vaddr_t TypeStore::alloc_vector(VMemory::Accessor& memory, vaddr_t element, unsigned int num) {
  picojson::object js_type;
  std::pair<size_t, unsigned int> type_size = calc_type_size(memory, element);

  js_type.insert(std::make_pair("program_type", Convert::int2json<uint8_t>(PT_TYPE)));
  js_type.insert(std::make_pair("kind", Convert::int2json<uint8_t>(TK_VECTOR)));
  js_type.insert(std::make_pair("size", Convert::int2json<unsigned int>(type_size.first * num)));
  js_type.insert(std::make_pair("alignment", Convert::int2json<unsigned int>(type_size.second)));
  js_type.insert(std::make_pair("element", Convert::vaddr2json(element)));
  js_type.insert(std::make_pair("num", Convert::int2json<unsigned int>(num)));

  vaddr_t addr = memory.reserve_program_area();
  memory.set_program_area(addr, picojson::value(js_type).serialize());
  
  return addr;
}

// Read out type information from memory.
std::unique_ptr<TypeStore> TypeStore::read(VMemory::Accessor& memory, vaddr_t addr) {
  picojson::value js_tmp;
  std::istringstream is(memory.get_program_area(addr));
  std::string err = picojson::parse(js_tmp, is);
  if (!err.empty()) {
    /// TODO:error
    assert(false);
  }
  picojson::object& js_type = js_tmp.get<picojson::object>();
  
  ProgramType pt = static_cast<ProgramType>(Convert::json2int<uint8_t>(js_type.at("program_type")));
  if (pt != PT_TYPE) {
    /// TODO:error
    assert(false);
  }
  
  TypeKind kind = static_cast<TypeKind>(Convert::json2int<uint8_t>(js_type.at("kind")));
  unsigned int size = Convert::json2int<unsigned int>(js_type.at("size"));
  unsigned int alignment = Convert::json2int<unsigned int>(js_type.at("alignment"));
  
  switch(kind) {
  case TK_BASIC: {
    return std::unique_ptr<TypeStore>
      (new TypeStore(addr, kind, size, alignment, DUMMY_MEMBER, VADDR_NULL, 0));
  } break;

  case TK_STRUCT: {
    picojson::array& js_member = js_type.at("member").get<picojson::array>();
    std::vector<vaddr_t> member;
    for (auto it : js_member) {
      member.push_back(Convert::json2vaddr(it));
    }
    
    return std::unique_ptr<TypeStore>
      (new TypeStore(addr, kind, size, alignment, member, VADDR_NULL, 0));
  } break;

  case TK_ARRAY:
  case TK_VECTOR: {
    vaddr_t element = Convert::json2vaddr(js_type.at("element"));
    unsigned int num = Convert::json2int<unsigned int>(js_type.at("num"));

    return std::unique_ptr<TypeStore>
      (new TypeStore(addr, kind, size, alignment, DUMMY_MEMBER, element, num));
  } break;
    
  default: {
    /// TODO:error
    assert(false);
    return std::unique_ptr<TypeStore>(nullptr);
  } break;
  }
}

// Calcuate a size and alignment for structure.
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

// Calucuate a size and alignment for some type.
std::pair<size_t, unsigned int> TypeStore::calc_type_size(VMemory::Accessor& memory,
							  vaddr_t type) {
  std::unique_ptr<TypeStore> t(std::move(TypeStore::read(memory, type)));
  
  return std::make_pair(t->size, t->alignment);
}
