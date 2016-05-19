#pragma once

#include <sio_client.h>
#include <uv.h>

#include <atomic>
#include <condition_variable>
#include <map>
#include <mutex>
#include <queue>
#include <string>
#include <utility>
#include <thread>
#include <vector>

#include "constant_native.hpp"
#include "packet.hpp"
#include "type.hpp"

namespace processwarp {
class NetworkConnector;

class NetworkConnectorConnectDelegate {
 public:
  virtual ~NetworkConnectorConnectDelegate();
  virtual void network_connector_connect_on_success(
      NetworkConnector& network_connector, const NodeID& my_nid) = 0;
  virtual void network_connector_connect_on_failure(
      NetworkConnector& network_connector, int code) = 0;
};

/**
 * Message sender by using Socket.IO.
 */
class NetworkConnector {
 public:
  static NetworkConnector& get_instance();

  void connect(NetworkConnectorConnectDelegate* delegate,
               const std::string& account_, const std::string& password_);
  void disconnect();
  const NodeID& get_my_nid();
  ConnectStatus::Type get_status();
  void initialize(uv_loop_t* loop_, const std::string& url_);
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

  std::mutex sio_mutex;
  std::condition_variable_any sio_cond;
  std::atomic<ConnectStatus::Type> connect_status;
  std::queue<std::pair<std::string, sio::message::ptr>> sio_queue;

  NodeID my_nid;

  NetworkConnectorConnectDelegate* connect_delegate;
  std::string account;
  std::string password;
  bool is_auth_yet;

  NetworkConnector();
  NetworkConnector(const NetworkConnector&);
  NetworkConnector& operator=(const NetworkConnector&);
  virtual ~NetworkConnector();

  static void on_recv(uv_async_t* handle);

  void on_close();
  void on_fail();
  void on_open();

  void connect_socketio();
  void initialize_async();
  void initialize_socketio();
  void recv_auth(sio::message::ptr data);
  void recv_relay(sio::message::ptr data);
  void send_auth();
  void send_init_sdp();
};
}  // namespace processwarp
