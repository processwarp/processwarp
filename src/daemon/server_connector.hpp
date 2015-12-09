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

#include "daemon_define.hpp"
#include "definitions.hpp"

namespace processwarp {
/**
 * Message sender by using Socket.IO.
 */
class ServerConnector {
 public:
  static ServerConnector& get_instance();

  void initialize(uv_loop_t* loop_, const std::string& url);
  ServerStatus::Type get_status();
  void send_connect_node(const std::string& account,
                         const std::string& password);
  void send_load_llvm(const std::string& name,
                      const std::string& file,
                      const std::vector<std::string>& args,
                      const nid_t& dst_nid);
  void send_list_node();
  void send_bind_node(const nid_t& nid,
                      const std::string& node_name);
  void send_sync_proc_list(const std::vector<ProcessTree>& procs);
  void send_machine_data(const vpid_t& pid,
                         const nid_t& dst_nid,
                         const std::string& data);
  void send_memory_data(const std::string& name,
                        const nid_t& dst_nid,
                        const std::string& data);
  void send_test_console(const vpid_t& pid,
                         const std::string& dev,
                         const std::string& payload);

 private:
  /** Main loop of libuv. */
  uv_loop_t* loop;
  /** Async transporter between threads. */
  uv_async_t async_receive;

  /** Socket.IO client for listen event. */
  sio::client client;
  /** Socket.IO socket for emit message. */
  sio::socket::ptr socket;

  std::mutex sio_mutex;
  std::condition_variable_any sio_cond;
  std::atomic<ServerStatus::Type> status;
  std::queue<std::pair<std::string, sio::message::ptr>> sio_queue;

  ServerConnector();
  ServerConnector(const ServerConnector&);
  ServerConnector& operator=(const ServerConnector&);
  virtual ~ServerConnector();

  void initialize_async();
  void initialize_socketio(const std::string& url);
  void on_close();
  void on_fail();
  void on_open();
  void recv_connect_node(sio::message::ptr data);
  void recv_bind_node(sio::message::ptr data);

  static void on_recv(uv_async_t* handle);
};
}  // namespace processwarp