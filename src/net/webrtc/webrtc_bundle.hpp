#pragma once

#include <uv.h>

#include <webrtc/api/peerconnectioninterface.h>
#include <webrtc/base/flags.h>
#include <webrtc/base/physicalsocketserver.h>
#include <webrtc/base/ssladapter.h>
#include <webrtc/base/thread.h>

#include <deque>
#include <map>
#include <memory>
#include <set>
#include <string>

#include "lock.hpp"
#include "packet.hpp"
#include "routing.hpp"
#include "types.hpp"
#include "webrtc_edge.hpp"

namespace processwarp {
class WebrtcBundleDelegate {
 public:
  virtual ~WebrtcBundleDelegate();
  virtual void webrtc_bundle_relay_to_local(const Packet& packet) = 0;
  virtual void webrtc_bundle_init_webrtc_deny(const NodeID& prime_nid, int reason) = 0;
  virtual void webrtc_bundle_init_webrtc_ice(const NodeID& local_nid, const NodeID& remote_nid,
                                             const std::string& ice) = 0;
  virtual void webrtc_bundle_init_webrtc_reply(const NodeID& prime_nid, const NodeID& second_nid,
                                               const std::string& sdp) = 0;
};

class WebrtcBundle : public WebrtcEdgeDelegate,
                     public PacketControllerDelegate,
                     public RoutingDelegate {
 public:
  static WebrtcBundle& get_instance();

  void apply_edge(WebrtcEdge* edge);
  void close_edge(WebrtcEdge* edge);
  WebrtcEdge* create_edge();
  void finalize();
  void initialize(WebrtcBundleDelegate* delegate_, uv_loop_t* loop);
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
    explicit PacketConnect(WebrtcEdge* edge_);

    const PacketController::Define& get_define() override;
    void on_error(const Packet& packet) override;
    void on_packet_error(PacketError::Type code) override;
    void on_reply(const Packet& packet) override;

   private:
    WebrtcEdge* edge;
  };

  class PacketInitWebrtcOffer : public PacketController::Behavior {
   public:
    explicit PacketInitWebrtcOffer(WebrtcBundle* bundle_);

    const PacketController::Define& get_define() override;
    void on_error(const Packet& packet) override;
    void on_packet_error(PacketError::Type code) override;
    void on_reply(const Packet& packet) override;

   private:
    WebrtcBundle* bundle;
  };

  WebrtcBundleDelegate* delegate;
  /** Main loop of libuv. */
  uv_loop_t* loop;
  /** Async update edge status. */
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
  /** Edge pool. */
  std::map<WebrtcEdge*, std::unique_ptr<WebrtcEdge>> edges;
  /** Map of node-id and edge. */
  std::map<NodeID, WebrtcEdge*> nid_map;
  /** Map of edge and node-id that relayed the packet from the server. */
  std::map<WebrtcEdge*, NodeID> init_map;
  std::map<WebrtcEdge*, std::deque<std::string>> ice_send_buffer;
  std::map<WebrtcEdge*, std::deque<std::string>> ice_recv_buffer;
  /** Mutex for ice. */
  Lock::Mutex ice_mutex;

  /** Received data pool. */
  std::deque<std::string> recv_data;
  /** Mutex for received data pool. */
  Lock::Mutex recv_mutex;

  Lock::Mutex init_mutex;
  Lock::Cond init_cond;

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

  void webrtc_edge_on_change_stateus(WebrtcEdge& edge, bool is_connect) override;
  void webrtc_edge_on_update_ice(WebrtcEdge& edge,
                                 const std::string& ice) override;
  void webrtc_edge_on_recv(WebrtcEdge& edge, const std::string& data) override;

  static void on_recv(uv_async_t* handle);
  static void on_timer_routing(uv_timer_t* handle);
  static void update_edge_status(uv_async_t* handle);

  void recv_connect(const Packet& packet);
  void recv_ice(const Packet& packet);
  void recv_init_webrtc_ice(const Packet& packet);
  void recv_init_webrtc_offer(const Packet& packet);
  void recv_require_routing(const Packet& packet);
  void relay_to_another(const NodeID& relay_nid, const Packet& packet);
  void relay_to_local(const Packet& packet);
  void send_connect(WebrtcEdge* edge, const NodeID& dst_nid, const std::string& sdp);
  void send_ice(const NodeID& dst_nid, const std::string& ice);
  void send_packet_error(const Packet& error_for, PacketError::Type code);
};
}  // namespace processwarp
