#pragma once

#include <picojson.h>

#include <string>

namespace processwarp {
/**
 * Node-id is assigned for each node process run in any devices.
 */
class NodeID {
 public:
  static const NodeID BROADCAST;
  static const NodeID NONE;
  static const NodeID SERVER;
  static const NodeID THIS;

  static NodeID from_str(const std::string str);
  static NodeID from_json(const picojson::value& json);
  static NodeID make_random();

  NodeID();
  NodeID(const NodeID& src);

  NodeID& operator=(const NodeID& src);
  bool operator==(const NodeID& b) const;
  bool operator!=(const NodeID& b) const;
  bool operator<(const NodeID& b) const;

  std::string to_str() const;
  picojson::value to_json() const;

 private:
  int type;
  uint64_t id[2];

  explicit NodeID(int type_);
  NodeID(uint64_t id0, uint64_t id1);
};
}  // namespace processwarp
