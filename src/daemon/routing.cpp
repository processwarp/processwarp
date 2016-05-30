
#include <cassert>
#include <set>

#include "routing.hpp"

namespace processwarp {
RoutingDelegate::~RoutingDelegate() {
}

/**
 * Constructor, set using reference values.
 * @param delegate_ Delegate instance (should WebrtcBundle).
 * @param my_nid_ Node-id of this node.
 */
Routing::Routing(RoutingDelegate& delegate_, const NodeID& my_nid_) :
    delegate(delegate_),
    my_nid(my_nid_) {
}

/**
 * Get node-id for relaying packet to send a packet to target node.
 * @param nid Target node-id.
 * @param is_explicit
 * @retrn THIS for local node, NORMAL node-id for another node, NONE if target node has not exist.
 */
NodeID Routing::get_relay_nid(const NodeID& nid, bool is_explicit) {
  if (my_nid == nid) {
    return NodeID::THIS;
  }

  if (next_minus_nid == NodeID::NONE) {
    if (is_explicit) {
      return NodeID::NONE;
    } else {
      return NodeID::THIS;
    }

  } else {
    if (nid.is_between(range_min_nid, range_max_nid)) {
      if (is_explicit) {
        return NodeID::NONE;
      } else {
        return NodeID::THIS;
      }

    } else {
      NodeID prev_nid;
      for (auto it : online_divisions) {
        const NodeID& div_nid = std::get<0>(it);
        const NodeID& dst_nid = std::get<1>(it);

        if (nid < div_nid) {
          assert(prev_nid != NodeID::NONE);
          return prev_nid;
        }

        prev_nid = dst_nid;
      }
    }
    assert(false);
    return NodeID::NONE;
  }
}

void Routing::execute() {
  /// @todo
  assert(false);
}

/**
 * @param nids A set of connectors those are online.
 */
void Routing::on_change_online_connectors(const std::set<NodeID>& nids) {
  // Do nothing if online node-ids has not changed.
  if (nids == online_nids) {
    return;
  } else {
    online_nids = nids;
  }

  online_divisions.clear();

  if (online_nids.size() == 0) {
    next_minus_nid = NodeID::NONE;
    next_plus_nid  = NodeID::NONE;
    range_min_nid = NodeID::MIN;
    range_max_nid = NodeID::MAX;

  } else {
    NodeID torus = NodeID::center_mod(*online_nids.rbegin(), *online_nids.begin());
    if (torus < *online_nids.begin()) {
      online_divisions.push_back(std::make_tuple(NodeID::MIN, *online_nids.rbegin()));
      online_divisions.push_back(std::make_tuple(torus, *online_nids.begin()));
    } else {
      online_divisions.push_back(std::make_tuple(NodeID::MIN, *online_nids.begin()));
    }

    NodeID prev_nid = NodeID::NONE;
    for (auto nid : online_nids) {
      if (prev_nid == NodeID::NONE) {
        prev_nid = nid;
        continue;
      }

      NodeID center_nid = NodeID::center_mod(prev_nid, nid);
      online_divisions.push_back(std::make_tuple(center_nid, nid));
      prev_nid = nid;
    }

    if (!(torus < *online_nids.begin())) {
      online_divisions.push_back(std::make_tuple(torus, *online_nids.begin()));
    }
    // Add the terminator.
    online_divisions.push_back(std::make_tuple(NodeID::MAX, NodeID::NONE));

    next_minus_nid = *online_nids.rbegin();
    next_plus_nid  = NodeID::NONE;
    for (auto nid : online_nids) {
      if (my_nid < nid) {
        next_plus_nid = nid;
        break;
      } else {
        next_minus_nid = nid;
      }
    }

    if (next_plus_nid == NodeID::NONE) {
      next_minus_nid = *online_nids.rbegin();
      next_plus_nid  = *online_nids.begin();
    }
    range_min_nid = NodeID::center_mod(next_minus_nid, my_nid);
    range_max_nid = NodeID::center_mod(my_nid, next_plus_nid);
  }

  send_routing();
}

/**
 * Process that execute when recieve routing packet.
 * @todo dummy algorithm
 * @param packet
 */
void Routing::recv_routing(const Packet& packet) {
  picojson::array nids = packet.content.at("nids").get<picojson::array>();

  for (auto& it_nid : nids) {
    NodeID nid = NodeID::from_json(it_nid);

    if (nid != my_nid && online_nids.find(nid) == online_nids.end()) {
      delegate.routing_connect(nid);
    }
  }
}

/**
 * Send routing packet.
 */
void Routing::send_routing() {
  picojson::object content;
  picojson::array nids;

  for (auto& nid : online_nids) {
    nids.push_back(nid.to_json());
  }
  content.insert(std::make_pair("nids", picojson::value(nids)));

  for (auto& nid : online_nids) {
    delegate.routing_send_routing(true, nid, content);
  }
}
}  // namespace processwarp
