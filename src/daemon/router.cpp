
#include <cassert>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

#include "router.hpp"
#include "scheduler.hpp"
#include "server_connector.hpp"
#include "util.hpp"
#include "worker_connector.hpp"

namespace processwarp {

/**
 * Constructor for singleton pattern.
 * This class is singleton.
 * This method is private.
 */
Router::Router() {
}

/**
 * Router instance getter as singleton pattern.
 * @return The singleton instance of Router class.
 */
Router& Router::get_instance() {
  static Router instance;
  return instance;
}

/**
 * Initiazlie Router with libuv loop, configuration, scheduler.
 * Store both of parameters.
 * @param loop_ Loop for Router.
 * @param config_ Configuration.
 */
void Router::initialize(uv_loop_t* loop_, const picojson::object& config_) {
  loop   = loop_;
  config = config_;

  scheduler.initialize(*this);
}

/**
 * Check account is eaual to the same to connecting it.
 * @param account_ Target account name.
 * @param password_ Target password.
 * @return True if account and password is eaual to the same to connecting it.
 */
bool Router::check_account(const std::string& account_, const std::string& password_) {
  ServerConnector& server = ServerConnector::get_instance();
  if (server.get_status() != ServerStatus::CONNECT) {
    /// @todo error
    assert(false);
  }

  std::string hash_password = password_;
  for (int i = 0; i < 10; i ++) {
    hash_password = Util::calc_sha256(hash_password);
  }
  hash_password = "[10sha256]" + hash_password;

  if (account_ == config.at("account").get<std::string>() &&
      hash_password == config.at("password").get<std::string>()) {
    return true;
  } else {
    return false;
  }
}

/**
 * Open the LLVM-IR file and send load-llvm command to server.
 * @param filename Filename of LLVM-IR.
 * @param args Arguments to pass application's entry point.
 */
void Router::load_llvm(const std::string& filename, const std::vector<std::string>& args) {
  ServerConnector& server = ServerConnector::get_instance();

  if (server.get_status() != ServerStatus::CONNECT) {
    /// @todo error
    assert(false);
  }

  std::ifstream ifs(filename);
  std::stringstream file;
  std::string line;

  if (!ifs.is_open()) {
    /// @todo errro
    assert(false);
  }
  while (std::getline(ifs, line, '\n')) {
    file << line << '\n';
  }
  ifs.close();

  server.send_load_llvm(Util::file_basename(filename, true), file.str(), args, my_nid);
}

/**
 * Get this node's node-id.
 * @return This node's node-id.
 */
const nid_t& Router::get_my_nid() {
  assert(!my_nid.empty());

  return my_nid;
}

/**
 * When connect is success, send bind_node packet with my-nid and node-name.
 */
void Router::on_connect_node() {
  ServerConnector& server = ServerConnector::get_instance();

  server.send_bind_node(my_nid, config.at("node-name").get<std::string>());
}

/**
 * When bind is success, store assigned nid as my-nid.
 * @param nid Assigned nid for this node.
 */
void Router::on_bind_node(const nid_t& nid) {
  my_nid = nid;
}

/**
 * When receive a packet, and relay it to capable module.
 * Packet type is 'sched', relay this packet to Scheduler.
 * Packet type is 'meory' or 'vm', relay this packet to WorkerConnector.
 * @param pid Target process-id.
 * @param type Packet type.
 * @param packet Packet content.
 */
void Router::on_recv_relay(const vpid_t& pid, const std::string& type, const std::string& packet) {
  if (type == "memory" || type == "vm") {
    WorkerConnector& worker = WorkerConnector::get_instance();
    worker.relay_packet(pid, type, packet);

  } else if (type == "sched") {
    scheduler.on_recv_packet(pid, packet);

  } else {
    /// @todo error
    assert(false);
  }
}

/**
 * When scheduler require create vm, call Worker's method to do it.
 * @param scheduler Caller instance.
 * @param pid Process-id for new vm.
 * @param root_tid Root thread-id for new vm.
 * @param proc_addr Address of process information for new vm.
 * @param master_nid Node-id of master node for new vm.
 */
void Router::scheduler_create_vm(Scheduler& scheduler, const vpid_t& pid, vtid_t root_tid,
                                 vaddr_t proc_addr, const nid_t& master_nid) {
  WorkerConnector& worker = WorkerConnector::get_instance();

  worker.create_vm(pid, root_tid, proc_addr, master_nid);
}

/**
 * When scheduler require this node's node-id, return it.
 * @param scheduler Caller instance.
 */
nid_t Router::scheduler_get_my_nid(Scheduler& scheduler) {
  return my_nid;
}

/**
 * When scheduler require execute vm command, call Worke's method to do it.
 * @param scheduler Caller instance.
 * @param pid Target process-id to execute vm.
 * @param command Command string.
 * @param param Parameter JSON object.
 */
void Router::scheduler_vm_command(Scheduler& scheduler, const vpid_t& pid,
                                  const std::string& command, const picojson::object& param) {
  WorkerConnector& worker = WorkerConnector::get_instance();

  worker.send_scheduler_command(pid, command, param);
}

/**
 * When scheduler require check process is having process, call Worke's method to do it.
 * @param scheduler Caller instance.
 * @param pid Target process-id to check.
 * @return True if process instance was exist in thid node.
 */
bool Router::scheduler_have_process(Scheduler& scheduler, const vpid_t& pid) {
  WorkerConnector& worker = WorkerConnector::get_instance();

  return worker.have_process(pid);
}

/**
 * When scheduler require send packet to other node, call ServerConnector's method to do it.
 * @param scheduler Caller instance.
 * @param pid Process-id bundling packet.
 * @param dst_nid Destination node-id.
 * @param packet Packet to send.
 */
void Router::scheduler_send_packet(Scheduler& scheduler, const vpid_t& pid,
                                   const nid_t& dst_nid, const std::string& packet) {
  ServerConnector& server = ServerConnector::get_instance();

  server.relay_packet(pid, dst_nid, "sched", packet);
}
}  // namespace processwarp
