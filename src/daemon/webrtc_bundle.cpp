
#include <cassert>
#include <set>
#include <string>

#include "constant.hpp"
#include "convert.hpp"
#include "network_connector.hpp"
#include "packet_init_webrtc_offer.hpp"
#include "router.hpp"
#include "webrtc_bundle.hpp"

namespace processwarp {

/**
 * WebrtcBundle instance getter as singleton pattern.
 * @return The singleton instance of WebrtcBundle class.
 */
WebrtcBundle& WebrtcBundle::get_instance() {
  static WebrtcBundle instance;
  return instance;
}

/**
 * Constructor for singleton pattern.
 * Set default value to instance members.
 * This class is singleton.
 * This method is private.
 */
WebrtcBundle::WebrtcBundle() :
    packet_controller(Module::NETWORK),
    routing(*this, my_nid) {
}

/**
 * Simple destructor for vtable.
 */
WebrtcBundle::~WebrtcBundle() {
}

/**
 * Change connector's handler to me.
 * @param connector WebRTC connector.
 */
void WebrtcBundle::apply_connector(WebrtcConnector* connector) {
  connector->delegate = this;
  uv_async_send(&async_ucs);
}

/**
 * Create new WebRTC connector.
 * Connector handle will change by apply_connector or will release by purge_connector.
 * @return A new WebRTC connector.
 */
WebrtcConnector* WebrtcBundle::create_connector() {
  WebrtcConnector* connector = new WebrtcConnector(peer_connection_factory, pc_config, dc_config);
  connectors.insert(std::make_pair(connector, std::unique_ptr<WebrtcConnector>(connector)));

  return connector;
}

/**
 * Release all connectors and release WebRTC resources.
 */
void WebrtcBundle::finalize() {
  // It must close connections with subthread alive.
  connectors.clear();
  peer_connection_factory = nullptr;

  // Subthread will quit after release resources.
  thread->Quit();
  uv_thread_join(&subthread);

  // Close async handler.
  uv_close(reinterpret_cast<uv_handle_t*>(&async_ucs), nullptr);

  rtc::CleanupSSL();
}

/**
 * Initialize WebRTC library and create a thread.
 * @param loop_ Loop for WebrtcBundle.
 */
void WebrtcBundle::initialize(uv_loop_t* loop_) {
  loop = loop_;

  // Initialize synchronizer.
  uv_async_init(loop, &async_ucs, update_connector_status);

  // Initalize PacketController
  packet_controller.initialize(this);

  // Initialize WebRTC
  rtc::InitializeSSL();
  uv_thread_create(&subthread, WebrtcBundle::subthread_entry, this);
}

/**
 * Purge WebRTC connector.
 * Unset handler and delete the connector instance.
 * @param connector WebRTC onnector.
 */
void WebrtcBundle::purge_connector(WebrtcConnector* connector) {
  connector->delegate = nullptr;
  connectors.erase(connector);
}

/**
 * When nid has changed, store it and set it to packet controller.
 * @param nid A new node-id for this node.
 */
void WebrtcBundle::set_nid(const NodeID& nid) {
  my_nid = nid;
  packet_controller.my_nid = nid;
}

/**
 * Receive packet from modules and relay it by deciding destination module.
 * @param packet A packet.
 */
void WebrtcBundle::relay(const Packet& packet) {
#ifndef NDEBUG
  std::cout << __LINE__ << "@" << __FILE__ << ":relay" << std::endl;
  std::cout << "  packet_id:" << Convert::int2str(packet.packet_id) << std::endl;
  std::cout << "  command:" << packet.command << std::endl;
  std::cout << "  mode:" << Convert::int2str(packet.mode) << std::endl;
  std::cout << "  dst_module:" << Convert::int2str(packet.dst_module) << std::endl;
  std::cout << "  src_module:" << Convert::int2str(packet.src_module) << std::endl;
  std::cout << "  pid:" << Convert::vpid2str(packet.pid) << std::endl;
  std::cout << "  dst_nid:" << packet.dst_nid.to_str() << std::endl;
  std::cout << "  src_nid:" << packet.src_nid.to_str() << std::endl;
  std::cout << "  content:" << picojson::value(packet.content).serialize()
            << std::endl << std::endl;
  std::cout << "  my_nid:" << my_nid.to_str() << std::endl;
#endif  // NDEBUG

  NodeID dst_nid = routing.get_relay_nid(packet.dst_nid,
                                         packet.mode & PacketMode::EXPLICIT);

  if (dst_nid == NodeID::THIS) {
    relay_to_local(packet);
  } else if (dst_nid == NodeID::NONE) {
    send_packet_error(packet, PacketError::NOT_EXIST);
  } else {
    relay_to_another(packet);
  }
}

/**
 * Receive init_webrtc ice command, relay it to target node.
 * @param local_nid Source node-id of WebRTC ICE.
 * @param remote_nid A pair node-id for source node-id, and it is target node-id to relay.
 * @param ice ICE string.
 */
void WebrtcBundle::relay_init_webrtc_ice(const NodeID& local_nid, const NodeID& remote_nid,
                                         const std::string& ice) {
  picojson::object content;

  content.insert(std::make_pair("local_nid", local_nid.to_json()));
  content.insert(std::make_pair("remote_nid", remote_nid.to_json()));
  content.insert(std::make_pair("ice", picojson::value(ice)));

  packet_controller.send("init_webrtc_ice", Module::NETWORK, true,
                         PID::BROADCAST, remote_nid, content);
}

/**
 * Receive init_webrtc offer command, relay it to target node by using PacketInitWebrtcOffer.
 * It will be return result packet.
 * @param prime_nid A primary node-id of WebRTC connection sequence.
 * @param sdp SDP string from the primary node.
 */
void WebrtcBundle::relay_init_webrtc_offer(const NodeID& prime_nid, const std::string& sdp) {
  std::unique_ptr<PacketController::Behavior> behavior(new PacketInitWebrtcOffer());
  picojson::object content;

  content.insert(std::make_pair("prime_nid", prime_nid.to_json()));
  content.insert(std::make_pair("sdp", picojson::value(sdp)));

  packet_controller.send(std::move(behavior), PID::BROADCAST, prime_nid, content);
}

/**
 * When receive general command, relay it to capable method.
 * @param packet A packet.
 */
void WebrtcBundle::packet_controller_on_recv(const Packet& packet) {
  if (packet.command == "routing") {
    routing.recv_routing(packet);

  } else if (packet.command == "init_webrtc_ice") {
    recv_init_webrtc_ice(packet);

  } else if (packet.command == "init_webrtc_offer") {
    recv_init_webrtc_offer(packet);

  } else {
    /// @todo drop message
    std::cout << __LINE__ << "@" << __FILE__
              << ":packet_controller_on_recv:" << packet.command << std::endl;
    assert(false);
  }
}

/**
 * When send packet event has happen on PacketController, relay it to relay method.
 * @param packet A packet to relay.
 */
void WebrtcBundle::packet_controller_send(const Packet& packet) {
  relay(packet);
}

void WebrtcBundle::routing_connect(const NodeID& nid) {
  /// @todo
  assert(false);
}

void WebrtcBundle::routing_disconnect(const NodeID& nid) {
  /// @todo
  assert(false);
}

/**
 * Send routing packet, when request of sending routing packet has called from Routing module.
 * @param is_explicit Switch of EXPLICIT flug for packet.
 * @param dst_nid, Destination node-id.
 * @param content, Packet content.
 */
void WebrtcBundle::routing_send_routing(bool is_explicit, const NodeID& dst_nid,
                                        const picojson::object& content) {
  packet_controller.send("routing", Module::NETWORK, is_explicit,
                         PID::BROADCAST, dst_nid, content);
}

/**
 * Raise update_connector_status on another thread, when a connector status has changed.
 * @param connector Connector that status has changed.
 * @param is_connect Connection status (True if connection has enabled.).
 */
void WebrtcBundle::webrtc_connector_on_change_stateus(WebrtcConnector& connector, bool is_connect) {
  uv_async_send(&async_ucs);
}

/**
 * When ice update event has happen on initializing connector,
 * send init_webrtc_ice command to the pair node.
 * @param connector Initializing connector.
 * @param ice ICE string.
 */
void WebrtcBundle::webrtc_connector_on_update_ice(WebrtcConnector& connector,
                                                  const std::string ice) {
  auto it_connector = init_map.find(&connector);
  if (it_connector != init_map.end()) {
    picojson::object content;

    content.insert(std::make_pair("local_nid", my_nid.to_json()));
    content.insert(std::make_pair("remote_nid", connector.nid.to_json()));
    content.insert(std::make_pair("ice", picojson::value(ice)));

    packet_controller.send("init_webrtc_ice", Module::NETWORK, true,
                           PID::BROADCAST, it_connector->second, content);

  } else {
    /// @todo
    assert(false);
  }
}

/**
 * When update connector status, collect online node-ids and pass to routing module.
 * @param handle libuv's handler.
 */
void WebrtcBundle::update_connector_status(uv_async_t* handle) {
  WebrtcBundle& THIS = get_instance();
  std::set<NodeID> nids;

  for (auto& it_connector : THIS.connectors) {
    WebrtcConnector& connector = *(it_connector.first);
    if (connector.is_connected) {
      nids.insert(connector.nid);
    }
  }
  THIS.routing.on_change_online_connectors(nids);
}

/**
 * WebRTC worker thread entry method.
 * Initialize library and start loop.
 */
void WebrtcBundle::subthread_entry(void* arg) {
  WebrtcBundle& THIS = *reinterpret_cast<WebrtcBundle*>(arg);

  THIS.peer_connection_factory = webrtc::CreatePeerConnectionFactory();
  if (THIS.peer_connection_factory.get() == nullptr) {
    std::cout << "Error on CreatePeerConnectionFactory." << std::endl;
    /// @todo error
    assert(false);
  }

  // Using Google's STUN server.
  /// @todo Read STUN url from configure.
  webrtc::PeerConnectionInterface::IceServer ice_server;
  ice_server.uri = "stun:stun.l.google.com:19302";
  THIS.pc_config.servers.push_back(ice_server);

  THIS.thread = rtc::Thread::Current();
  THIS.thread->set_socketserver(&THIS.socket_server);
  THIS.thread->Run();
  THIS.thread->set_socketserver(nullptr);
}

/**
 * When recieve init_webrtc ice command, update ICE of initializeing connector if target is this node.
 * Otherwise, relay it to the server. Because, it should be relayed by this node.
 */
void WebrtcBundle::recv_init_webrtc_ice(const Packet& packet) {
  NodeID local_nid = NodeID::from_json(packet.content.at("local_nid"));
  NodeID remote_nid = NodeID::from_json(packet.content.at("remote_nid"));
  const std::string& ice = packet.content.at("ice").get<std::string>();

  if (remote_nid != my_nid) {
    NetworkConnector& network = NetworkConnector::get_instance();
    network.send_init_webrtc_ice(local_nid, remote_nid, ice);

  } else {
    for (auto& it : connectors) {
      WebrtcConnector* connector = it.second.get();
      if (connector->nid == local_nid) {
        connector->update_ice(ice);
      }
    }
  }
}

/**
 * When receive init_webrtc offer command,
 * create a pair connector and reply with a SDP string by this node.
 * If the suggested node-id is used by this node, send error packet as deny.
 * @param packet A packet containing prime_nid, sdp.
 */
void WebrtcBundle::recv_init_webrtc_offer(const Packet& packet) {
  if (packet.dst_nid == my_nid) {
    picojson::object content;
    content.insert(std::make_pair("prime_nid", packet.content.at("prime_nid")));
    content.insert(std::make_pair("reason", Convert::int2json(0)));
    packet_controller.send_error(packet, content);

  } else {
    NodeID prime_nid = NodeID::from_json(packet.content.at("prime_nid"));
    const std::string& sdp = packet.content.at("sdp").get<std::string>();
    WebrtcConnector* connector = create_connector();

    init_map.insert(std::make_pair(connector, packet.src_nid));
    connector->nid  = prime_nid;
    connector->delegate = this;
    connector->set_remote_sdp(sdp);

    picojson::object content;
    content.insert(std::make_pair("prime_nid", packet.content.at("prime_nid")));
    content.insert(std::make_pair("second_nid", my_nid.to_json()));
    content.insert(std::make_pair("sdp", picojson::value(connector->get_local_sdp())));
    packet_controller.send_reply(packet, content);
  }
}

void WebrtcBundle::relay_to_another(const Packet& packet) {
  /// @todo
  assert(false);
}

/**
 * Relay packet to module on this node.
 * If taget modules is not NETWORK, relay packet through on router.
 * @param packet A packet to relay.
 */
void WebrtcBundle::relay_to_local(const Packet& packet) {
  if (packet.dst_module & Module::NETWORK) {
    packet_controller.recv(packet);
  }

  if (packet.dst_module & (~Module::NETWORK)) {
    Router& router = Router::get_instance();

    router.relay_from_global(packet);
  }
}

/**
 * Send error packet for a received packet.
 * @param error_for The target packet to send a error packet.
 * @param code Error code.
 */
void WebrtcBundle::send_packet_error(const Packet& error_for, PacketError::Type code) {
  if (error_for.mode & PacketMode::ONE_WAY && error_for.src_nid != my_nid) {
    return;
  }

  picojson::object content;
  content.insert(std::make_pair("code", Convert::int2json(code)));

  Packet packet = {
    error_for.packet_id,
    std::string("packet_error"),
    PacketMode::EXPLICIT | PacketMode::ONE_WAY,
    error_for.src_module,
    Module::NETWORK,
    error_for.pid,
    error_for.src_nid,
    my_nid,
    content
  };

  relay(packet);
}
}  // namespace processwarp
