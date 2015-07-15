
#include <cassert>

#include "error.hpp"
#include "util.hpp"
#include "vmemory.hpp"

using namespace processwarp;

// Constructor with device-id.
VMemory::VMemory(VMemoryDelegate& delegate_, dev_id_t dev_id_) :
  dev_id(dev_id_),
  rnd(std::random_device()()),
  delegate(delegate_) {
}

// Constructor with memory space.
VMemory::Accessor::Accessor(Space& space_) :
  space(space_) {
}

// Reserve address in program area.
vaddr_t VMemory::Accessor::reserve_program_area() {
  vaddr_t new_addr;

  do {
    new_addr = AD_PROGRAM | (~AD_MASK & space.rnd());
  } while(space.pages.find(new_addr) != space.pages.end());

  space.pages.insert(std::make_pair(new_addr, Page(PT_PROGRAM, true)));

  return new_addr;
}

// Set program data to be selected address.
void VMemory::Accessor::set_program_area(vaddr_t addr, const uint8_t* src, uint64_t size) {
  assert(space.pages.at(addr).value.size() == 0);

  space.pages.at(addr).value = std::string(reinterpret_cast<const char*>(src), size);
}

// Constructor with member value.
VMemory::Page::Page(PageType type_, bool flg_update_) :
  type(type_),
  flg_update(flg_update_) {
}

