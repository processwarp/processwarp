
#include <picojson.h>

#include <cassert>
#include <ctime>
#include <map>
#include <set>
#include <string>
#include <vector>

#include "constant.hpp"
#include "constant_vm.hpp"
#include "convert.hpp"
#include "core_mid.hpp"
#include "logger.hpp"
#include "scheduler.hpp"

namespace processwarp {
/**
 * Simple destructor for vtable.
 */
SchedulerDelegate::~SchedulerDelegate() {
}

/**
 * Constructor, set default property.
 */
Scheduler::Scheduler() :
    rnd(std::random_device()()),
    packet_controller(Module::SCHEDULER) {
  my_info.nid  = NodeID::NONE;
  my_info.name = "";
  my_info.heartbeat = 0;
}

/**
 * Initialize scheduler.
 * Save delegater.
 * @param delegate_ Delegater instance for scheduler.
 */
void Scheduler::initialize(SchedulerDelegate& delegate_) {
  delegate = &delegate_;
  packet_controller.initialize(this);
}

/**
 * Resolve destination node-id for packet when source module hasn't resolved it.
 * If target module is FRONTEND, destination node-id is GUI node-id.
 * @param pid Process-id packet is bundled.
 * @param module Target module.
 */
NodeID Scheduler::get_dst_nid(const vpid_t& pid, Module::Type module) {
  assert(my_info.nid != NodeID::NONE);

  switch (module) {
    case Module::GUI: {
      auto it_proc = processes.find(pid);

      if (it_proc == processes.end() ||
          it_proc->second.gui_nid == NodeID::NONE) {
        /// @todo error
        assert(false);
      }

      return it_proc->second.gui_nid;
    } break;

    default: {
      /// @todo error
      assert(false);
      return NodeID::NONE;
    } break;
  }
}

/**
 * Get a new process-id that is not used by another process yet.
 * @return A new process-id.
 */
#if !defined(__ANDROID__)
vpid_t Scheduler::get_new_pid() {
  std::string seed = my_info.nid.to_str() +
    std::to_string(clock()) + std::to_string(rnd());
  vpid_t pid;

  do {
    seed = Util::calc_sha256(seed);
    pid  = Convert::str2vpid(seed);
  } while (processes.find(pid) != processes.end());

  return pid;
}
#endif

/**
 * When receive packet, relay it to PacketController module.
 * @param packet A received packet.
 */
void Scheduler::recv_packet(const Packet& packet) {
  packet_controller.recv(packet);
}

/**
 * When require to create vm from another module in this node,
 * try it if scheduler having the process information.
 * Require will success it after sync process information.
 * The module send requiest should retry it in a constant interval.
 * @param pid Target process's pid.
 * @return True if scheduler had a process information and require had raised to target module.
 */
bool Scheduler::require_create_vm(const vpid_t& pid) {
  auto it = processes.find(pid);
  if (it != processes.end()) {
    ProcessInfo& info = it->second;
    delegate->scheduler_create_vm(*this, pid, info.root_tid, info.proc_addr,
                                  info.leader_nid, info.name);
    return true;

  } else {
    return false;
  }
}

/**
 * Set node-id and node name of this node.
 * Nid must not NONE.
 * @param nid Node-id of this node.
 * @param name Node name of this node.
 */
void Scheduler::set_node_information(const NodeID& nid, const std::string& name) {
  assert(nid != NodeID::NONE);

  my_info.nid  = nid;
  my_info.name = name;
}

/**
 * Scheduler main routine.
 * Router or super module must be call this method at least once a HEARTBEAT_INTERVAL.
 */
void Scheduler::execute() {
  // Skip if didn't setup yet.
  if (my_info.nid == NodeID::NONE) return;

  // Send a heartbeat each interval time.
  std::time_t now = std::time(nullptr);
  if ((now - my_info.heartbeat) > HEARTBEAT_INTERVAL) {
    my_info.heartbeat = now;
    send_command_heartbeat_scheduler();
  }

  // Cleanup unresponsive module.
  cleanup_unresponsive_process();
  cleanup_unresponsive_node();
}

void Scheduler::packet_controller_on_recv(const Packet& packet) {
  assert(my_info.nid != NodeID::NONE);
  assert(packet.dst_module == Module::SCHEDULER);

  const std::string& command = packet.command;

  if (command == "activate") {
    recv_command_activate(packet);

  } else if (command == "create_gui") {
    recv_command_create_gui(packet);

  } else if (command == "distribute") {
    recv_command_distribute(packet);

  } else if (command == "heartbeat_gui") {
    recv_command_heartbeat_gui(packet);

  } else if (command == "heartbeat_scheduler") {
    recv_command_heartbeat_scheduler(packet);

  } else if (command == "heartbeat_vm") {
    recv_command_heartbeat_vm(packet);

  } else if (command == "require_processes_info") {
    recv_command_require_processes_info(packet);

  } else if (command == "warp_gui") {
    recv_command_warp_gui(packet);

  } else if (command == "warp_thread") {
    recv_command_warp_thread(packet);

  } else {
    Logger::warn(CoreMid::L1003);
    Logger::dbg(CoreMid::L1005,
                packet.pid.c_str(), packet.dst_nid.to_str().c_str(),
                packet.src_nid.to_str().c_str(), packet.dst_module,
                picojson::value(packet.content).serialize().c_str());
    assert(false);
  }
}

void Scheduler::packet_controller_send(const Packet& packet) {
  delegate->scheduler_send_packet(*this, packet);
}

/**
 * Cleanup unresponsive nodes that didn't send any heartbeat over HEATBEAT_DEADLINE seconds.
 */
void Scheduler::cleanup_unresponsive_node() {
  std::time_t now = time(nullptr);

  auto it_node = nodes.begin();
  while (it_node != nodes.end()) {
    if (it_node->second.heartbeat + HEARTBEAT_DEADLINE < now) {
      it_node = nodes.erase(it_node);
    } else {
      it_node++;
    }
  }
}

/**
 * Cleanup unresponsive threads and processes that didn't send any heartbeat over HEATBEAT_DEADLINE seconds.
 */
void Scheduler::cleanup_unresponsive_process() {
  std::time_t now = time(nullptr);
  bool is_changed = false;

  auto it_proc = processes.begin();
  while (it_proc != processes.end()) {
    ProcessInfo& info = it_proc->second;

    // Cleanup threads.
    auto it_thread = info.threads.begin();
    while (it_thread != info.threads.end()) {
      if (it_thread->second.heartbeat + HEARTBEAT_DEADLINE < now) {
        it_thread = info.threads.erase(it_thread);
        is_changed = true;
      } else {
        it_thread++;
      }
    }

    // Cleanup processes.
    if (info.threads.size() == 0 &&
        info.heartbeat + HEARTBEAT_DEADLINE < now) {
      it_proc = processes.erase(it_proc);
      is_changed = true;
    } else {
      it_proc++;
    }
  }

  // Send processes_info command if set of processes are changed.
  if (is_changed) {
    send_command_processes_info();
  }
}

/**
 * When receive activate command, listup process and frontend that have to warp active node.
 * Ignode command if receive activate command from this node.
 * call warp method to do it.
 * @param packet Command packet.
 */
void Scheduler::recv_command_activate(const Packet& packet) {
  assert(packet.pid == PID::BROADCAST);

  if (packet.src_nid == my_info.nid) return;

  for (auto& it_info : processes) {
    ProcessInfo& info = it_info.second;

    for (auto& it_thread : info.threads) {
      if (it_thread.second.nid == my_info.nid) {
        send_command_require_warp_thread(info.pid, it_thread.first, packet.src_nid);
      }
    }

    if (info.gui_nid == my_info.nid) {
      send_command_require_warp_gui(info.pid, packet.src_nid);
    }
  }
}

/**
 * When receive create_gui command, call create_gui on frontend through delegate.
 * @param packet Command packet.
 */
void Scheduler::recv_command_create_gui(const Packet& packet) {
  assert(packet.pid != PID::BROADCAST);

  std::time_t now = time(nullptr);

  if (packet.src_nid != my_info.nid) {
    /// @todo error
    assert(false);
  }

  auto it_info = processes.find(packet.pid);
  if (it_info == processes.end()) {
    ProcessInfo info;

    info.pid = packet.pid;
    info.gui_nid = my_info.nid;
    info.having_vm = false;
    info.heartbeat = now;
    processes.insert(std::make_pair(info.pid, info));

  } else {
    it_info->second.gui_nid = my_info.nid;
    it_info->second.heartbeat = now;
  }

  delegate->scheduler_create_gui(*this, packet.pid);
}

/**
 * When receive distribute command, distribute processes runnning in this node to another node.
 * @param packet Command packet.
 */
void Scheduler::recv_command_distribute(const Packet& packet) {
  assert(packet.pid == PID::BROADCAST);

  if (packet.src_nid != my_info.nid) {
    /// @todo error
    assert(false);
  }

  NodeID target_nid = NodeID::NONE;
  for (auto& it_node : nodes) {
    if (it_node.second.nid != my_info.nid) {
      target_nid = it_node.second.nid;
      break;
    }
  }

  // Skip if another node are not exist.
  if (target_nid == my_info.nid) {
    return;
  }

  for (auto& it_proc : processes) {
    ProcessInfo& proc = it_proc.second;

    for (auto& it_thread : proc.threads) {
      if (it_thread.second.nid == my_info.nid) {
        send_command_require_warp_thread(proc.pid, it_thread.first, target_nid);
      }
    }
  }
}

/**
 * When receive heartbeat_gui command, update destination node-id for GUI
 * @param packet Command packet.
 */
void Scheduler::recv_command_heartbeat_gui(const Packet& packet) {
  assert(packet.pid != PID::BROADCAST);

  std::time_t now = time(nullptr);
  auto it_info = processes.find(packet.pid);

  if (it_info == processes.end()) {
    ProcessInfo info;
    info.pid = packet.pid;
    info.gui_nid = packet.src_nid;
    info.having_vm = false;
    info.heartbeat = now;
    processes.insert(std::make_pair(packet.pid, info));

  } else {
    it_info->second.gui_nid = packet.src_nid;
    it_info->second.heartbeat = now;
  }
}

/**
 * When receive heartbeat_scheduler command, save sender's information and update timestamp.
 * @param packet Command packet.
 */
void Scheduler::recv_command_heartbeat_scheduler(const Packet& packet) {
  std::string name = packet.content.at("name").get<std::string>();
  std::time_t now  = std::time(nullptr);
  auto it_info = nodes.find(packet.src_nid);

  assert(packet.pid == PID::BROADCAST);

  if (packet.src_nid == my_info.nid) return;

  if (it_info == nodes.end()) {
    NodeInfo info;
    info.nid  = packet.src_nid;
    info.name = name;
    info.heartbeat = now;
    nodes.insert(std::make_pair(info.nid, info));

  } else {
    NodeInfo& info = it_info->second;
    info.name = name;
    info.heartbeat = now;
  }
}

/**
 * When receive heartbeat_vm command, update local processes list and
 * send the process_info command to controller if list was changed.
 * @todo Remove process if no one threads are rest.
 * @param packet Command packet.
 */
void Scheduler::recv_command_heartbeat_vm(const Packet& packet) {
  bool is_changed = false;
  std::time_t now = std::time(nullptr);

  if (processes.find(packet.pid) == processes.end()) {
    ProcessInfo info;
    info.pid = packet.pid;
    info.gui_nid = NodeID::NONE;
    info.having_vm = false;
    processes.insert(std::make_pair(packet.pid, info));
  }

  ProcessInfo& info = processes.at(packet.pid);
  std::set<vtid_t> tids;

  if (packet.src_nid == my_info.nid) info.having_vm = true;
  info.name = packet.content.at("name").get<std::string>();
  info.heartbeat = now;

  // Compair threads and update for relate threads.
  for (auto& it_thread : packet.content.at("threads").get<picojson::array>()) {
    vtid_t tid = Convert::json2vtid(it_thread);
    auto thread_pair = info.threads.find(tid);

    if (thread_pair == info.threads.end()) {
      ThreadInfo thread_info;
      thread_info.tid = tid;
      thread_info.nid = packet.src_nid;
      thread_info.heartbeat = now;
      info.threads.insert(std::make_pair(tid, thread_info));
      is_changed = true;

    } else if (thread_pair->second.nid != packet.src_nid) {
      ThreadInfo& thread_info = info.threads.at(tid);
      thread_info.nid = packet.src_nid;
      thread_info.heartbeat = now;
      is_changed = true;

    } else {
      info.threads.at(tid).heartbeat = now;
    }

    tids.insert(tid);
  }

  // Remove thread-id from list if it had run in source node but not run at now.
  auto it_thread = info.threads.begin();
  while (it_thread != info.threads.end()) {
    if (it_thread->second.nid == packet.src_nid &&
        tids.find(it_thread->first) == tids.end()) {
      it_thread->second.nid = NodeID::NONE;
      is_changed = true;

    } else {
      it_thread++;
    }
  }

  if (is_changed) send_command_processes_info();
}

/**
 * When receive require_processes_info, send processes_info command.
 */
void Scheduler::recv_command_require_processes_info(const Packet& packet) {
  send_command_processes_info();
}

/**
 * When receive warp_gui packet, create gui in this node.
 * @param packet Command packet.
 */
void Scheduler::recv_command_warp_gui(const Packet& packet) {
  auto it_info = processes.find(packet.pid);
  std::time_t now = time(nullptr);

  if (it_info == processes.end()) {
    ProcessInfo info;
    info.pid = packet.pid;
    info.gui_nid = my_info.nid;
    info.having_vm = false;
    info.heartbeat = now;
    processes.insert(std::make_pair(packet.pid, info));

  } else {
    it_info->second.gui_nid = my_info.nid;
    it_info->second.heartbeat = now;
  }

  delegate->scheduler_create_gui(*this, packet.pid);
}

/**
 * When recv warp_thread command, create new.
 * Update process information this node having.
 * Send warp_thread command to the new vm.
 * @param packet Command packet.
 */
void Scheduler::recv_command_warp_thread(const Packet& packet) {
  std::time_t now = std::time(nullptr);
  auto it_info = processes.find(packet.pid);
  if (it_info == processes.end() ||
      !it_info->second.having_vm) {
    delegate->scheduler_create_vm(*this, packet.pid,
                                  Convert::json2vtid(packet.content.at("root_tid")),
                                  Convert::json2vaddr(packet.content.at("proc_addr")),
                                  NodeID::from_json(packet.content.at("master_nid")),
                                  packet.content.at("name").get<std::string>());
  }

  if (it_info == processes.end()) {
    ProcessInfo info;
    info.pid = packet.pid;
    info.root_tid = Convert::json2vtid(packet.content.at("root_tid"));
    info.proc_addr = Convert::json2vaddr(packet.content.at("proc_addr"));
    info.leader_nid = NodeID::from_json(packet.content.at("master_nid"));
    info.name = packet.content.at("name").get<std::string>();
    info.gui_nid = NodeID::NONE;
    info.having_vm = true;
    info.heartbeat = now;
    processes.insert(std::make_pair(packet.pid, info));

  } else {
    it_info->second.heartbeat = now;
  }

  vtid_t tid = Convert::json2vtid(packet.content.at("tid"));
  send_command_warp_thread(packet.pid, tid);
}

/**
 * Send heartbeat_scheduler command to SCHDULER in another node.
 */
void Scheduler::send_command_heartbeat_scheduler() {
  picojson::object param;
  param.insert(std::make_pair("name", picojson::value(my_info.name)));

  packet_controller.send("heartbeat_scheduler", Module::SCHEDULER,
                         false, PID::BROADCAST, NodeID::NEXT, param);
}

/**
 * Listup process information and send processes_info command to controller.
 */
void Scheduler::send_command_processes_info() {
  picojson::array procs;
  for (auto& it_process : processes) {
    ProcessInfo& info = it_process.second;

    picojson::object threads;
    for (auto& it_thread : info.threads) {
      ThreadInfo& thread_info = it_thread.second;
      threads.insert(std::make_pair(Convert::vtid2str(thread_info.tid),
                                    thread_info.nid.to_json()));
    }

    picojson::object proc;
    proc.insert(std::make_pair("pid", Convert::vpid2json(info.pid)));
    proc.insert(std::make_pair("name", picojson::value(info.name)));
    proc.insert(std::make_pair("threads", picojson::value(threads)));

    procs.push_back(picojson::value(proc));
  }

  picojson::object param;
  param.insert(std::make_pair("processes", picojson::value(procs)));

  packet_controller.send("processes_info", Module::CONTROLLER, true,
                         PID::BROADCAST, my_info.nid, param);
}


/**
 * Send require_warp_gui command to GUI module.
 * @param pid Target process-id to warp.
 * @param target_nid Destination node-id to warp.
 */
void Scheduler::send_command_require_warp_gui(const vpid_t& pid, const NodeID& target_nid) {
  picojson::object param;
  param.insert(std::make_pair("target_nid", target_nid.to_json()));
  packet_controller.send("require_warp_gui", Module::GUI, true,
                         pid, NodeID::THIS, param);
}

/**
 * Send require_warp_thread command to VM module.
 * @param pid Target process-id to warp.
 * @param tid Target thread-id to warp.
 * @param target_nid Destination node-id to warp.
 */
void Scheduler::send_command_require_warp_thread(const vpid_t& pid, vtid_t tid,
                                                 const NodeID& target_nid) {
  picojson::object param;
  param.insert(std::make_pair("tid", Convert::vtid2json(tid)));
  param.insert(std::make_pair("target_nid", target_nid.to_json()));
  packet_controller.send("require_warp_thread", Module::VM, true,
                         pid, NodeID::THIS, param);
}

/**
 * Send warp thread command to VM module.
 * @param pid Target process-id to warp.
 * @param tid Target thread-id to warp.
 */
void Scheduler::send_command_warp_thread(const vpid_t& pid, vtid_t tid) {
  picojson::object param;
  param.insert(std::make_pair("tid", Convert::vtid2json(tid)));
  packet_controller.send("warp_thread", Module::VM, true, pid, NodeID::THIS, param);
}
}  // namespace processwarp
