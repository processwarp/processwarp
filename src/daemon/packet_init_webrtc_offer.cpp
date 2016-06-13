
#include <cassert>
#include <string>

#include "convert.hpp"
#include "packet_init_webrtc_offer.hpp"
#include "server_connector.hpp"

namespace processwarp {
const PacketController::Define& PacketInitWebrtcOffer::get_define() {
  static const PacketController::Define DEFINE = {
    "init_webrtc_offer",
    0,
    0,
    Module::NETWORK,
  };

  return DEFINE;
}

/**
 * When error packet has arrived from target node, convert to init_webrtc deny command and send it to the server.
 * @param packet
 */
void PacketInitWebrtcOffer::on_error(const Packet& packet) {
  ServerConnector& server = ServerConnector::get_instance();
  NodeID prime_nid = NodeID::from_json(packet.content.at("packet_nid"));
  int reason = Convert::json2int<int>(packet.content.at("reason"));

  server.send_init_webrtc_deny(prime_nid, reason);
}

void PacketInitWebrtcOffer::on_packet_error(PacketError::Type code) {
  /// @todo error
  assert(false);
}

/**
 * When reply packet has arrived, convert to init_webrtc reply command and send it to the server.
 * @param packet
 */
void PacketInitWebrtcOffer::on_reply(const Packet& packet) {
  ServerConnector& server = ServerConnector::get_instance();
  NodeID prime_nid = NodeID::from_json(packet.content.at("prime_nid"));
  NodeID second_nid = NodeID::from_json(packet.content.at("second_nid"));
  const std::string& sdp = packet.content.at("sdp").get<std::string>();

  server.send_init_webrtc_reply(prime_nid, second_nid, sdp);
}
}  // namespace processwarp
