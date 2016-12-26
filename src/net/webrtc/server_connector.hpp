#pragma once

#include <sio_client.h>
#include <uv.h>

#include <map>
#include <queue>
#include <string>
#include <utility>
#include <vector>

#include "lock.hpp"
#include "net/constant_net.hpp"
#include "types.hpp"
#include "webrtc_connector.hpp"

namespace processwarp {
class ServerConnector;

class ServerConnectorConnectDelegate {
 public:
  virtual ~ServerConnectorConnectDelegate();
  virtual void server_connector_connect_on_success(
      ServerConnector& server_connector, const NodeID& my_nid) = 0;
  virtual void server_connector_connect_on_failure(
      ServerConnector& server_connector, int code) = 0;
};

/**
 * Message sender by using Socket.IO.
 */
class ServerConnector : public WebrtcConnectorDelegate {
 public:
  static ServerConnector& get_instance();

  void connect(ServerConnectorConnectDelegate* delegate,
               const std::string& account_, const std::string& password_);
  void disconnect();
  const NodeID& get_my_nid();
  ConnectStatus::Type get_status();
  void initialize(uv_loop_t* loop_, const std::string& url_);
  void send_init_webrtc_deny(const NodeID& prime_nid, const int reason);
  void send_init_webrtc_ice(const NodeID& local_nid, const NodeID& remote_nid,
                            const std::string& ice);
  void send_init_webrtc_reply(const NodeID& prime_nid, const NodeID& second_nid,
                              const std::string& sdp);
  void send_load_llvm(const std::string& name,
                      const std::string& file,
                      const std::vector<std::string>& args,
                      const vpid_t& pid,
                      const NodeID& dst_nid);
  void send_test_console(const vpid_t& pid,
                         const std::string& dev,
                         const std::string& payload);

 private:
  /** Main loop of libuv. */
  uv_loop_t* loop;
  /** Async transporter between threads. */
  uv_async_t async_receive;

  /** Socket.IO server URL. */
  std::string url;
  /** Socket.IO client for listen event. */
  sio::client client;
  /** Socket.IO socket for emit message. */
  sio::socket::ptr socket;

  Lock::Mutex sio_mutex;
  Lock::Cond sio_cond;
  ConnectStatus::Type connect_status;
  std::queue<std::pair<std::string, sio::message::ptr>> sio_queue;

  NodeID my_nid;
  std::string init_sdp;

  ServerConnectorConnectDelegate* connect_delegate;
  std::string account;
  std::string password;
  bool is_auth_yet;

  ServerConnector();
  ServerConnector(const ServerConnector&);
  ServerConnector& operator=(const ServerConnector&);
  virtual ~ServerConnector();

  void webrtc_connector_on_init_webrtc_deny(const NodeID& prime_nid, int reason) override;
  void webrtc_connector_on_init_webrtc_fin() override;
  void webrtc_connector_on_init_webrtc_ice(const NodeID& local_nid, const NodeID& remote_nid,
                                         const std::string& ice) override;
  void webrtc_connector_on_init_webrtc_offer(const std::string& sdp) override;
  void webrtc_connector_on_init_webrtc_reply(const NodeID& prime_nid, const NodeID& second_nid,
                                           const std::string& sdp) override;

  static void on_recv(uv_async_t* handle);

  void on_close();
  void on_fail();
  void on_open();

  void connect_socketio();
  void initialize_async();
  void initialize_socketio();
  void initialize_webrtc();
  void recv_auth(sio::message::ptr data);
  void recv_init_webrtc(sio::message::ptr data);
  void recv_init_webrtc_deny(const picojson::object& content);
  void recv_init_webrtc_ice(const picojson::object& content);
  void recv_init_webrtc_offer(const picojson::object& content);
  void recv_init_webrtc_reply(const picojson::object& content);
  void recv_relay(sio::message::ptr data);
  void send_auth();
  void send_init_webrtc_offer(const NodeID& prime_nid, const std::string& sdp);
  void send_init_webrtc_fin(const NodeID& prime_nid);
};
}  // namespace processwarp
