
#include "interrupt_memory_require.hpp"
#include "vmemory.hpp"

using namespace processwarp;

// Constructor with address.
InterruptMemoryRequire::InterruptMemoryRequire(vaddr_t addr_) :
  Interrupt(Interrupt::MEMORY_REQUIRE),
  addr(addr_) {
  assert(addr == VMemory::get_upper_addr(addr));
}
