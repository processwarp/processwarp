
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
 * When receive a command from any modules or another nodes to this module,
 * set destination node-id and pass content to capable module in this node or another node through the server.
 * @param packet Command packet.
 * @param is_from_server Set true if packet is relaied by server (send by another node).
 */
void Router::relay_command(const CommandPacket& packet, bool is_from_server) {
  nid_t dst_nid;
  nid_t src_nid;
  if (is_from_server) {
    dst_nid = packet.dst_nid;
    src_nid = packet.src_nid;

  } else {
    if (packet.dst_nid == SpecialNID::THIS) {
      dst_nid = my_nid;
    } else if (packet.dst_nid == SpecialNID::NONE) {
      dst_nid = scheduler.get_dst_nid(packet.pid, packet.module);
    } else {
      dst_nid = packet.dst_nid;
    }
    src_nid = my_nid;
  }

  CommandPacket real_packet = {
    packet.pid,
    dst_nid,
    src_nid,
    packet.module,
    packet.content
  };

  if (dst_nid == my_nid || dst_nid == SpecialNID::BROADCAST) {
    switch (real_packet.module) {
      case Module::MEMORY:
      case Module::VM: {
        WorkerConnector& worker = WorkerConnector::get_instance();
        worker.relay_command(real_packet);
      } break;

      case Module::SCHEDULER: {
        scheduler.recv_command(real_packet);
      } break;

      case Module::CONTROLLER:
      case Module::GUI: {
        FrontendConnector& frontend = FrontendConnector::get_instance();
        frontend.relay_frontend_command(real_packet);
      } break;

      default: {
        /// @todo error
        assert(false);
      }
    }
  }

  if (dst_nid != my_nid && !is_from_server) {
    ServerConnector& server = ServerConnector::get_instance();
    server.send_relay_command(real_packet);
  }
}

/**
 * When receive packet from server to scheduler, relay it to scheduler.
 * @param packet Command packet.
 */
void Router::relay_scheduler_command(const CommandPacket& packet) {
  scheduler.recv_command(packet);
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
 * @param packet Command packet.
 */
void Router::scheduler_send_command(Scheduler& scheduler, const CommandPacket& packet) {
  relay_command(packet, false);
}
}  // namespace processwarp
