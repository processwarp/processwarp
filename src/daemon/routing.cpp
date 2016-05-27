
#include <cassert>
#include <set>

#include "routing.hpp"

namespace processwarp {
RoutingDelegate::~RoutingDelegate() {
}

/**
 * Constructor, set using reference values.
 * @param delegate_ Delegate instance (should WebrtcBundle).
 * @param packet_controller_ PacketController instance using parent module.
 * @param my_nid_ Node-id of this node.
 */
Routing::Routing(RoutingDelegate& delegate_,
                 PacketController& packet_controller_, const NodeID& my_nid_) :
    delegate(delegate_),
    packet_controller(packet_controller_),
    my_nid(my_nid_) {
}

void Routing::execute() {
  /// @todo
  assert(false);
}

/**
 * @param nids A set of connectors those are online.
 */
void Routing::on_change_online_connectors(const std::set<NodeID>& nids) {
  if (nids == online_nids) {
    return;

  } else {
    online_nids = nids;
  }

  if (online_nids.size() == 0) {
    delegate.routing_update_next_nid(NodeID::NONE, NodeID::NONE);

  } else {
    /// @todo
    assert(false);
  }
}

void Routing::on_recv(const NodeID& src_nid) {
  /// @todo
  assert(false);
}

void Routing::on_send(const NodeID& dst_nid) {
  /// @todo
  assert(false);
}

void Routing::recv(Packet& packet) {
  /// @todo
  assert(false);
}
}  // namespace processwarp
