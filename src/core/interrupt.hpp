#pragma once

#include "types.hpp"

namespace processwarp {
/**
 * Basic class of interrupt in virtual-machine.
 */
class Interrupt {
 public:
  /**
   * Interrupt type.
   */
  enum Type {
    MEMORY_REQUIRE,
  };

  /** Interrupt type. */
  const Type type;

 protected:
  /**
   * Constructor with interrupt type.
   * @param type_ Interrupt type.
   */
  explicit Interrupt(Type type_) :
      type(type_) {
  }

  /**
   * Destructor.
   */
  virtual ~Interrupt() {}
};
}  // namespace processwarp
