
#include <picojson.h>

#include <cassert>
#include <ctime>
#include <map>
#include <set>
#include <string>
#include <vector>

#include "convert.hpp"
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
Scheduler::Scheduler() {
  my_info.nid  = SpecialNID::NONE;
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
}

/**
 * Resolve destination node-id for packet when source module hasn't resolved it.
 * If target module is FRONTEND, destination node-id is GUI node-id.
 * @param pid Process-id packet is bundled.
 * @param module Target module.
 */
nid_t Scheduler::get_dst_nid(const vpid_t& pid, Module::Type module) {
  assert(my_info.nid != SpecialNID::NONE);

  switch (module) {
    case Module::GUI: {
      auto it_proc = processes.find(pid);

      if (it_proc == processes.end() ||
          it_proc->second.gui_nid == SpecialNID::NONE) {
        /// @todo error
        assert(false);
      }

      return it_proc->second.gui_nid;
    } break;

    default: {
      /// @todo error
      assert(false);
      return SpecialNID::NONE;
    } break;
  }
}

/**
 * When receive command from another module in this node or another node,
 * pass to capable method with parameters by command string.
 * @param packet Command packet containing command string and parameters.
 */
void Scheduler::recv_command(const CommandPacket& packet) {
  assert(my_info.nid != SpecialNID::NONE);
  assert(packet.dst_nid != SpecialNID::NONE && packet.dst_nid != SpecialNID::THIS);
  assert(packet.src_nid != SpecialNID::NONE && packet.src_nid != SpecialNID::THIS);
  assert(packet.module == Module::SCHEDULER);

  const std::string& command = packet.content.at("command").get<std::string>();
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
    /// @todo error
    print_debug("recv unknown command:%s\n", command.c_str());
    assert(false);
  }
}

/**
 * Set node-id and node name of this node.
 * Nid must not NONE.
 * @param nid Node-id of this node.
 * @param name Node name of this node.
 */
void Scheduler::set_node_information(const nid_t& nid, const std::string& name) {
  assert(nid != SpecialNID::NONE);

  my_info.nid  = nid;
  my_info.name = name;
}

/**
 * Scheduler main routine.
 * Router or super module must be call this method at least once a HEARTBEAT_INTERVAL.
 */
void Scheduler::execute() {
  // Skip if didn't setup yet.
  if (my_info.nid == SpecialNID::NONE) return;

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
void Scheduler::recv_command_activate(const CommandPacket& packet) {
  assert(packet.pid == SpecialPID::BROADCAST);

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
void Scheduler::recv_command_create_gui(const CommandPacket& packet) {
  assert(packet.pid != SpecialPID::BROADCAST);

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
void Scheduler::recv_command_distribute(const CommandPacket& packet) {
  assert(packet.pid == SpecialPID::BROADCAST);

  if (packet.src_nid != my_info.nid) {
    /// @todo error
    assert(false);
  }

  std::vector<nid_t> nids;
  for (auto& it_node : nodes) {
    const nid_t& nid = it_node.second.nid;
    if (nid != my_info.nid) nids.push_back(nid);
  }

  int i = 0;
  for (auto& it_proc : processes) {
    ProcessInfo& proc = it_proc.second;

    for (auto& it_thread : proc.threads) {
      if (it_thread.second.nid == my_info.nid) {
        const nid_t& target_nid = nids.at(i % nids.size());
        send_command_require_warp_thread(proc.pid, it_thread.first, target_nid);
        i++;
      }
    }
  }
}

/**
 * When receive heartbeat_gui command, update destination node-id for GUI
 * @param packet Command packet.
 */
void Scheduler::recv_command_heartbeat_gui(const CommandPacket& packet) {
  assert(packet.pid != SpecialPID::BROADCAST);

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
void Scheduler::recv_command_heartbeat_scheduler(const CommandPacket& packet) {
  std::string name = packet.content.at("name").get<std::string>();
  std::time_t now  = std::time(nullptr);
  auto it_info = nodes.find(packet.src_nid);

  assert(packet.pid == SpecialPID::BROADCAST);

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
void Scheduler::recv_command_heartbeat_vm(const CommandPacket& packet) {
  bool is_changed = false;
  std::time_t now = std::time(nullptr);

  if (processes.find(packet.pid) == processes.end()) {
    ProcessInfo info;
    info.pid = packet.pid;
    info.gui_nid = SpecialNID::NONE;
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
      it_thread->second.nid = SpecialNID::NONE;
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
void Scheduler::recv_command_require_processes_info(const CommandPacket& packet) {
  send_command_processes_info();
}

/**
 * When receive warp_gui packet, create gui in this node.
 * @param packet Command packet.
 */
void Scheduler::recv_command_warp_gui(const CommandPacket& packet) {
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
void Scheduler::recv_command_warp_thread(const CommandPacket& packet) {
  std::time_t now = std::time(nullptr);
  auto it_info = processes.find(packet.pid);
  if (it_info == processes.end() ||
      !it_info->second.having_vm) {
    delegate->scheduler_create_vm(*this, packet.pid,
                                  Convert::json2vtid(packet.content.at("root_tid")),
                                  Convert::json2vaddr(packet.content.at("proc_addr")),
                                  Convert::json2nid(packet.content.at("master_nid")),
                                  packet.content.at("name").get<std::string>());
  }

  if (it_info == processes.end()) {
    ProcessInfo info;
    info.pid = packet.pid;
    info.name = packet.content.at("name").get<std::string>();
    info.gui_nid = SpecialNID::NONE;
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
 * Pass command to delegate to send command to other module in the same node.
 * @param pid Process-id bundle to command.
 * @param dst_nid Destination node-id.
 * @param module Target module.
 * @param command Command string.
 * @param param Parameter for command JSON fromatted.
 */
void Scheduler::send_command(const vpid_t& pid, const nid_t& dst_nid, Module::Type module,
                             const std::string& command, picojson::object& param) {
  assert(param.find("command") == param.end());

  param.insert(std::make_pair("command", picojson::value(command)));
  delegate->scheduler_send_command(*this, {pid, dst_nid, my_info.nid, module, param});
}

/**
 * Send heartbeat_scheduler command to SCHDULER in another node.
 */
void Scheduler::send_command_heartbeat_scheduler() {
  picojson::object param;
  param.insert(std::make_pair("name", picojson::value(my_info.name)));

  send_command(SpecialPID::BROADCAST, SpecialNID::BROADCAST, Module::SCHEDULER,
               "heartbeat_scheduler", param);
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
                                    Convert::nid2json(thread_info.nid)));
    }

    picojson::object proc;
    proc.insert(std::make_pair("pid", Convert::vpid2json(info.pid)));
    proc.insert(std::make_pair("name", picojson::value(info.name)));
    proc.insert(std::make_pair("threads", picojson::value(threads)));

    procs.push_back(picojson::value(proc));
  }

  picojson::object param;
  param.insert(std::make_pair("processes", picojson::value(procs)));

  send_command(SpecialPID::BROADCAST, my_info.nid, Module::CONTROLLER, "processes_info", param);
}


/**
 * Send require_warp_gui command to GUI module.
 * @param pid Target process-id to warp.
 * @param target_nid Destination node-id to warp.
 */
void Scheduler::send_command_require_warp_gui(const vpid_t& pid, const nid_t& target_nid) {
  picojson::object param;
  param.insert(std::make_pair("target_nid", Convert::nid2json(target_nid)));
  send_command(pid, SpecialNID::THIS, Module::GUI, "require_warp_gui", param);
}

/**
 * Send require_warp_thread command to VM module.
 * @param pid Target process-id to warp.
 * @param tid Target thread-id to warp.
 * @param target_nid Destination node-id to warp.
 */
void Scheduler::send_command_require_warp_thread(const vpid_t& pid, vtid_t tid,
                                                 const nid_t& target_nid) {
  picojson::object param;
  param.insert(std::make_pair("tid", Convert::vtid2json(tid)));
  param.insert(std::make_pair("target_nid", Convert::nid2json(target_nid)));
  send_command(pid, SpecialNID::THIS, Module::VM, "require_warp_thread", param);
}

/**
 * Send warp thread command to VM module.
 * @param pid Target process-id to warp.
 * @param tid Target thread-id to warp.
 */
void Scheduler::send_command_warp_thread(const vpid_t& pid, vtid_t tid) {
  picojson::object param;
  param.insert(std::make_pair("tid", Convert::vtid2json(tid)));
  send_command(pid, SpecialNID::THIS, Module::VM, "warp_thread", param);
}
}  // namespace processwarp
