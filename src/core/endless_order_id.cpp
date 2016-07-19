
#include <string>

#include "convert.hpp"
#include "endless_order_id.hpp"

namespace processwarp {

namespace Order {
static const int SMALLER    = -1;
static const int EQUAL      = 0;
static const int GREATER    = 1;
}  // namespace Order

/**
 * Make a endless-order-id from a JSON
 * @param json A source JSON value.
 * @return A endless-order-id.
 */
EndlessOrderID EndlessOrderID::from_json(const picojson::value& json) {
  uint32_t value = Convert::json2int<uint32_t>(json);
  return EndlessOrderID(value);
}

/**
 * Constructor, it set default value to minimam value.
 */
EndlessOrderID::EndlessOrderID() :
    value(0xFFFFFFFF) {
}

/**
 * Constructor with selected value.
 * @param value_ A value.
 */
EndlessOrderID::EndlessOrderID(uint32_t value_) :
    value(value_) {
}

/**
 * Copy constructor, it copy inner value.
 * @param src A copy source.
 */
EndlessOrderID::EndlessOrderID(const EndlessOrderID& src) :
    value(src.value) {
}

EndlessOrderID& EndlessOrderID::operator=(const EndlessOrderID& src) {
  value = src.value;

  return *this;
}

bool EndlessOrderID::operator==(const EndlessOrderID& src) const {
  return value == src.value;
}

bool EndlessOrderID::operator>(const EndlessOrderID& src) const {
  return compare(value, src.value) == Order::GREATER;
}

EndlessOrderID& EndlessOrderID::operator+=(uint32_t b) {
  value += b;
  if (value >= 0xC0000000) {
    value &= 0x3FFFFFFF;
  }

  return *this;
}

/**
 * Convert a endless-order-id to a JSON.
 * @return A endless-order-id as a JSON.
 */
picojson::value EndlessOrderID::to_json() const {
  return Convert::int2json(value);
}

/**
 * Convert a endless-order-id to a string.
 * @return A endless-order-id as a string.
 */
std::string EndlessOrderID::to_str() const {
  return Convert::int2str(value);
}

/**
 * Compare a pair of innver value like the java's Compare interface.
 * @return -1 if a < b. 0 if a == b. 1 if a > b.
 */
int EndlessOrderID::compare(uint32_t a, uint32_t b) {
  static const int HEAD_ORDER[] = {
    Order::EQUAL,   Order::SMALLER, Order::GREATER, Order::GREATER,
    Order::GREATER, Order::EQUAL,   Order::SMALLER, Order::GREATER,
    Order::SMALLER, Order::GREATER, Order::EQUAL,   Order::GREATER,
    Order::SMALLER, Order::SMALLER, Order::SMALLER, Order::EQUAL
  };

  uint32_t head = ((a >> 28) & 0x0C) | ((b >> 30) & 0x03);
  int head_order = HEAD_ORDER[head];

  if (head_order == Order::EQUAL) {
    if ((a & 0x3FFFFFFF) < (b & 0x3FFFFFFF)) {
      return Order::SMALLER;

    } else if (a == b) {
      return Order::EQUAL;

    } else {
      return Order::GREATER;
    }

  } else {
    return head_order;
  }
}
}  // namespace processwarp
