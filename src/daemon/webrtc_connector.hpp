#pragma once

#include <picojson.h>
#include <uv.h>

#include <deque>
#include <string>

#include "connector.hpp"
#include "node_id.hpp"
#include "packet.hpp"
#ifdef WITH_WEBRTC_DEBUG
#  include "webrtc_subprocess.hpp"
#endif

namespace processwarp {
class WebrtcConnectorDelegate {
 public:
  virtual ~WebrtcConnectorDelegate();
  virtual void webrtc_connector_on_init_webrtc_deny(const NodeID& prime_nid, int reason) = 0;
  virtual void webrtc_connector_on_init_webrtc_fin() = 0;
  virtual void webrtc_connector_on_init_webrtc_ice(
      const NodeID& local_nid, const NodeID& remote_nid, const std::string& ice) = 0;
  virtual void webrtc_connector_on_init_webrtc_offer(const std::string& sdp) = 0;
  virtual void webrtc_connector_on_init_webrtc_reply(
      const NodeID& prime_nid, const NodeID& second_nid, const std::string& sdp) = 0;
};

class WebrtcConnector : public Connector {
 public:
  static WebrtcConnector& get_instance();

  void cancel_init_edge_by_isolation();
  void create_init_edge();
  void initialize(WebrtcConnectorDelegate* delegate_, uv_loop_t* loop,
                  const std::string& pipe_path_, const std::string& message_fname);
  void relay(const Packet& packet);
  void relay_init_webrtc_ice(const NodeID& local_nid, const NodeID& remote_nid,
                             const std::string& ice);
  void relay_init_webrtc_offer(const NodeID& prime_nid, const std::string& sdp);
  void relay_init_webrtc_reply(const NodeID& prime_nid, const NodeID& second_nid,
                               const std::string& sdp);
  void set_nid(const NodeID& nid);

 private:
  NodeID my_nid;

  uv_pipe_t* client_pipe;
  uv_process_t subprocess;
#ifdef WITH_WEBRTC_DEBUG
  std::unique_ptr<WebrtcSubprocess> debug_subprocess;
#endif

  std::deque<picojson::object> send_wait;

  WebrtcConnectorDelegate* delegate;

  WebrtcConnector();
  WebrtcConnector(const WebrtcConnector&);
  WebrtcConnector& operator=(const WebrtcConnector&);

  static void on_exit(uv_process_t *req, int64_t exit_status, int term_signal);

  void on_connect(uv_pipe_t& client) override;
  void on_recv_data(uv_pipe_t& client, picojson::object& data) override;
  void on_close(uv_pipe_t& client) override;

  void initialize_subprocess(const std::string& pipe_path, const std::string& message_fname);
  void recv_relay_to_local(const picojson::object& content);
  void send_data(const picojson::object& data);
};
}  // namespace processwarp
