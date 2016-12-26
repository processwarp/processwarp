
#include <unistd.h>

#include <cassert>
#include <cstring>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

#include "constant.hpp"
#include "constant_vm.hpp"
#include "daemon_mid.hpp"
#include "frontend_connector.hpp"
#include "logger.hpp"
#include "router.hpp"
#include "scheduler.hpp"
#include "net/webrtc/server_connector.hpp"
#include "types.hpp"
#include "utils.hpp"
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
  ServerConnector& server = ServerConnector::get_instance();

  if (server.get_status() != ConnectStatus::CONNECT) {
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

  server.send_load_llvm(Utils::file_basename(filename, true), file.str(), args,
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
 * When receive a command from local modules.
 * set destination node-id and pass content to WebRTC module.
 * @param packet Command packet.
 */
void Router::relay_from_local(const Packet& packet) {
  assert(my_nid != NodeID::NONE);

  NodeID dst_nid;
  if (packet.dst_nid == NodeID::THIS) {
    assert(my_nid != NodeID::NONE);
    dst_nid = my_nid;
  } else if (packet.dst_nid == NodeID::NONE) {
    dst_nid = scheduler.get_dst_nid(packet.pid, packet.dst_module);
  } else {
    dst_nid = packet.dst_nid;
  }

  Packet real_packet = {
    packet.packet_id,
    packet.command,
    packet.mode,
    packet.dst_module,
    packet.src_module,
    packet.pid,
    dst_nid,
    my_nid,
    packet.content
  };

  WebrtcConnector& webrtc = WebrtcConnector::get_instance();
  webrtc.relay(real_packet);
}

/**
 * When receive a command from another nodes to this module, relay to capable local module.
 * @param packet Command packet.
 */
void Router::relay_from_global(const Packet& packet) {
  if (packet.dst_module & (Module::MEMORY | Module::VM)) {
    WorkerConnector& worker = WorkerConnector::get_instance();
    worker.relay_packet(packet);
  }

  if (packet.dst_module & Module::SCHEDULER) {
    scheduler.recv_packet(packet);
  }

  if (packet.dst_module & (Module::CONTROLLER | Module::GUI)) {
    FrontendConnector& frontend = FrontendConnector::get_instance();
    frontend.relay_packet(packet);
  }
}

/**
 * Relay create_vm require to scheduler.
 * @param pid Target process-id.
 * @return Scheduler's return value.
 */
bool Router::require_create_vm(const vpid_t& pid) {
  return scheduler.require_create_vm(pid);
}

/**
 * When nid has set, store assigned my node-id and hostname as node name.
 * @param nid Assigned node-id for this node.
 */
void Router::set_nid(const NodeID& nid) {
  my_nid = nid;
  Logger::dbg(DaemonMid::L1013, getpid(), my_nid.to_str().c_str());

  // get local hostname
  char hostname[Definition::NODE_NAME_MAX + 1];
  std::memset(hostname, 0, sizeof(hostname));
  gethostname(hostname, Definition::NODE_NAME_MAX);

  scheduler.set_node_information(nid, std::string(hostname));
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
                                 vaddr_t proc_addr, const std::string& name) {
  WorkerConnector& worker = WorkerConnector::get_instance();

  worker.create_vm(pid, root_tid, proc_addr, name);
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
 * When scheduler require send a packet, relay it.
 * @param scheduler Caller instance.
 * @param packet A packet.
 */
void Router::scheduler_send_packet(Scheduler& scheduler, const Packet& packet) {
  relay_from_local(packet);
}

/**
 * When libuv's a heartbeat timer event is happen, call heartbeat method.
 * @param handle Libuv's timer event handler containing pointer to Router instance.
 */
void Router::on_timer_heartbeat(uv_timer_t* handle) {
  Router& THIS = *reinterpret_cast<Router*>(handle->data);

  THIS.scheduler.heartbeat();
}

/**
 * When libuv's a routine timer event is happen, call routine method.
 * @param handle Libuv's timer event handler containing pointer to Router instance.
 */
void Router::on_timer_routine(uv_timer_t* handle) {
  Router& THIS = *reinterpret_cast<Router*>(handle->data);
  WorkerConnector& worker = WorkerConnector::get_instance();

  THIS.scheduler.beat_routine();
  worker.beat_routine();
}

/**
 * Initialize a timer event to call Scheduler::execute for each interval.
 */
void Router::initialize_timer() {
  uv_timer_init(loop, &heartbeat_timer);
  heartbeat_timer.data = this;
  uv_timer_start(&heartbeat_timer, Router::on_timer_heartbeat,
                 0, HEARTBEAT_INTERVAL * 1000);

  uv_timer_init(loop, &routine_timer);
  routine_timer.data = this;
  uv_timer_start(&routine_timer, Router::on_timer_routine,
                 0, BEAT_ROUTINE_INTERVAL * 1000);
}
}  // namespace processwarp
