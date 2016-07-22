#pragma once

#include <uv.h>

#include <webrtc/api/peerconnectioninterface.h>
#include <webrtc/api/test/fakeconstraints.h>
#include <webrtc/base/flags.h>
#include <webrtc/base/physicalsocketserver.h>
#include <webrtc/base/ssladapter.h>
#include <webrtc/base/thread.h>

#ifdef WITH_PTHREAD
#  include <pthread.h>
#else
#  include <mutex>
#endif

#include <deque>
#include <map>
#include <memory>
#include <set>
#include <string>

#include "packet.hpp"
#include "routing.hpp"
#include "type.hpp"
#include "webrtc_connector.hpp"

namespace processwarp {
class WebrtcBundle : public WebrtcConnectorDelegate,
                     public PacketControllerDelegate,
                     public RoutingDelegate {
 public:
  static WebrtcBundle& get_instance();

  void apply_connector(WebrtcConnector* connector);
  void close_connector(WebrtcConnector* connector);
  WebrtcConnector* create_connector();
  void finalize();
  void initialize(uv_loop_t* loop);
  void relay(const Packet& packet);
  void set_nid(const NodeID& nid);
  void relay_init_webrtc_ice(const NodeID& local_nid, const NodeID& remote_nid,
                             const std::string& ice);
  void relay_init_webrtc_offer(const NodeID& prime_nid, const std::string& sdp);

 private:
  class CustomRunnable : public rtc::Runnable {
   public:
    explicit CustomRunnable(WebrtcBundle& bundle_);
    void Run(rtc::Thread* subthread) override;

   private:
    WebrtcBundle& bundle;
  };

  class PacketConnect : public PacketController::Behavior {
   public:
    explicit PacketConnect(WebrtcConnector* connector_);

    const PacketController::Define& get_define() override;
    void on_error(const Packet& packet) override;
    void on_packet_error(PacketError::Type code) override;
    void on_reply(const Packet& packet) override;

   private:
    WebrtcConnector* connector;
  };

  /** Main loop of libuv. */
  uv_loop_t* loop;
  /** Async update connector status. */
  uv_async_t async_ucs;
  /** Async receive packet. */
  uv_async_t async_recv;

  /** Event loop of webrtc on sub-thread. */
  std::unique_ptr<rtc::Thread> thread;
  /** Subthread routine wrapped by WebRTC's Runnable class. */
  CustomRunnable runnable;

  /** WebRTC socket server instance. */
  rtc::PhysicalSocketServer socket_server;

  rtc::scoped_refptr<webrtc::PeerConnectionFactoryInterface> peer_connection_factory;
  webrtc::PeerConnectionInterface::RTCConfiguration pc_config;
  webrtc::DataChannelInit dc_config;

  PacketController packet_controller;
  /** Connector pool. */
  std::map<WebrtcConnector*, std::unique_ptr<WebrtcConnector>> connectors;
  /** Map of node-id and connector. */
  std::map<NodeID, WebrtcConnector*> nid_map;
  /** Map of connector and node-id that relayed the packet from the server. */
  std::map<WebrtcConnector*, NodeID> init_map;
  std::map<WebrtcConnector*, std::deque<std::string>> ice_send_buffer;
  std::map<WebrtcConnector*, std::deque<std::string>> ice_recv_buffer;
  /** Mutex for ice. */
#ifdef WITH_PTHREAD
  pthread_mutex_t ice_mutex;
#else
  std::mutex ice_mutex;
#endif

  /** Received data pool. */
  std::deque<std::string> recv_data;
  /** Mutex for received data pool. */
#ifdef WITH_PTHREAD
  pthread_mutex_t recv_mutex;
#else
  std::mutex recv_mutex;
#endif

  NodeID my_nid;
  Routing routing;
  /** Routing event timer. .*/
  uv_timer_t routing_timer;

  WebrtcBundle();
  WebrtcBundle(const WebrtcBundle&);
  WebrtcBundle& operator=(const WebrtcBundle&);
  virtual ~WebrtcBundle();

  void packet_controller_on_recv(const Packet& packet) override;
  void packet_controller_send(const Packet& packet) override;

  void routing_connect(const NodeID& nid) override;
  void routing_disconnect(const NodeID& nid) override;
  void routing_send_routing(bool is_explicit, const NodeID& dst_nid,
                            const picojson::object& content) override;
  void routing_send_routing_local(const picojson::object& content) override;

  void webrtc_connector_on_change_stateus(WebrtcConnector& connector, bool is_connect) override;
  void webrtc_connector_on_update_ice(WebrtcConnector& connector,
                                      const std::string& ice) override;
  void webrtc_connector_on_recv(WebrtcConnector& connector, const std::string& data) override;

  static void on_recv(uv_async_t* handle);
  static void on_timer_routing(uv_timer_t* handle);
  static void update_connector_status(uv_async_t* handle);

  void recv_connect(const Packet& packet);
  void recv_ice(const Packet& packet);
  void recv_init_webrtc_ice(const Packet& packet);
  void recv_init_webrtc_offer(const Packet& packet);
  void recv_require_routing(const Packet& packet);
  void relay_to_another(const NodeID& relay_nid, const Packet& packet);
  void relay_to_local(const Packet& packet);
  void send_connect(WebrtcConnector* connector, const NodeID& dst_nid, const std::string& sdp);
  void send_ice(const NodeID& dst_nid, const std::string& ice);
  void send_packet_error(const Packet& error_for, PacketError::Type code);
};
}  // namespace processwarp
