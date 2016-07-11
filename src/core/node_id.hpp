#pragma once

#include <picojson.h>

#include <set>
#include <string>
#include <tuple>

namespace processwarp {
/**
 * Node-id is assigned for each node process run in any devices.
 */
class NodeID {
 public:
  static const NodeID NONE;
  static const NodeID SERVER;
  static const NodeID THIS;
  static const NodeID NEXT;

  static const NodeID MAX;
  static const NodeID MIN;

  static const NodeID QUARTER;

  static std::set<NodeID> from_json_array(const picojson::value& json);
  static NodeID from_str(const std::string str);
  static NodeID from_json(const picojson::value& json);
  static NodeID make_random();
  static picojson::value to_json_array(const std::set<NodeID>& nids);

  NodeID();
  NodeID(const NodeID& src);

  NodeID& operator=(const NodeID& src);
  bool operator==(const NodeID& b) const;
  bool operator!=(const NodeID& b) const;
  bool operator<(const NodeID& b) const;
  const NodeID operator+(const NodeID& b) const;

  static NodeID center_mod(const NodeID& a, const NodeID& b);

  NodeID distance_from(const NodeID& a) const;
  bool is_between(const NodeID& a, const NodeID& b) const;
  int log2() const;
  std::string to_str() const;
  picojson::value to_json() const;

 private:
  int type;
  uint64_t id[2];

  explicit NodeID(int type_);
  NodeID(uint64_t id0, uint64_t id1);

  static int compare(const NodeID& a, const NodeID& b);
  static std::tuple<uint64_t, uint64_t> add_mod(uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1);
  static std::tuple<uint64_t, uint64_t> shift_right(uint64_t a0, uint64_t a1);
};
}  // namespace processwarp
