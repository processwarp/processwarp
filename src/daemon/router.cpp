
#include <unistd.h>

#include <cassert>
#include <cstring>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

#include "constant.hpp"
#include "constant_vm.hpp"
#include "frontend_connector.hpp"
#include "network_connector.hpp"
#include "router.hpp"
#include "scheduler.hpp"
#include "type.hpp"
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
  initialize_timer();
}

/**
 * Open the LLVM-IR file and send load-llvm command to server.
 * @param filename Filename of LLVM-IR.
 * @param args Arguments to pass application's entry point.
 */
void Router::load_llvm(const std::string& filename, const std::vector<std::string>& args) {
  NetworkConnector& network = NetworkConnector::get_instance();

  if (network.get_status() != ConnectStatus::CONNECT) {
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

  network.send_load_llvm(Util::file_basename(filename, true), file.str(), args,
                         scheduler.get_new_pid(), my_nid);
}

/**
 * Get this node's node-id.
 * @return This node's node-id.
 */
const NodeID& Router::get_my_nid() {
  assert(my_nid != NodeID::NONE);

  return my_nid;
}

/**
 * When bind is success, store assigned my node-id and hostname as node name.
 * @param nid Assigned node-id for this node.
 */
void Router::recv_bind_node(const NodeID& nid) {
  my_nid = nid;

  // get local hostname
  char hostname[Definition::NODE_NAME_MAX + 1];
  std::memset(hostname, 0, sizeof(hostname));
  gethostname(hostname, Definition::NODE_NAME_MAX);

  scheduler.set_node_information(nid, std::string(hostname));
}

/**
 * When receive a command from any modules or another nodes to this module,
 * set destination node-id and pass content to capable module in this node or another node through the server.
 * @param packet Command packet.
 * @param is_from_server Set true if packet is relaied by server (send by another node).
 */
void Router::relay_command(const Packet& packet, bool is_from_server) {
  NodeID dst_nid;
  NodeID src_nid;
  if (is_from_server) {
    dst_nid = packet.dst_nid;
    src_nid = packet.src_nid;

  } else {
    if (packet.dst_nid == NodeID::THIS) {
      dst_nid = my_nid;
    } else if (packet.dst_nid == NodeID::NONE) {
      dst_nid = scheduler.get_dst_nid(packet.pid, packet.dst_module);
    } else {
      dst_nid = packet.dst_nid;
    }
    src_nid = my_nid;
  }

#warning TODO
  /*
  Packet real_packet = {
    packet.pid,
    dst_nid,
    src_nid,
    packet.dst_module,
    packet.content
  };

  if (dst_nid == my_nid || dst_nid == NodeID::BROADCAST) {
    switch (real_packet.dst_module) {
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
    NetworkConnector& network = NetworkConnector::get_instance();
    network.send_relay_command(real_packet);
  }
  */
}

/**
 * When scheduler require create vm, call Worker's method to do it.
 * @param scheduler Caller instance.
 * @param pid Process-id for new vm.
 * @param root_tid Root thread-id for new vm.
 * @param proc_addr Address of process information for new vm.
 * @param master_nid Node-id of master node for new vm.
 * @param name Process name for new vm.
 */
void Router::scheduler_create_vm(Scheduler& scheduler, const vpid_t& pid, vtid_t root_tid,
                                 vaddr_t proc_addr, const NodeID& master_nid,
                                 const std::string& name) {
  WorkerConnector& worker = WorkerConnector::get_instance();

  worker.create_vm(pid, root_tid, proc_addr, master_nid, name);
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
void Router::scheduler_send_command(Scheduler& scheduler, const Packet& packet) {
  relay_command(packet, false);
}

/**
 * When libuv's a timer event is happen, call Scheduler::execute.
 */
void Router::on_timer_for_execute(uv_timer_t* handle) {
  Router& THIS = *reinterpret_cast<Router*>(handle->data);

  THIS.scheduler.execute();
}

/**
 * Initialize a timer event to call Scheduler::execute for each interval.
 */
void Router::initialize_timer() {
  uv_timer_init(loop, &timer_for_execute);
  timer_for_execute.data = this;
  uv_timer_start(&timer_for_execute, Router::on_timer_for_execute,
                 0, SCHEDULER_EXECUTE_INTERVAL * 1000);
}
}  // namespace processwarp
