
#include <algorithm>
#include <cassert>
#include <map>
#include <set>
#include <tuple>
#include <vector>

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
  if (nid == my_nid || nid == NodeID::THIS) {
    return NodeID::THIS;
  }

  if (nid == NodeID::NEXT) {
    return NodeID::NEXT;
  }

  if (next_minus_nid == NodeID::NONE) {
    if (is_explicit) {
      return NodeID::NONE;
    } else {
      /// @todo update score
      return NodeID::THIS;
    }

  } else {
    if (nid.is_between(range_min_nid, range_max_nid)) {
      if (is_explicit) {
        return NodeID::NONE;
      } else {
        /// @todo update score
        return NodeID::THIS;
      }

    } else {
      NodeID prev_nid;
      for (auto it : division_nid) {
        const NodeID& div_nid = std::get<0>(it);
        const NodeID& dst_nid = std::get<1>(it);

        if (nid < div_nid) {
          assert(prev_nid != NodeID::NONE);
          /// @todo update score
          return prev_nid;
        }

        prev_nid = dst_nid;
      }
      return std::get<1>(division_nid.back());
    }
  }
}

/**
 * Update connection status by score map.
 */
void Routing::execute() {
  std::vector<std::tuple<NodeID, int>> nid_list;
  for (auto& it : nid_score) {
    int factor = my_nid.distance_from(it.first).log2();
    nid_list.push_back(std::make_tuple(it.first, it.second * factor));
    it.second = it.second >> 2;
  }

  std::sort(nid_list.begin(), nid_list.end(),
            [](const std::tuple<NodeID, int>& a, const std::tuple<NodeID, int>& b) -> bool {
              return std::get<1>(a) < std::get<1>(b);
            });

  int i = 0;
  for (auto& it : nid_list) {
    NodeID& nid = std::get<0>(it);
    if (nid_map.find(nid) == nid_map.end()) {
      if (i < 8) {
        delegate.routing_connect(nid);
      }

    } else {
      if (i > 12 && nid != next_minus_nid && nid != next_plus_nid) {
        delegate.routing_disconnect(nid);
      }
    }
    i++;
  }
  connect_next_node();
}

/**
 * @param nids A set of edges those are online.
 */
void Routing::on_change_online_edges(const std::set<NodeID>& nids) {
  bool is_changed = false;
  // Add some nid to nid_map if nid exist in nids and do not exist in nid_map.
  for (auto& nid : nids) {
    if (nid_map.find(nid) == nid_map.end()) {
      is_changed = true;
      nid_map.insert(std::make_pair(nid, std::set<NodeID>()));
    }
  }
  // Do nothing if online node-ids has not changed.
  if (!is_changed && nids.size() == nid_map.size()) {
    return;
  }
  // Remove some nid from nid_map if nid exist int nid_map and do not exist in nids.
  if (nids.size() != nid_map.size()) {
    auto it = nid_map.begin();
    while (it != nid_map.end()) {
      const NodeID& nid = it->first;
      if (nids.find(nid) == nids.end()) {
        it = nid_map.erase(it);
      } else {
        it++;
      }
    }
  }
  assert(nids.size() == nid_map.size());

  update_map();

  send_routing();
}

/**
 * When recieve routing packet, update map.
 * @param packet Received packet containing nids.
 */
void Routing::recv_routing(const Packet& packet) {
  assert(nid_map.find(packet.src_nid) != nid_map.end());

  picojson::array nids_js = packet.content.at("nids").get<picojson::array>();
  std::set<NodeID> nids;

  for (auto& it_nid : nids_js) {
    NodeID nid = NodeID::from_json(it_nid);
    nids.insert(nid);
  }

  if (nid_map.at(packet.src_nid) != nids) {
    nid_map.at(packet.src_nid) = nids;
    update_map();
  }
}

/**
 * If require of routing from local module, send routing_local command to local modules.
 */
void Routing::require_routing_local() {
  picojson::object content;
  content.insert(std::make_pair("range_min_nid", range_min_nid.to_json()));
  content.insert(std::make_pair("range_max_nid", range_max_nid.to_json()));
  delegate.routing_send_routing_local(content);
}

/**
 * If next node has exist, require connect to it by the delegate.
 */
void Routing::connect_next_node() {
  if (next_minus_nid == NodeID::NONE) {
    return;
  }

  if (nid_map.find(next_minus_nid) == nid_map.end()) {
    delegate.routing_connect(next_minus_nid);
  }
  if (nid_map.find(next_plus_nid) == nid_map.end()) {
    delegate.routing_connect(next_plus_nid);
  }
}

/**
 * Send routing packet.
 */
void Routing::send_routing() {
  picojson::object content;
  picojson::array nids;

  for (auto& it : nid_map) {
    nids.push_back(it.first.to_json());
  }
  content.insert(std::make_pair("nids", picojson::value(nids)));

  for (auto& it : nid_map) {
    delegate.routing_send_routing(true, it.first, content);
  }
}

/**
 * Update nid_score and make division_nid by nid_map.
 */
void Routing::update_map() {
  // Make a map that is pair of node and it's root(relay node between this node) node-id.
  std::map<NodeID, NodeID> nid_known;
  for (auto& it : nid_map) {
    const NodeID& root_nid = it.first;
    for (auto& nid : it.second) {
      if (nid_known.find(nid) != nid_known.end()) {
        if (root_nid.distance_from(my_nid) <
            nid_known.at(nid).distance_from(my_nid)) {
          nid_known.at(nid) = root_nid;
        }
      } else {
        nid_known.insert(std::make_pair(nid, root_nid));
      }
    }
  }
  for (auto& it : nid_map) {
    const NodeID& root_nid = it.first;
    nid_known[root_nid] = root_nid;
  }
  nid_known.erase(my_nid);
  // Update keys of nid_score.
  for (auto& it : nid_known) {
    const NodeID& nid = it.first;
    if (nid_score.find(nid) == nid_score.end()) {
      nid_score.insert(std::make_pair(nid, 0));
    }
  }
  if (nid_score.size() != nid_known.size()) {
    auto it = nid_score.begin();
    while (it != nid_score.end()) {
      const NodeID& nid = it->first;
      if (nid_known.find(nid) == nid_known.end()) {
        it = nid_score.erase(it);
      } else {
        it++;
      }
    }
  }
  assert(nid_score.size() == nid_known.size());

  division_nid.clear();

  // Save stored range and check after change update to send routing_local command.
  NodeID old_range_min_nid = range_min_nid;
  NodeID old_range_max_nid = range_max_nid;

  if (nid_map.size() == 0) {
    next_minus_nid = NodeID::NONE;
    next_plus_nid  = NodeID::NONE;
    range_min_nid = NodeID::MIN;
    range_max_nid = NodeID::MAX;

  } else {
    NodeID torus = NodeID::center_mod(nid_known.rbegin()->first, nid_known.begin()->first);
    if (torus < nid_known.begin()->first) {
      division_nid.push_back(std::make_tuple(NodeID::MIN, nid_known.rbegin()->second));
      division_nid.push_back(std::make_tuple(torus, nid_known.begin()->second));
    } else {
      division_nid.push_back(std::make_tuple(NodeID::MIN, nid_known.begin()->second));
    }

    NodeID prev_nid = NodeID::NONE;
    for (auto& it : nid_known) {
      if (prev_nid == NodeID::NONE) {
        prev_nid = it.first;
        continue;
      }

      NodeID center_nid = NodeID::center_mod(prev_nid, it.first);
      division_nid.push_back(std::make_tuple(center_nid, it.second));
      prev_nid = it.first;
    }

    if (!(torus < nid_known.begin()->first)) {
      division_nid.push_back(std::make_tuple(torus, nid_known.begin()->second));
    }

    next_minus_nid = nid_known.rbegin()->first;
    next_plus_nid  = NodeID::NONE;
    for (auto& it : nid_known) {
      if (my_nid < it.first) {
        next_plus_nid = it.first;
        break;
      } else {
        next_minus_nid = it.first;
      }
    }

    if (next_plus_nid == NodeID::NONE) {
      next_minus_nid = nid_known.rbegin()->first;
      next_plus_nid  = nid_known.begin()->first;
    }
    range_min_nid = NodeID::center_mod(next_minus_nid, my_nid);
    range_max_nid = NodeID::center_mod(my_nid, next_plus_nid);
  }

  // Change update to send routing_local command.
  if (old_range_min_nid != range_min_nid ||
      old_range_max_nid != range_max_nid) {
    require_routing_local();
  }
}
}  // namespace processwarp
