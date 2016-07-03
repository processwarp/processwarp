
#include <cassert>
#include <deque>
#include <set>
#include <string>

#include "constant.hpp"
#include "convert.hpp"
#include "packet_init_webrtc_offer.hpp"
#include "server_connector.hpp"
#include "router.hpp"
#include "webrtc_bundle.hpp"

namespace processwarp {
/**
 * Constructor with a connector.
 * @param connector_ A connector that is bind for this packet behavior.
 */
WebrtcBundle::PacketConnect::PacketConnect(WebrtcConnector* connector_) :
    connector(connector_) {
}

const PacketController::Define& WebrtcBundle::PacketConnect::get_define() {
  static PacketController::Define DEFINE = {
    "connect",
    PacketMode::EXPLICIT,
    0,
    Module::NETWORK
  };

  return DEFINE;
}

/**
 * When it receive error packet, close the connector.
 * @param packet A received error packet.
 */
void WebrtcBundle::PacketConnect::on_error(const Packet& packet) {
  on_packet_error(PacketError::CALL_BY_ERROR);
}

/**
 * When packet error has happen, close the connecotr.
 * @param code Code of the packet error.
 */
void WebrtcBundle::PacketConnect::on_packet_error(PacketError::Type code) {
  WebrtcBundle& webrtc = WebrtcBundle::get_instance();

  webrtc.close_connector(connector);
}

/**
 * When it receive reply packet, set remote SDP string for the connectior and
 * send bufferd ICE strings to the opposite side connector.
 * @param A received packet, containing sdp.
 */
void WebrtcBundle::PacketConnect::on_reply(const Packet& packet) {
  const std::string& sdp = packet.content.at("sdp").get<std::string>();
  connector->set_remote_sdp(sdp);

  WebrtcBundle& webrtc = WebrtcBundle::get_instance();
  {
    std::lock_guard<std::mutex> guard(webrtc.ice_mutex);
    auto it_ice_buffer = webrtc.ice_send_buffer.find(connector);
    if (it_ice_buffer != webrtc.ice_send_buffer.end()) {
      std::deque<std::string>& ices = it_ice_buffer->second;
      for (auto& ice : ices) {
        webrtc.send_ice(packet.src_nid, ice);
      }
      webrtc.ice_send_buffer.erase(it_ice_buffer);
    }
  }
  auto it_ice_buffer = webrtc.ice_recv_buffer.find(connector);
  if (it_ice_buffer != webrtc.ice_recv_buffer.end()) {
    std::deque<std::string>& ices = it_ice_buffer->second;
    for (auto& ice : ices) {
      connector->update_ice(ice);
    }
    webrtc.ice_recv_buffer.erase(it_ice_buffer);
  }
}

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
 * Apply connector from ServerConnector module.
 * @param connector WebRTC connector.
 */
void WebrtcBundle::apply_connector(WebrtcConnector* connector) {
  assert(connector->nid != NodeID::NONE);

  // Change connector's handler to me.
  connector->delegate = this;

  // Make a pair of node-id and connector.
  nid_map.insert(std::make_pair(connector->nid, connector));

  // Decode reteindata on connector.
  for (auto& data : connector->retention_data) {
    webrtc_connector_on_recv(*connector, data);
  }
  connector->retention_data.clear();

  uv_async_send(&async_ucs);
}

/**
 * Close WebRTC connector.
 * Unset handler and delete the connector instance.
 * @param connector WebRTC onnector.
 */
void WebrtcBundle::close_connector(WebrtcConnector* connector) {
  connector->delegate = nullptr;

  auto it_init = init_map.find(connector);
  if (it_init != init_map.end()) {
    init_map.erase(it_init);
  }

  if (connector->nid != NodeID::NONE) {
    auto it_nid = nid_map.find(connector->nid);
    if (it_nid != nid_map.end()) {
      nid_map.erase(it_nid);
    }
  }

  assert(connectors.find(connector) != connectors.end());
  connectors.erase(connector);
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
  uv_close(reinterpret_cast<uv_handle_t*>(&async_recv), nullptr);
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
  uv_async_init(loop, &async_recv, on_recv);
  uv_async_init(loop, &async_ucs, update_connector_status);

  // Initalize PacketController
  packet_controller.initialize(this);

  // Initialize WebRTC
  rtc::InitializeSSL();
  uv_thread_create(&subthread, WebrtcBundle::subthread_entry, this);

  // Initialize timer for routing.
  uv_timer_init(loop, &routing_timer);
  uv_timer_start(&routing_timer, on_timer_routing, 0, 10 * 1000);
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
    relay_to_another(dst_nid, packet);
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

  } else if (packet.command == "ice") {
    recv_ice(packet);

  } else if (packet.command == "connect") {
    recv_connect(packet);

  } else if (packet.command == "init_webrtc_ice") {
    recv_init_webrtc_ice(packet);

  } else if (packet.command == "init_webrtc_offer") {
    recv_init_webrtc_offer(packet);

  } else if (packet.command == "require_routing") {
    recv_require_routing(packet);

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

/**
 * When create a new connectior required from Routing module, setup the nid and delegate,
 * and create ICE buffer before send create packet.
 * @param nid The opposite side node's id for the new connector.
 */
void WebrtcBundle::routing_connect(const NodeID& nid) {
  if (nid_map.find(nid) != nid_map.end()) {
    return;
  }

  WebrtcConnector* connector = create_connector();
  connector->nid = nid;
  connector->delegate = this;
  nid_map.insert(std::make_pair(nid, connector));
  {
    std::lock_guard<std::mutex> guard(ice_mutex);
    ice_send_buffer.insert(std::make_pair(connector, std::deque<std::string>()));
    ice_recv_buffer.insert(std::make_pair(connector, std::deque<std::string>()));
  }

  send_connect(connector, nid, connector->get_local_sdp());
}

/**
 * When disconnect required from Routing module, remote target connector.
 * @param nid The target node-id.
 */
void WebrtcBundle::routing_disconnect(const NodeID& nid) {
  assert(nid_map.find(nid) != nid_map.end());

  close_connector(nid_map.at(nid));
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
 * Send routing packet to local modules, when request of sending routing packet has called from Routing module.
 * @param content Packet content.
 */
void WebrtcBundle::routing_send_routing_local(const picojson::object& content) {
  packet_controller.send("routing", Module::MEMORY, true,
                         PID::BROADCAST, NodeID::THIS, content);
}

/**
 * Remove the connector from initializeing map,  when a connector status has changed to enable.
 * Raise update_connector_status on another thread, when a connector status has changed.
 * @param connector Connector that status has changed.
 * @param is_connect Connection status (True if connection has enabled.).
 */
void WebrtcBundle::webrtc_connector_on_change_stateus(WebrtcConnector& connector, bool is_connect) {
  if (is_connect) {
    auto it_init = init_map.find(&connector);
    if (it_init != init_map.end()) {
      init_map.erase(it_init);
    }

    nid_map.insert(std::make_pair(connector.nid, &connector));
  }

  // Raise update_connector_status on another thread.
  uv_async_send(&async_ucs);
}

/**
 * When ice update event has happen on initializing connector,
 * send init_webrtc_ice command to the opposite side node.
 * When event has happen on not initializeing connecotr, send ice command to the opposite side node.
 * Otherwise, it put the ice string on the buffer, if reply packet has not received yet for the connecotr.
 * @param connector Initializing connector.
 * @param ice ICE string.
 */
void WebrtcBundle::webrtc_connector_on_update_ice(WebrtcConnector& connector,
                                                  const std::string& ice) {
  auto it_connector = init_map.find(&connector);
  if (it_connector != init_map.end()) {
    picojson::object content;

    content.insert(std::make_pair("local_nid", my_nid.to_json()));
    content.insert(std::make_pair("remote_nid", connector.nid.to_json()));
    content.insert(std::make_pair("ice", picojson::value(ice)));

    packet_controller.send("init_webrtc_ice", Module::NETWORK, true,
                           PID::BROADCAST, it_connector->second, content);

  } else {
    std::lock_guard<std::mutex> guard(ice_mutex);
    auto it_ice_buffer = ice_send_buffer.find(&connector);
    if (it_ice_buffer != ice_send_buffer.end()) {
      it_ice_buffer->second.push_back(ice);

    } else {
      send_ice(connector.nid, ice);
    }
  }
}

/**
 * When receive event has happen, Raise on_recv on another thraed.
 * @param connector Data received connector.
 * @param data Received data.
 */
void WebrtcBundle::webrtc_connector_on_recv(WebrtcConnector& connector, const std::string& data) {
  std::lock_guard<std::mutex> guard(recv_mutex);
  recv_data.push_back(data);
  uv_async_send(&async_recv);
}

/**
 * When receive data from connector, decode it to packet and call relay method to relay it.
 * @param handle libuv's handler(unused).
 */
void WebrtcBundle::on_recv(uv_async_t* handle) {
  WebrtcBundle& THIS = get_instance();

  while (true) {
    picojson::value v;
    {
      std::lock_guard<std::mutex> guard(THIS.recv_mutex);
      if (THIS.recv_data.empty()) {
        break;

      } else {
        std::istringstream is(THIS.recv_data.front());
        std::string err = picojson::parse(v, is);
        THIS.recv_data.pop_front();
        if (!err.empty()) {
          /// @todo error
          assert(false);
        }
      }
    }

    picojson::object& js = v.get<picojson::object>();
    Packet packet = {
      Convert::json2int<uint32_t>(js.at("packet_id")),
      js.at("command").get<std::string>(),
      Convert::json2int<PacketMode::Type>(js.at("mode")),
      Convert::json2int<Module::Type>(js.at("dst_module")),
      Convert::json2int<Module::Type>(js.at("src_module")),
      Convert::json2vpid(js.at("pid")),
      NodeID::from_json(js.at("dst_nid")),
      NodeID::from_json(js.at("src_nid")),
      js.at("content").get<picojson::object>()
    };

    THIS.relay(packet);
  }
}

/**
 * When timer event for routing has happen, call routing method.
 * @param handle libuv's event handler.
 */
void WebrtcBundle::on_timer_routing(uv_timer_t* handle) {
  WebrtcBundle& THIS = get_instance();
  THIS.routing.execute();
}

/**
 * When update connector status, collect online node-ids and pass to routing module.
 * @param handle libuv's handler.
 */
void WebrtcBundle::update_connector_status(uv_async_t* handle) {
  WebrtcBundle& THIS = get_instance();
  std::set<NodeID> nids;

  // Tell event for Routing module
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
 * When receive a connect command, crate a new connector and send reply with local SDP string.
 * Otherwise, the same node-id is used by this node, send error.
 * @param packet Received packet, containing sdp
 */
void WebrtcBundle::recv_connect(const Packet& packet) {
  if (nid_map.find(packet.src_nid) != nid_map.end()) {
    packet_controller.send_error(packet, picojson::object());

  } else {
    const std::string& sdp = packet.content.at("sdp").get<std::string>();
    WebrtcConnector* connector = create_connector();
    connector->nid = packet.src_nid;
    connector->delegate = this;
    connector->set_remote_sdp(sdp);
    nid_map.insert(std::make_pair(packet.src_nid, connector));

    picojson::object content;
    content.insert(std::make_pair("sdp", picojson::value(connector->get_local_sdp())));
    packet_controller.send_reply(packet, content);
  }
}

/**
 * When receive a ice command, update ICE of connector.
 * Otherwise, store the ICE string to buffer, if send offer and has not received reply packet yet.
 * @param packet Received packet, containing ice.
 */
void WebrtcBundle::recv_ice(const Packet& packet) {
  WebrtcConnector* connector = nid_map.at(packet.src_nid);
  const std::string& ice = packet.content.at("ice").get<std::string>();

  auto it_ice_buffer = ice_recv_buffer.find(connector);
  if (it_ice_buffer != ice_recv_buffer.end()) {
    it_ice_buffer->second.push_back(ice);

  } else {
    connector->update_ice(ice);
  }
}

/**
 * When receive init_webrtc ice command, update ICE of initializeing connector if target is this node.
 * Otherwise, relay it to the server. Because, it should be relayed by this node.
 */
void WebrtcBundle::recv_init_webrtc_ice(const Packet& packet) {
  NodeID local_nid = NodeID::from_json(packet.content.at("local_nid"));
  NodeID remote_nid = NodeID::from_json(packet.content.at("remote_nid"));
  const std::string& ice = packet.content.at("ice").get<std::string>();

  if (remote_nid != my_nid) {
    ServerConnector& server = ServerConnector::get_instance();
    server.send_init_webrtc_ice(local_nid, remote_nid, ice);

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
 * But, the same id is used by this node, send a error reply.
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

/**
 * When receive require_routing command, send routing_local command.
 * @param packet A packet, it contain no information.
 */
void WebrtcBundle::recv_require_routing(const Packet& packet) {
  routing.require_routing_local();
}

/**
 * Relay packet to another node.
 * @param relay_nid Relay node-id.
 * @param packet Packet to relay.
 */
void WebrtcBundle::relay_to_another(const NodeID& relay_nid, const Packet& packet) {
  assert(nid_map.find(relay_nid) != nid_map.end());
  assert(nid_map.at(relay_nid)->is_connected);

  picojson::object js_packet;
  js_packet.insert(std::make_pair("packet_id", Convert::int2json(packet.packet_id)));
  js_packet.insert(std::make_pair("command", picojson::value(packet.command)));
  js_packet.insert(std::make_pair("mode", Convert::int2json(packet.mode)));
  js_packet.insert(std::make_pair("dst_module", Convert::int2json(packet.dst_module)));
  js_packet.insert(std::make_pair("src_module", Convert::int2json(packet.src_module)));
  js_packet.insert(std::make_pair("pid", Convert::vpid2json(packet.pid)));
  js_packet.insert(std::make_pair("dst_nid", packet.dst_nid.to_json()));
  js_packet.insert(std::make_pair("src_nid", packet.src_nid.to_json()));
  js_packet.insert(std::make_pair("content", picojson::value(packet.content)));

  std::string js_str = picojson::value(js_packet).serialize();

  nid_map.at(relay_nid)->send(js_str);
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
 * Send a connect packet, with making a behavior.
 * @param connector The connector that is bind for a new PacketConnect instance.
 * @param dst_nid Destination node-id.
 * @param sdp SDP string generated in this node that is send for the opposite side node.
 */
void WebrtcBundle::send_connect(WebrtcConnector* connector, const NodeID& dst_nid,
                                const std::string& sdp) {
  std::unique_ptr<PacketController::Behavior> behavior(new PacketConnect(connector));
  picojson::object content;
  content.insert(std::make_pair("sdp", picojson::value(sdp)));
  packet_controller.send(std::move(behavior), PID::BROADCAST, dst_nid, content);
}

/**
 * Send a ice packet.
 * @param dst_nid Destination node-id, that is the opposite side of a connector.
 * @param ice ICE string for the destination node.
 */
void WebrtcBundle::send_ice(const NodeID& dst_nid, const std::string& ice) {
  picojson::object content;
  content.insert(std::make_pair("ice", picojson::value(ice)));
  packet_controller.send("ice", Module::NETWORK, true, PID::BROADCAST, dst_nid, content);
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
