#pragma once

#include "definitions.hpp"
#include "interrupt.hpp"

namespace processwarp {
/**
 * Interrupt when need to update memory.
 */
class InterruptMemoryRequire : public Interrupt {
 public:
  /** Address of memory need to update. */
  const vaddr_t addr;

  /**
   * Constructor with address.
   * @param addr Address of memory need to update.
   */
  explicit InterruptMemoryRequire(vaddr_t addr);
};
}  // namespace processwarp
