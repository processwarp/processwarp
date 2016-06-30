
#include <cassert>
#include <functional>
#include <random>
#ifdef WITH_RE2
#  include <re2/re2.h>
#else
#  include <regex>
#endif
#include <string>
#include <tuple>

#include "constant.hpp"
#include "node_id.hpp"
#include "util.hpp"

namespace processwarp {
// Node types.
namespace Type {
static const int NONE       = 0;
static const int NORMAL     = 1;
static const int THIS       = 2;
static const int SERVER     = 3;
static const int BROADCAST  = 4;
}  // namespace Type

const NodeID NodeID::BROADCAST(Type::BROADCAST);
const NodeID NodeID::NONE(Type::NONE);
const NodeID NodeID::SERVER(Type::SERVER);
const NodeID NodeID::THIS(Type::THIS);

const NodeID NodeID::MAX(0xFFFFFFFFFFFFFFFF, 0xFFFFFFFFFFFFFFFF);
const NodeID NodeID::MIN(0x0000000000000000, 0x0000000000000000);

const NodeID NodeID::QUARTER(0x4000000000000000, 0x0000000000000000);

/**
 * Default constructor, it set NONE value.
 */
NodeID::NodeID() :
    type(Type::NONE),
    id {0, 0} {
}

/**
 * Copy constructor, copy type and id.
 * @param src Copy source.
 */
NodeID::NodeID(const NodeID& src) :
    type(src.type),
    id {src.id[0], src.id[1]} {
}

/**
 * Constructor with a special node type.
 * @param type_ A special node type without normal.
 */
NodeID::NodeID(int type_) :
    type(type_),
    id {0, 0} {
  assert(type_ != Type::NORMAL);
}

/**
 * Constructor with a node-id.
 * @param id0 ID of the first half 64bit.
 * @param id1 ID of the latter half 64bit.
 */
NodeID::NodeID(uint64_t id0, uint64_t id1) :
    type(Type::NORMAL),
    id {id0, id1} {
}

/**
 * Make a node-id from a string.
 * @param str A source string value.
 * @return A node-id.
 */
NodeID NodeID::from_str(const std::string str) {
#ifdef WITH_RE2
  static re2::RE2 expression("([0-9A-Fa-f]){32}");
  bool is_normal = RE2::FullMatch(str, expression);

#else  // else WITH_RE2
  std::regex expression("([0-9A-Fa-f]){32}");
  bool is_normal = std::regex_match(str, expression);
#endif  // WITH_RE2

  if (is_normal) {
    return NodeID(Util::hex_str2num<uint64_t>(str.substr(0,  16)),
                  Util::hex_str2num<uint64_t>(str.substr(16, 16)));

  } else {
    if (str == NID::NONE) {
      return NONE;

    } else if (str == NID::THIS) {
      return THIS;

    } else if (str == NID::BROADCAST) {
      return BROADCAST;

    } else if (str == NID::SERVER) {
      return SERVER;

    } else {
      /// TDDO error
      assert(false);
    }
  }
}

/**
 * Make a node-id from JSON
 * @param json A source JSON value.
 * @return A node-id.
 */
NodeID NodeID::from_json(const picojson::value& json) {
  return from_str(json.get<std::string>());
}

/**
 * Make a rundom node-id.
 * @return A node-id.
 */
NodeID NodeID::make_random() {
  std::random_device seed_gen;
  std::mt19937_64 rnd(seed_gen());

  return NodeID(rnd(), rnd());
}

NodeID& NodeID::operator=(const NodeID& src) {
  type = src.type;
  id[0] = src.id[0];
  id[1] = src.id[1];

  return *this;
}

bool NodeID::operator==(const NodeID& b) const {
  if (type == b.type) {
    if (type == Type::NORMAL) {
      return (id[0] == b.id[0] && id[1] == b.id[1]);

    } else {
      return true;
    }

  } else {
    return false;
  }
}

bool NodeID::operator!=(const NodeID& b) const {
  return !(*this == b);
}

bool NodeID::operator<(const NodeID& b) const {
  if (type == b.type) {
    if (type == Type::NORMAL) {
      if (id[0] == b.id[0]) {
        return id[1] < b.id[1];
      } else {
        return id[0] < b.id[0];
      }

    } else {
      return false;
    }

  } else {
    return type < b.type;
  }
}

const NodeID NodeID::operator+(const NodeID& b) const {
  assert(type == Type::NORMAL);
  assert(b.type == Type::NORMAL);

  uint64_t c0, c1;
  std::tie(c0, c1) = add_mod(id[0], id[1], b.id[0], b.id[1]);

  return NodeID(c0, c1);
}

/**
 * Calculate central node-id of A and B.
 * Node-id is placed on torus.
 * If node-id of A is larger than B, return value is smaller than A or larger than B.
 * A and B must be NORMAL node-id.
 * @param a Node-id A.
 * @param b Node-id B.
 * @return Central node-id.
 */
NodeID NodeID::center_mod(const NodeID& a, const NodeID& b) {
  assert(a.type == Type::NORMAL);
  assert(b.type == Type::NORMAL);

  uint64_t a0, a1, b0, b1;
  std::tie(a0, a1) = shift_right(a.id[0], a.id[1]);
  std::tie(b0, b1) = shift_right(b.id[0], b.id[1]);

  uint64_t c0, c1;
  std::tie(c0, c1) = add_mod(a0, a1, b0, b1);

  if (a.id[1] & 0x01 && b.id[1] & 0x1) {
    std::tie(c0, c1) = add_mod(c0, c1, 0x00, 0x01);
  }

  if (b < a) {
    std::tie(c0, c1) = add_mod(c0, c1, 0x8000000000000000, 0x0000000000000000);
  }

  return NodeID(c0, c1);
}

/**
 * Calculate a distance between this node-id and node-id of A.
 * @param a Node-id A.
 * @return A distance between this node-id and node-id of A.
 */
NodeID NodeID::distance_from(const NodeID& a) const {
  assert(type == Type::NORMAL);
  assert(a.type == Type::NORMAL);

  uint64_t a0, a1, b0, b1;

  if (*this < a) {
    a0 = a.id[0];
    a1 = a.id[1];
    b0 = ~id[0];
    b1 = ~id[1];

  } else {
    a0 = id[0];
    a1 = id[1];
    b0 = ~a.id[0];
    b1 = ~a.id[1];
  }

  std::tie(a0, a1) = add_mod(a0, a1, b0, b1);
  std::tie(a0, a1) = add_mod(a0, a1, 0x0, 0x1);

  if (a0 >= 0x8000000000000000) {
    std::tie(a0, a1) = add_mod(0x8000000000000000, 0x0000000000000000, ~a0, ~a1);
    std::tie(a0, a1) = add_mod(a0, a1, 0x0, 0x1);
  }

  return NodeID(a0, a1);
}

/**
 * Check a node-id is placed between node-id of A and B.
 * Node-id is placed on torus.
 * If node-id of A is larger than B, return true if this < B or A <= this.
 * @param a Node-id A.
 * @param b Node-id B.
 * @return True if A <= this < B.
 */
bool NodeID::is_between(const NodeID& a, const NodeID& b) const {
  assert(type   == Type::NORMAL);
  assert(a.type == Type::NORMAL);
  assert(b.type == Type::NORMAL);

  switch (compare(a, b)) {
    case -1: {
      if (compare(a, *this) != 1 && compare(*this, b) == -1) {
        return true;
      } else {
        return false;
      }
    } break;

    case 0: {
      return false;
    } break;

    case 1: {
      if ((compare(a, *this) != 1 && compare(*this, MAX) != 1) ||
          (compare(MIN, *this) != 1 && compare(*this, b) == -1)) {
        return true;
      } else {
        return false;
      }
    } break;

    default: {
      assert(false);
      return false;
    } break;
  }
}

/**
 * Calculate log(2) from this node-id.
 * @param return log2(node-id)
 */
int NodeID::log2() const {
  static const uint64_t TOP = 0x8000000000000000;
  for (unsigned int i = 0; i <= sizeof(id[0]); i++) {
    if ((TOP >> i) & id[0]) {
      return i + 64;
    }
  }
  for (unsigned int i = 0; i <= sizeof(id[1]); i++) {
    if ((TOP >> i) & id[1]) {
      return i;
    }
  }
  return 0;
}

/**
 * Convert a node-id to a string.
 * @param nid A source node-id.
 * @return Converted value as a string.
 */
std::string NodeID::to_str() const {
  switch (type) {
    case Type::NONE: {
      return NID::NONE;
    } break;

    case Type::NORMAL: {
      return Util::num2hex_str(id[0]) + Util::num2hex_str(id[1]);
    } break;

    case Type::THIS: {
      return NID::THIS;
    } break;

    case Type::SERVER: {
      return NID::SERVER;
    } break;

    case Type::BROADCAST: {
      return NID::BROADCAST;
    } break;

    default: {
      /// @todo error
      assert(false);
      return NID::NONE;
    } break;
  }
}

/**
 * Convert a node-id to a JSON.
 * @param nid A source node-id.
 * @return Node-id as a JSON.
 */
picojson::value NodeID::to_json() const {
  return picojson::value(to_str());
}

/**
 * Compare a pair of NORMAL value like the java's Compare interface.
 * @return -1 if a < b. 0 if a == b. 1 if a > b.
 */
int NodeID::compare(const NodeID& a, const NodeID& b) {
  assert(a.type == Type::NORMAL);
  assert(b.type == Type::NORMAL);

  if (a.id[0] < b.id[0]) {
    return -1;
  } else if (a.id[0] > b.id[0]) {
    return 1;
  }

  if (a.id[1] < b.id[1]) {
    return -1;
  } else if (a.id[1] == b.id[1]) {
    return 0;
  } else {
    return 1;
  }
}

/**
 * Calculate unsigned add node-id A and B on module MAX space.
 * @param a0 Node-id A's upper value.
 * @param a1 Node-id A's lower value.
 * @param a0 Node-id B's upper value.
 * @param a1 Node-id B's lower value.
 * @return Calucated value's upper and lower pair.
 */
std::tuple<uint64_t, uint64_t> NodeID::add_mod(uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1) {
  uint64_t d0, d1;
  uint64_t c0, c1;

  // Lower.
  c1 = (0x7FFFFFFFFFFFFFFF & a1) + (0x7FFFFFFFFFFFFFFF & b1);
  d1 = (a1 >> 63) + (b1 >> 63) + (c1 >> 63);
  c1 = ((d1 << 63) & 0x8000000000000000) | (c1 & 0x7FFFFFFFFFFFFFFF);
  // Upper.
  c0 = (0x3FFFFFFFFFFFFFFF & a0) + (0x3FFFFFFFFFFFFFFF & b0) + (d1 >> 1);
  d0 = (a0 >> 62) + (b0 >> 62) + (c0 >> 62);
  c0 = ((d0 << 62) & 0xC000000000000000) | (c0 & 0x3FFFFFFFFFFFFFFF);

  return std::forward_as_tuple(c0, c1);
}

/**
 * Calucate 1 bit right shift for node-id.
 * @param a0 Node-id's upper value.
 * @param a1 Node-id's lower value.
 * @return Calucated value's upper and lower pair.
 */
std::tuple<uint64_t, uint64_t> NodeID::shift_right(uint64_t a0, uint64_t a1) {
  uint64_t c0, c1;

  c1 = ((a0 << 63) & 0x8000000000000000) | ((a1 >> 1) & 0x7FFFFFFFFFFFFFFF);
  c0 = a0 >> 1;

  return std::forward_as_tuple(c0, c1);
}

}  // namespace processwarp
