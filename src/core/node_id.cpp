
#ifdef WITH_RE2
#  include <re2/re2.h>
#else
#  include <regex>
#endif
#include <string>

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

NodeID& NodeID::operator=(const NodeID& src) {
  type = src.type;
  id[0] = src.id[0];
  id[0] = src.id[1];

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

/**
 * Convert a node-id to a string.
 * @param nid A source node-id.
 * @return Converted value as a string.
 */
std::string NodeID::to_str() const {
  return Util::num2hex_str(id[0]) + Util::num2hex_str(id[1]);
}

/**
 * Convert a node-id to a JSON.
 * @param nid A source node-id.
 * @return Node-id as a JSON.
 */
picojson::value NodeID::to_json() const {
  return picojson::value(to_str());
}

}  // namespace processwarp
