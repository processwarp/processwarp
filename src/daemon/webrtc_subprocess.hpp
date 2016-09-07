#pragma once

#include <string>
#include <tuple>
#include <vector>

#include "subprocess.hpp"
#include "webrtc_bundle.hpp"
#include "webrtc_edge.hpp"

namespace processwarp {
class WebrtcSubprocess : public Subprocess,
                         public WebrtcBundleDelegate,
                         public WebrtcEdgeDelegate {
 public:
  WebrtcSubprocess();

  int entry(int argc, char* argv[]);

 private:
  /** Configure. */
  picojson::object config;

  NodeID my_nid;

  WebrtcEdge* init_edge;
  std::vector<std::string> init_ice;

  void on_connect() override;
  void on_recv_data(const picojson::object& data) override;

  void webrtc_bundle_relay_to_local(const Packet& packet) override;
  void webrtc_bundle_init_webrtc_deny(const NodeID& prime_nid, int reason) override;
  void webrtc_bundle_init_webrtc_ice(const NodeID& local_nid, const NodeID& remote_nid,
                                     const std::string& ice) override;
  void webrtc_bundle_init_webrtc_reply(const NodeID& prime_nid, const NodeID& second_nid,
                                       const std::string& sdp) override;

  void webrtc_edge_on_change_stateus(WebrtcEdge& edge, bool is_connect) override;
  void webrtc_edge_on_update_ice(WebrtcEdge& edge, const std::string& ice) override;

  std::tuple<std::string, std::string> read_options(int argc, char* argv[]);
  void recv_cancel_init_edge(const picojson::object& content);
  void recv_create_init_edge(const picojson::object& content);
  void recv_init_webrtc_ice(const picojson::object& content);
  void recv_init_webrtc_offer(const picojson::object& content);
  void recv_init_webrtc_reply(const picojson::object& content);
  void recv_initialize(const picojson::object& content);
  void recv_relay_packet(const picojson::object& content);
  void recv_set_my_nid(const picojson::object& content);
  void send_connect_subprocess();
  void send_init_webrtc_deny(const NodeID& prime_nid, int reason);
  void send_init_webrtc_fin();
  void send_init_webrtc_ice(const NodeID& local_nid, const NodeID& remote_nid,
                            const std::string ice);
  void send_init_webrtc_offer(const std::string& sdp);
  void send_init_webrtc_reply(const NodeID& prime_nid, const NodeID& second_nid,
                              const std::string& sdp);
  void send_relay_to_local(const Packet& packet);
};
}  // namespace processwarp
