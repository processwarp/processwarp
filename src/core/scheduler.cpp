
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
 * Require thread to warp, according to load (count of runing threads) of next nodes.
 */
void Scheduler::balance_load() {
  // Cleanup load_infos.
  std::time_t now = std::time(nullptr);
  auto it_load_info = load_infos.begin();
  while (it_load_info != load_infos.end()) {
    if (it_load_info->second.last_update + HEARTBEAT_DEADLINE < now) {
      it_load_info = load_infos.erase(it_load_info);
    } else {
      it_load_info++;
    }
  }

  uint32_t my_thread_num = 0;
  vpid_t candidate_pid = PID::BROADCAST;
  vtid_t candidate_tid;
  for (const auto& it_process : processes) {
    const ProcessInfo& process_info = it_process.second;
    for (const auto& it_thread : process_info.threads) {
      if (it_thread.second == my_info.nid) {
        my_thread_num++;
        candidate_pid = it_process.first;
        candidate_tid = it_thread.first;
      }
    }
  }

  if (my_thread_num == 0) {
    return;
  }

  uint32_t min_thread_num = my_thread_num;
  std::time_t earliest_warp = std::time(nullptr);
  NodeID candidate_nid = my_info.nid;
  for (auto& it_load_info : load_infos) {
    const NodeID& nid = it_load_info.first;
    LoadInfo& load_info = it_load_info.second;

    if (load_info.thread_num < min_thread_num ||
        (load_info.thread_num == min_thread_num &&
         load_info.last_warp < earliest_warp)) {
      min_thread_num = load_info.thread_num;
      earliest_warp = load_info.last_warp;
      candidate_nid = nid;
    }
  }

  if (candidate_nid != my_info.nid &&
      my_thread_num - 1 > min_thread_num + 1) {
    send_command_require_warp_thread(candidate_pid, candidate_tid, candidate_nid);
  }
}

/**
 * Scheduler main routine.
 * Router or super module must be call this method at least once a BEAT_ROUTINE_INTERVAL.
 */
void Scheduler::beat_routine() {
  // Skip if didn't setup yet.
  if (my_info.nid == NodeID::NONE) return;

  // Cleanup unresponsive module.
  cleanup_unresponsive_process();
  cleanup_unresponsive_node();

  // Load balancing.
  balance_load();

  // Output debug log.
  for (auto& it_process : processes) {
    ProcessInfo& info = it_process.second;

    int thread_count = 0;
    for (auto& it_thread : info.threads) {
      if (it_thread.second == my_info.nid) {
        thread_count++;
      }
    }

    Logger::dbg(CoreMid::L1008,
                my_info.nid.to_str().c_str(),
                Convert::vpid2str(info.pid).c_str(),
                info.name.c_str(),
                thread_count);
  }
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
 * Send heartbeat command each timing.
 */
void Scheduler::heartbeat() {
  send_command_heartbeat_scheduler();
}

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

    assert((AddressRegion::MASK & info.root_tid) == AddressRegion::META &&
           info.proc_addr != VADDR_NULL);
    assert((AddressRegion::MASK & info.proc_addr) == AddressRegion::META &&
           info.proc_addr != VADDR_NULL);

    delegate->scheduler_create_vm(*this, pid, info.root_tid, info.proc_addr, info.name);

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
  std::time_t now = std::time(nullptr);
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
  std::time_t now = std::time(nullptr);
  bool is_changed = false;

  auto it_proc = processes.begin();
  while (it_proc != processes.end()) {
    ProcessInfo& info = it_proc->second;
    // Cleanup processes.
    if (info.heartbeat_vm + HEARTBEAT_DEADLINE < now) {
      // Remove information of threads these had run in this node.
      auto it_thread = info.threads.begin();
      while (it_thread != info.threads.end()) {
        if (it_thread->second == my_info.nid) {
          it_thread = info.threads.erase(it_thread);
        } else {
          it_thread++;
        }
      }
      info.threads.erase(it_thread, info.threads.end());
      // Send new thread information as heartbeat.
      info.order_id += static_cast<uint32_t>(rnd() % 100);
      info.last_update_nid = my_info.nid;
      send_command_heartbeat_scheduler();
      is_changed = true;
    }

    if (info.threads.size() == 0 &&
        info.root_tid != VADDR_NULL &&
        info.heartbeat_vm + HEARTBEAT_DEADLINE < now) {
      it_proc = processes.erase(it_proc);

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
 * Get count of threads, running on this node.
 * @return Count of threads.
 */
uint32_t Scheduler::get_my_thread_num() {
  uint32_t thread_num = 0;
  for (const auto& it_process : processes) {
    const ProcessInfo& process_info = it_process.second;
    for (const auto& it_thread : process_info.threads) {
      if (it_thread.second == my_info.nid) {
        thread_num++;
      }
    }
  }
  return thread_num;
}

/**
 * Decode load information from another node, and store it to load_infos.
 * @param src_nid Source node-id of load information.
 * @param info JSON object containing last_warp and thread_num.
 */
void Scheduler::input_load_info(const NodeID& src_nid, const picojson::object& info) {
  LoadInfo& load_info = load_infos[src_nid];

  load_info.last_update = std::time(nullptr);
  load_info.last_warp = Convert::json2time(info.at("last_warp"));
  load_info.thread_num = Convert::json2int<uint32_t>(info.at("thread_num"));
}

/**
 * Encode my node's load information to send to next nodes.
 * @return Load information as a JSON object.
 */
picojson::object Scheduler::output_load_info() {
  picojson::object load_info;

  load_info.insert(std::make_pair("last_warp", Convert::time2json(last_warp)));
  load_info.insert(std::make_pair("thread_num", Convert::int2json(get_my_thread_num())));

  return load_info;
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
      if (it_thread.second == my_info.nid) {
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

  std::time_t now = std::time(nullptr);

  if (packet.src_nid != my_info.nid) {
    /// @todo error
    assert(false);
  }

  auto it_info = processes.find(packet.pid);
  if (it_info == processes.end()) {
    ProcessInfo info;
    info.pid = packet.pid;
    info.root_tid = VADDR_NULL;
    info.proc_addr = VADDR_NULL;
    info.gui_nid = my_info.nid;
    info.having_vm = false;
    info.heartbeat_gui = now;
    processes.insert(std::make_pair(info.pid, info));

  } else {
    it_info->second.gui_nid = my_info.nid;
    it_info->second.heartbeat_gui = now;
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
      if (it_thread.second == my_info.nid) {
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

  std::time_t now = std::time(nullptr);
  auto it_info = processes.find(packet.pid);

  if (it_info == processes.end()) {
    ProcessInfo info;
    info.pid = packet.pid;
    info.root_tid = VADDR_NULL;
    info.proc_addr = VADDR_NULL;
    info.gui_nid = packet.src_nid;
    info.having_vm = false;
    info.heartbeat_gui = now;
    processes.insert(std::make_pair(packet.pid, info));

  } else {
    it_info->second.gui_nid = packet.src_nid;
    it_info->second.heartbeat_gui = now;
  }
}

/**
 * When receive heartbeat_scheduler command, save sender's information and update timestamp.
 * @param packet Command packet.
 */
void Scheduler::recv_command_heartbeat_scheduler(const Packet& packet) {
  bool is_changed = false;

  for (const auto& it_process : packet.content.at("processes").get<picojson::object>()) {
    const vpid_t& pid = Convert::str2vpid(it_process.first);
    const picojson::object& proc = it_process.second.get<picojson::object>();

    EndlessOrderID order_id = EndlessOrderID::from_json(proc.at("order_id"));
    NodeID last_update_nid = NodeID::from_json(proc.at("last_update_nid"));
    std::time_t now = std::time(nullptr);

    if (processes.find(pid) == processes.end()) {
      ProcessInfo info;
      info.pid = pid;
      info.root_tid = Convert::json2vtid(proc.at("root_tid"));
      info.proc_addr = Convert::json2vaddr(proc.at("proc_addr"));
      info.heartbeat_vm = now;
      info.heartbeat_gui = now;
      info.having_vm = false;

      assert((AddressRegion::MASK & info.root_tid) == AddressRegion::META &&
           info.proc_addr != VADDR_NULL);
      assert((AddressRegion::MASK & info.proc_addr) == AddressRegion::META &&
           info.proc_addr != VADDR_NULL);

      processes.insert(std::make_pair(pid, info));
    }

    ProcessInfo& info = processes.at(pid);
    assert(info.root_tid == Convert::json2vtid(proc.at("root_tid")));
    assert(info.proc_addr == Convert::json2vaddr(proc.at("proc_addr")));

    if (order_id > info.order_id ||
        (order_id == info.order_id && last_update_nid > info.last_update_nid)) {
      info.name = proc.at("name").get<std::string>();
      info.threads.clear();
      for (auto& it : proc.at("threads").get<picojson::object>()) {
        vtid_t tid = Convert::str2vtid(it.first);
        NodeID nid = NodeID::from_json(it.second);
        info.threads.insert(std::make_pair(tid, nid));
      }
      info.gui_nid = NodeID::from_json(proc.at("gui_nid"));
      info.order_id = order_id;
      info.last_update_nid = last_update_nid;

      is_changed = true;
    }
  }

  input_load_info(packet.src_nid,
                  packet.content.at("load_info").get<picojson::object>());

  if (is_changed) {
    last_warp = std::time(nullptr);
    send_command_heartbeat_scheduler();
    send_command_processes_info();
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

  assert(packet.src_nid == my_info.nid);

  if (processes.find(packet.pid) == processes.end()) {
    ProcessInfo info;
    info.pid = packet.pid;
    info.root_tid = VADDR_NULL;
    info.proc_addr = VADDR_NULL;
    info.gui_nid = NodeID::NONE;
    info.having_vm = false;
    processes.insert(std::make_pair(packet.pid, info));
  }

  ProcessInfo& info = processes.at(packet.pid);
  std::set<vtid_t> tids;

  info.having_vm = true;
  info.name = packet.content.at("name").get<std::string>();
  info.heartbeat_vm = now;

  // Compair threads and update for relate threads.
  for (auto& it_thread : packet.content.at("threads").get<picojson::array>()) {
    vtid_t tid = Convert::json2vtid(it_thread);
    auto thread_pair = info.threads.find(tid);

    if (thread_pair == info.threads.end()) {
      info.threads.insert(std::make_pair(tid, packet.src_nid));
      is_changed = true;

    } else if (thread_pair->second != packet.src_nid) {
      info.threads.at(tid) = packet.src_nid;
      is_changed = true;
    }

    tids.insert(tid);
  }

  // Remove thread-id from list if it had run in source node but not run at now.
  auto it_thread = info.threads.begin();
  while (it_thread != info.threads.end()) {
    if (it_thread->second == packet.src_nid &&
        tids.find(it_thread->first) == tids.end()) {
      it_thread = info.threads.erase(it_thread);
      is_changed = true;

    } else {
      it_thread++;
    }
  }

  if (is_changed) {
    info.order_id += static_cast<uint32_t>(rnd() % 100);
    info.last_update_nid = my_info.nid;
    send_command_heartbeat_scheduler();
    send_command_processes_info();
  }
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
  std::time_t now = std::time(nullptr);

  if (it_info == processes.end()) {
    ProcessInfo info;
    info.pid = packet.pid;
    info.root_tid = VADDR_NULL;
    info.proc_addr = VADDR_NULL;
    info.gui_nid = my_info.nid;
    info.having_vm = false;
    info.heartbeat_gui = now;
    processes.insert(std::make_pair(packet.pid, info));

  } else {
    it_info->second.gui_nid = my_info.nid;
    it_info->second.heartbeat_gui = now;
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
                                  packet.content.at("name").get<std::string>());
  }

  if (it_info == processes.end()) {
    ProcessInfo info;
    info.pid = packet.pid;
    info.root_tid = Convert::json2vtid(packet.content.at("root_tid"));
    info.proc_addr = Convert::json2vaddr(packet.content.at("proc_addr"));
    info.name = packet.content.at("name").get<std::string>();
    info.gui_nid = NodeID::NONE;
    info.having_vm = true;
    info.heartbeat_vm = now;

    processes.insert(std::make_pair(packet.pid, info));

    assert((AddressRegion::MASK & info.root_tid) == AddressRegion::META &&
           info.proc_addr != VADDR_NULL);
    assert((AddressRegion::MASK & info.proc_addr) == AddressRegion::META &&
           info.proc_addr != VADDR_NULL);

  } else {
    ProcessInfo& info = it_info->second;
    assert((info.root_tid == VADDR_NULL) == (info.proc_addr == VADDR_NULL));

    if (info.root_tid == VADDR_NULL &&
        info.proc_addr == VADDR_NULL) {
      info.root_tid = Convert::json2vtid(packet.content.at("root_tid"));
      info.proc_addr = Convert::json2vaddr(packet.content.at("proc_addr"));
    }
    info.heartbeat_vm = now;

    assert((AddressRegion::MASK & info.root_tid) == AddressRegion::META &&
           info.proc_addr != VADDR_NULL);
    assert((AddressRegion::MASK & info.proc_addr) == AddressRegion::META &&
           info.proc_addr != VADDR_NULL);
  }

  vtid_t tid = Convert::json2vtid(packet.content.at("tid"));
  send_command_warp_thread(packet.pid, tid);
}

/**
 * Send heartbeat_scheduler command to SCHDULER in another node.
 */
void Scheduler::send_command_heartbeat_scheduler() {
  if (my_info.nid == NodeID::NONE) {
    return;
  }

  picojson::object param;
  picojson::object procs;

  for (auto& it_process : processes) {
    const vpid_t& pid = it_process.first;
    ProcessInfo& info = it_process.second;
    picojson::object proc;

    if (info.proc_addr == VADDR_NULL) {
      continue;
    }

    assert((AddressRegion::MASK & info.root_tid) == AddressRegion::META &&
           info.proc_addr != VADDR_NULL);
    assert((AddressRegion::MASK & info.proc_addr) == AddressRegion::META &&
           info.proc_addr != VADDR_NULL);

    proc.insert(std::make_pair("order_id", info.order_id.to_json()));
    proc.insert(std::make_pair("last_update_nid", info.last_update_nid.to_json()));

    proc.insert(std::make_pair("root_tid", Convert::vtid2json(info.root_tid)));
    proc.insert(std::make_pair("proc_addr", Convert::vaddr2json(info.proc_addr)));
    proc.insert(std::make_pair("name", picojson::value(info.name)));
    picojson::object threads;
    for (auto& it : info.threads) {
      vtid_t tid = it.first;
      const NodeID& nid = it.second;
      threads.insert(std::make_pair(Convert::vtid2str(tid), nid.to_json()));
    }
    proc.insert(std::make_pair("threads", picojson::value(threads)));
    proc.insert(std::make_pair("gui_nid", info.gui_nid.to_json()));

    procs.insert(std::make_pair(Convert::vpid2str(pid), picojson::value(proc)));
  }
  param.insert(std::make_pair("processes", picojson::value(procs)));
  param.insert(std::make_pair("load_info", picojson::value(output_load_info())));

  packet_controller.send("heartbeat_scheduler", Module::SCHEDULER, false,
                         PID::BROADCAST, NodeID::NEXT, param);
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
      vtid_t tid = it_thread.first;
      NodeID& nid = it_thread.second;
      threads.insert(std::make_pair(Convert::vtid2str(tid), nid.to_json()));
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
