#pragma once

#include <map>
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
  virtual void routing_send_routing_local(const picojson::object& content) = 0;
};

class Routing {
 public:
  Routing(RoutingDelegate& delegate_, const NodeID& my_nid_);

  NodeID get_relay_nid(const NodeID& nid, bool is_explicit);
  void execute();
  void on_change_online_connectors(const std::set<NodeID>& nids);
  void recv_routing(const Packet& packet);
  void require_routing_local();

 private:
  RoutingDelegate& delegate;
  const NodeID& my_nid;
  /** Next node-id. */
  NodeID next_minus_nid;
  NodeID next_plus_nid;
  /** Node-id range of supported by this node. */
  NodeID range_min_nid;
  NodeID range_max_nid;

  /** Map of direct connect node-id and node-ids are connected to itself. */
  std::map<NodeID, std::set<NodeID>> nid_map;
  std::map<NodeID, int> nid_score;
  std::vector<std::tuple<NodeID, NodeID>> division_nid;

  void connect_next_node();
  void send_routing();
  void update_map();
};
}  // namespace processwarp
