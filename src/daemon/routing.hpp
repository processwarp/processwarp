#pragma once

#include <tuple>
#include <set>
#include <vector>

#include "packet.hpp"

namespace processwarp {
class RoutingDelegate {
 public:
  virtual ~RoutingDelegate();
  virtual void routing_connect(const NodeID& nid) = 0;
  virtual void routing_disconnect(const NodeID& nid) = 0;
  virtual void routing_send_routing(bool is_explicit, const NodeID& dst_nid,
                                    const picojson::object& content) = 0;
};

class Routing {
 public:
  Routing(RoutingDelegate& delegate_, const NodeID& my_nid_);

  NodeID get_relay_nid(const NodeID& nid, bool is_explicit);
  void execute();
  void on_change_online_connectors(const std::set<NodeID>& nids);
  void recv_routing(const Packet& packet);

 private:
  RoutingDelegate& delegate;
  const NodeID& my_nid;
  NodeID next_minus_nid;
  NodeID next_plus_nid;
  NodeID range_min_nid;
  NodeID range_max_nid;

  std::set<NodeID> online_nids;
  std::vector<std::tuple<NodeID, NodeID>> online_divisions;

  void send_routing();
};
}  // namespace processwarp
