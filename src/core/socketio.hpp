#pragma once

#include <sio_client.h>

#include <atomic>
#include <condition_variable>
#include <map>
#include <mutex>
#include <queue>
#include <string>
#include <utility>
#include <thread>
#include <vector>

#include "definitions.hpp"

namespace processwarp {
/**
 * Delegate for SocketIo-class.
 */
class SocketIoDelegate {
 public:
  /**
   * Destructor for virtual.
   */
  virtual ~SocketIoDelegate() {}

  /**
   * Call when system error on server.
   * @param code Error code.
   */
  virtual void recv_sys_error(int code) = 0;

  /**
   * Call when application error on server.
   * @param code Error code.
   */
  virtual void recv_app_error(int code) = 0;

  /**
   * Call when recv login message from server.
   * @param result Set 0 when succeed or else error code when error.
   */
  virtual void recv_login(int result) = 0;

  /**
   * Call when recv list node message from server.
   * @param result Set 0 when succeed or else error code when error.
   * @param nodes Map of node-id and node-name.
   */
  virtual void recv_list_node(int result,
                                const std::map<nid_t, std::string>& nodes) = 0;

  /**
   * Call when recv bind node message from server.
   * @param result Set 0 when succeed or else error code when error.
   * @param nid Node id bound this node.
   */
  virtual void recv_bind_node(int result, const nid_t& nid) = 0;

  /**
   * Call when recv sync proc list message from server.
   * @param procs Map of pid and SocketIoProc.
   */
  virtual void recv_sync_proc_list(const std::vector<ProcessTree>& procs) = 0;

  /**
   * Call when recieve virtual-machine data packet from other node.
   * Packet isn't filterd. It contain packet that destination is other node.
   * @param pid Target pid.
   * @param src Source node-id (Contain SpecialNode::SERVER and this node).
   * @param dst Destination node-id (Contain SpecialNode::BROADCAST and NOT this node).
   * @param data Load data.
   */
  virtual void recv_machine_data(const vpid_t& pid,
                                 const nid_t& src,
                                 const nid_t& dst,
                                 const std::string& data) = 0;

  /**
   * Call when recieve virtual-memory data packet from other node.
   * Packet isn't filterd. It contain packet that destination is other node.
   * @param pid Target pid.
   * @param src Source node-id (Contain SpecialNode::SERVER and this node).
   * @param dst Destination node-id (Contain SpecialNode::BROADCAST and NOT this node).
   * @param data Load data.
   */
  virtual void recv_memory_data(const std::string& name,
                                const nid_t& src,
                                const nid_t& dst,
                                const std::string& data) = 0;

  /**
   * Recv console for test.
   * @param pid Source pid.
   * @param dev Device name (stdout/stderr).
   * @param payload output stream or text.
   * @param from_nid Source deice-id.
   */
  virtual void recv_test_console(const vpid_t& pid,
                                 const std::string& dev,
                                 const std::string& payload,
                                 const nid_t& from_nid) = 0;
};

/**
 * Message sender by using Socket.IO.
 */
class SocketIo {
 public:
  /**
   * Constractor with delegate.
   * @param delegate Delegate for recv event.
   */
  explicit SocketIo(SocketIoDelegate& delegate);

  /**
   * Destructor with close Socket.IO.
   */
  virtual ~SocketIo();

  /**
   * Connect to server.
   * @param url Server's URL.
   */
  void connect(const std::string& url);

  /**
   * Pooling.
   */
  void pool();

  /**
   * Send load llvm command.
   * Packet format: {
   *   name: <Application name>,
   *   file: <File content(binary)>,
   *   args: [<arg1>, <arg2>,...]
   *   dest_nid: <Destination node-id>
   * }
   * @param name Application name.
   * @param file File content(binary).
   * @param args List of arguments for program.
   * @param dst_nid Destination node-id.
   */
  void send_load_llvm(const std::string& name,
                      const std::string& file,
                      const std::vector<std::string>& args,
                      const nid_t& dst_nid);

  /**
   * Send login command.
   * Packet format: {
   *   account: <account>,
   *   password: <password>
   * }
   * @param account Account name.
   * @param passward Passward for account.
   */
  void send_login(const std::string& account,
                  const std::string& password);

  /**
   * Send request of node list.
   * Packet format: {
   * }
   */
  void send_list_node();


  /**
   * Send node bind command.
   * Packet format: {
   *   id: <id>,
   *   name: <name>
   * }
   * @param id Just using node-id.
   * @param name Name of node.
   */
  void send_bind_node(const nid_t& id,
                        const std::string& name);

  /**
   * Send process list for synchronize.
   * Packet format: [
   *   {
   *     pid: <pid>,
   *     name: <name of process>,
   *     threads: {
   *       <tid>: <nid>
   *     }
   *   }, ...
   * }
   */
  void send_sync_proc_list(const std::vector<ProcessTree>& procs);

  /**
   * Send virtual-machine data packet.
   * Packet format: {
   *   pid: <pid>
   *   dst: <destination node-id>
   *   src: <this node-id, added by server>
   *   data: <load data>
   * }
   */
  void send_machine_data(const vpid_t& pid,
                         const nid_t& dst,
                         const std::string& data);

  /**
   * Send virtual-memory data packet.
   * Packet format: {
   *   name: <name of memory space>
   *   dst: <target nid>
   *   src: <this node-id, added by server>
   *   data: <load data>
   * }
   */
  void send_memory_data(const std::string& name,
                        const nid_t& dst,
                        const std::string& data);

  /**
   * Send console for test.
   * @param pid Source pid.
   * @param dev Device name (stdout/stderr).
   * @param payload output stream or text.
   */
  void send_test_console(const vpid_t& pid,
                         const std::string& dev,
                         const std::string& payload);

 private:
  enum SioStatus {
    SETUP,
    CONNECT,
    FAIL,
    CLOSE
  };
  // Delegate for recv events.
  SocketIoDelegate& delegate;

  // Socket.IO client for listen event.
  sio::client client;
  // Socket.IO socket for emit message.
  sio::socket::ptr socket;

  std::mutex sio_mutex;
  std::condition_variable_any sio_cond;
  std::atomic<SioStatus> sio_status {SETUP};
  std::queue<std::pair<std::string, sio::message::ptr>> sio_queue;

  /**
   * Event listener for Socket.IO's close event.
   */
  void on_close();

  /**
   * Event listener for Socket.IO's fail event.
   */
  void on_fail();

  /**
   * Event listener for Socket.IO's connect event.
   */
  void on_open();
};
}  // namespace processwarp
