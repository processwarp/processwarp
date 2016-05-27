#pragma once

#include <set>

#include "packet.hpp"

namespace processwarp {
class RoutingDelegate {
 public:
  virtual ~RoutingDelegate();
  virtual void routing_connect(const NodeID& nid) = 0;
  virtual void routing_disconnect(const NodeID& nid) = 0;
  virtual void routing_update_next_nid(const NodeID& minus_nid, const NodeID& plus_nid) = 0;
};

class Routing {
 public:
  Routing(RoutingDelegate& delegate_,
          PacketController& packet_controller_, const NodeID& my_nid_);

  void execute();
  void on_change_online_connectors(const std::set<NodeID>& nids);
  void on_recv(const NodeID& src_nid);
  void on_send(const NodeID& dst_nid);
  void recv(Packet& packet);

 private:
  RoutingDelegate& delegate;
  PacketController& packet_controller;
  const NodeID& my_nid;

  std::set<NodeID> online_nids;
};
}  // namespace processwarp
