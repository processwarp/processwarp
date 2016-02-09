
#include <picojson.h>

#include <cassert>
#include <set>
#include <string>

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
Scheduler::Scheduler() :
    my_nid(SpecialNID::NONE) {
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
  assert(my_nid != SpecialNID::NONE);

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
  assert(my_nid != SpecialNID::NONE);

  const std::string& command = packet.content.at("command").get<std::string>();
  if (command == "activate") {
    recv_command_activate(packet);

  } else if (command == "create_gui") {
    recv_command_create_gui(packet);

  } else if (command == "heartbeat_gui") {
    recv_command_heartbeat_gui(packet);

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
 * Set node-id of this node.
 * Nid must not NONE.
 * @param nid Node-id of this node.
 */
void Scheduler::set_my_nid(const nid_t& nid) {
  assert(nid != SpecialNID::NONE);

  my_nid = nid;
}

/**
 * When receive activate command, listup process and frontend that have to warp active node.
 * Ignode command if receive activate command from this node.
 * call warp method to do it.
 * @param packet Command packet.
 */
void Scheduler::recv_command_activate(const CommandPacket& packet) {
  assert(packet.pid == SpecialPID::BROADCAST);

  if (packet.src_nid == my_nid) return;

  for (auto& it_info : processes) {
    ProcessInfo& info = it_info.second;

    for (auto& it_thread : info.threads) {
      if (it_thread.second.first == my_nid) {
        send_command_require_warp_thread(info.pid, it_thread.first, packet.src_nid);
      }
    }

    if (info.gui_nid == my_nid) {
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

  if (packet.src_nid != my_nid) {
    /// @todo error
    assert(false);
  }

  auto it_info = processes.find(packet.pid);
  if (it_info == processes.end()) {
    ProcessInfo info;

    info.pid = packet.pid;
    info.gui_nid = my_nid;
    info.having_vm = false;
    processes.insert(std::make_pair(info.pid, info));

  } else {
    it_info->second.gui_nid = my_nid;
  }

  delegate->scheduler_create_gui(*this, packet.pid);
}

/**
 * When receive heartbeat_gui command, update destination node-id for GUI
 * @param packet Command packet.
 */
void Scheduler::recv_command_heartbeat_gui(const CommandPacket& packet) {
  assert(packet.pid != SpecialPID::BROADCAST);

  auto it_info = processes.find(packet.pid);

  if (it_info == processes.end()) {
    ProcessInfo info;
    info.pid = packet.pid;
    info.gui_nid = packet.src_nid;
    info.having_vm = false;
    processes.insert(std::make_pair(packet.pid, info));

  } else {
    it_info->second.gui_nid = packet.src_nid;
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
  clock_t now = clock();

  if (processes.find(packet.pid) == processes.end()) {
    ProcessInfo info;
    info.pid = packet.pid;
    info.gui_nid = SpecialNID::NONE;
    info.having_vm = false;
    processes.insert(std::make_pair(packet.pid, info));
  }

  ProcessInfo& info = processes.at(packet.pid);
  std::set<vtid_t> tids;

  if (packet.src_nid == my_nid) info.having_vm = true;
  info.name = packet.content.at("name").get<std::string>();
  info.heartbeat = now;

  // Compair threads and update for relate threads.
  for (auto& it_thread : packet.content.at("threads").get<picojson::array>()) {
    vtid_t tid = Convert::json2vtid(it_thread);
    auto thread_pair = info.threads.find(tid);

    if (thread_pair == info.threads.end()) {
      info.threads.insert(std::make_pair(tid, std::make_pair(packet.src_nid, now)));
      is_changed = true;

    } else if (thread_pair->second.first != packet.src_nid) {
      info.threads.at(tid) = std::make_pair(packet.src_nid, now);
      is_changed = true;

    } else {
      info.threads.at(tid).second = now;
    }

    tids.insert(tid);
  }

  // Remove thread-id from list if it had run in source node but not run at now.
  auto it_thread = info.threads.begin();
  while (it_thread != info.threads.end()) {
    if (it_thread->second.first == packet.src_nid &&
        tids.find(it_thread->first) == tids.end()) {
      it_thread->second.first = SpecialNID::NONE;
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
  if (it_info == processes.end()) {
    ProcessInfo info;
    info.pid = packet.pid;
    info.gui_nid = my_nid;
    info.having_vm = false;
    processes.insert(std::make_pair(packet.pid, info));

  } else {
    it_info->second.gui_nid = my_nid;
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
  clock_t now = clock();
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
  delegate->scheduler_send_command(*this, {pid, dst_nid, my_nid, module, param});
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
      threads.insert(std::make_pair(Convert::vtid2str(it_thread.first),
                                    Convert::nid2json(it_thread.second.first)));
    }

    picojson::object proc;
    proc.insert(std::make_pair("pid", Convert::vpid2json(info.pid)));
    proc.insert(std::make_pair("name", picojson::value(info.name)));
    proc.insert(std::make_pair("threads", picojson::value(threads)));

    procs.push_back(picojson::value(proc));
  }

  picojson::object param;
  param.insert(std::make_pair("processes", picojson::value(procs)));

  send_command(SpecialPID::BROADCAST, my_nid, Module::CONTROLLER, "processes_info", param);
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
