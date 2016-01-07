
#include <cassert>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

#include "frontend_connector.hpp"
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
void Router::recv_connect_node() {
  ServerConnector& server = ServerConnector::get_instance();

  server.send_bind_node(my_nid, config.at("node-name").get<std::string>());
}

/**
 * When bind is success, store assigned nid as my-nid.
 * @param nid Assigned nid for this node.
 */
void Router::recv_bind_node(const nid_t& nid) {
  my_nid = nid;
  scheduler.set_my_nid(nid);
}

/**
 * When receive a scheduler command, relay it to scheduler.
 * @param pid Target process-id.
 * @param content Command content.
 */
void Router::relay_command(const vpid_t& pid, const picojson::object& content) {
  scheduler.recv_command(pid, content);
}

/**
 * When passed a outer module packet from any module in this node,
 * set destination node-id and pass content to capable module in this node or other node through the server.
 * @param pid Process-id bundled for a packet.
 * @param dst_nid Destination node-id if known, or NONE if source module don't know.
 * @param module Target module.
 * @param content Packet content.
 */
void Router::relay_outer_module_packet(const vpid_t& pid, const nid_t& dst_nid,
                                       OuterModule::Type module, const std::string& content) {
  nid_t real_nid = (dst_nid != SpecialNID::NONE ? dst_nid : scheduler.get_dst_nid(pid, module));

  if (real_nid == my_nid) {
    switch (module) {
      case OuterModule::FRONTEND: {
        FrontendConnector& frontend = FrontendConnector::get_instance();
        frontend.relay_frontend_packet(pid, content);
      } break;

      default: {
        /// @todo error
        assert(false);
      }
    }

  } else {
    ServerConnector& server = ServerConnector::get_instance();

    server.relay_outer_module_packet(pid, real_nid, module, content);
  }
}

/**
 * When receive a scheduler packet, relay it to scheduler.
 * @param pid Target process-id.
 * @param content Packet content.
 */
void Router::relay_scheduler_packet(const vpid_t& pid, const std::string& content) {
  scheduler.recv_packet(pid, content);
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
 * When scheduler require create GUI, call Frontend's methid to do it.
 * @param scheduler Caller instance.
 * @param pid Process-id for new GUI.
 */
void Router::scheduler_create_gui(Scheduler& scheduler, const vpid_t& pid) {
  FrontendConnector& frontend = FrontendConnector::get_instance();

  frontend.create_gui(pid);
}

/**
 * When scheduler require send a command, relay command by command type.
 * @param scheduler Caller instance.
 * @param pid Target process-id to execute it.
 * @param module Target module.
 * @param content Command content.
 */
void Router::scheduler_send_command(Scheduler& scheduler, const vpid_t& pid,
                                    InnerModule::Type module, const picojson::object& content) {
  switch (module) {
    case InnerModule::MEMORY:
    case InnerModule::VM: {
      WorkerConnector& worker = WorkerConnector::get_instance();
      worker.relay_command(pid, module, content);
    } break;

    default: {
      /// @todo error
      assert(false);
    }
  }
}

/**
 * When scheduler require send inner module packet to another node, call ServerConnector's method to do it.
 * @param scheduler Caller instance.
 * @param pid Process-id bundling packet.
 * @param dst_nid Destination node-id.
 * @param module Target module.
 * @param content Packet content.
 */
void Router::scheduler_send_inner_module_packet(Scheduler& scheduler, const vpid_t& pid,
                                                const nid_t& dst_nid, InnerModule::Type module,
                                                const std::string& content) {
  ServerConnector& server = ServerConnector::get_instance();

  server.relay_inner_module_packet(pid, dst_nid, module, content);
}

/**
 * When scheduler require send outer module packet to another node, pass capable method to set dst_nid if need.
 * @param scheduler Caller instance.
 * @param pid Process-id bundling packet.
 * @param dst_nid Destination node-id.
 * @param module Target module.
 * @param content Packet content.
 */
void Router::scheduler_send_outer_module_packet(Scheduler& scheduler, const vpid_t& pid,
                                                const nid_t& dst_nid, OuterModule::Type module,
                                                const std::string& content) {
  relay_outer_module_packet(pid, dst_nid, module, content);
}
}  // namespace processwarp
