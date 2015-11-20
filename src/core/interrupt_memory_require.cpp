
#include "interrupt_memory_require.hpp"
#include "vmemory.hpp"

namespace processwarp {

// Constructor with address.
InterruptMemoryRequire::InterruptMemoryRequire(vaddr_t addr_) :
    Interrupt(Interrupt::MEMORY_REQUIRE),
    addr(addr_) {
  assert(addr == VMemory::get_upper_addr(addr));
}
}  // namespace processwarp
