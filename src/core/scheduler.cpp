
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
    case Module::FRONTEND: {
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

  } else if (command == "create_gui_done") {
    recv_command_create_gui_done(packet);

  } else if (command == "update_gui_node") {
    recv_command_update_gui_node(packet);

  } else if (command == "update_process_list") {
    recv_command_update_process_list(packet);

  } else if (command == "warp_thread") {
    recv_command_warp_thread(packet);

  } else if (command == "warp_gui") {
    recv_command_warp_gui(packet);

  } else {
    /// @todo error
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
 * It tell this node was activated by user or any event.
 * Send activate command to another node.
 */
void Scheduler::activate() {
  assert(my_nid != SpecialNID::NONE);

  picojson::object param;
  param.insert(std::make_pair("nid", Convert::nid2json(my_nid)));
  send_command(SpecialPID::BROADCAST, SpecialNID::BROADCAST, Module::SCHEDULER, "activate", param);
}

/**
 * When receive activate command from this node, decode parameter and call activate method.
 * When receive activate command from another node, listup process and frontend that have to warp active node and
 * call warp method to do it.
 * @param packet Command packet.
 */
void Scheduler::recv_command_activate(const CommandPacket& packet) {
  assert(packet.pid == SpecialPID::BROADCAST);

  if (packet.src_nid == my_nid) {
    activate();

  } else {
    const nid_t& active_nid = Convert::json2nid(packet.content.at("nid"));

    for (auto& it : processes) {
      ProcessTree& info = it.second;

      if (info.gui_nid == my_nid) {
        picojson::object param;
        send_command(info.pid, active_nid, Module::SCHEDULER, "warp_gui", param);
      }
    }
  }
}

/**
 * When receive create_gui command, call create_gui on frontend.
 * @param packet Command packet.
 */
void Scheduler::recv_command_create_gui(const CommandPacket& packet) {
  assert(packet.pid != SpecialPID::BROADCAST);

  if (packet.src_nid != my_nid) {
    /// @todo error
    assert(false);
  }

  auto it_info = processes.find(packet.pid);
  if (it_info == processes.end() ||
      it_info->second.gui_nid != SpecialNID::NONE) {
    /// @todo error
    assert(false);
  }

  it_info->second.gui_nid = my_nid;
  delegate->scheduler_create_gui(*this, packet.pid);
}

/**
 * When receive create_gui_done command from frontend, update destination node-id for GUI
 * and emit it to another nodes.
 * @param packet Command packet.
 */
void Scheduler::recv_command_create_gui_done(const CommandPacket& packet) {
  auto it_info = processes.find(packet.pid);

  assert(packet.pid != SpecialPID::BROADCAST);

  if (packet.src_nid != my_nid ||
      it_info == processes.end()) {
    /// @todo error
    assert(false);
  }

  it_info->second.gui_nid = my_nid;

  picojson::object param;
  param.insert(std::make_pair("nid", Convert::nid2json(my_nid)));
  send_command(packet.pid, SpecialNID::BROADCAST, Module::SCHEDULER, "update_gui_node", param);
}

/**
 * When receive update_gui_node packet, update GUI node-id for passing frontend command.
 * @param packet Command packet.
 */
void Scheduler::recv_command_update_gui_node(const CommandPacket& packet) {
  auto it_info = processes.find(packet.pid);
  const nid_t& nid = Convert::json2nid(packet.content.at("nid"));

  if (nid == my_nid) return;
  if (it_info == processes.end()) return;

  ProcessTree& info = it_info->second;
  if (info.gui_nid == my_nid) {
    picojson::object param;
    param.insert(std::make_pair("nid", Convert::nid2json(nid)));
    send_command(packet.pid, my_nid, Module::FRONTEND, "warpin", param);
  }
  info.gui_nid = nid;
}

/**
 * When receive process_list packet, update local processes list and
 * send the same format packet to another node if list was changed.
 * @param packet Command packet.
 */
void Scheduler::recv_command_update_process_list(const CommandPacket& packet) {
  bool is_changed = false;
  bool is_need_update = false;

  for (auto& it_proc : packet.content.at("procs").get<picojson::array>()) {
    const picojson::object& proc = it_proc.get<picojson::object>();
    const vpid_t& pid = Convert::json2vpid(proc.at("pid"));

    if (processes.find(pid) == processes.end()) {
      // If process was not saved in local list, create new information.
      ProcessTree info;

      info.pid = pid;
      info.name = proc.at("name").get<std::string>();
      for (auto& it_thread : proc.at("threads").get<picojson::array>()) {
        info.threads.insert(std::make_pair(Convert::json2vtid(it_thread),
                                           packet.src_nid));
      }
      info.gui_nid = Convert::json2nid(proc.at("gui"));
      info.having_vm = false;

      processes.insert(std::make_pair(pid, info));
      is_changed = true;

    } else {
      // If process was exist in local list yet, compair threads and update for relate threads.
      ProcessTree& info = processes.at(pid);
      std::set<vtid_t> tids;

      for (auto& it_thread : proc.at("threads").get<picojson::array>()) {
        vtid_t tid = Convert::json2vtid(it_thread);
        auto thread_pair = info.threads.find(tid);

        tids.insert(tid);
        if (thread_pair == info.threads.end()) {
          info.threads.insert(std::make_pair(tid, packet.src_nid));
          is_changed = true;

        } else if (thread_pair->second == my_nid) {
          /// @todo maybe warpout
          info.threads.at(tid) = packet.src_nid;
          is_changed = true;
          is_need_update = true;

        } else if (thread_pair->second != packet.src_nid) {
          info.threads.at(tid) = packet.src_nid;
          is_changed = true;
        }
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
    }
  }

  // Remove process if no one threads are rest.
  auto it_proc = processes.begin();
  while (it_proc != processes.end()) {
    if (it_proc->second.threads.size() == 0) {
      it_proc = processes.erase(it_proc);
      is_changed = true;

    } else {
      it_proc++;
    }
  }

  // Tell event to another node and module if need.
  if (is_changed) send_command_show_process_list();
  if (is_need_update) send_command_update_process_list();
}

/**
 * When receive warp_gui packet, create gui in this node.
 * @param packet Command packet.
 */
void Scheduler::recv_command_warp_gui(const CommandPacket& packet) {
  delegate->scheduler_create_gui(*this, packet.pid);
}

/**
 * When recv warp_thread command, create new vm if not existed in this node and call warpout command,
 * and update process information this node having.
 * @param packet Command packet.
 */
void Scheduler::recv_command_warp_thread(const CommandPacket& packet) {
  auto it_info = processes.find(packet.pid);
  if (it_info == processes.end() ||
      !it_info->second.having_vm) {
    delegate->scheduler_create_vm(*this, packet.pid,
                                  Convert::json2vtid(packet.content.at("root_tid")),
                                  Convert::json2vaddr(packet.content.at("proc_addr")),
                                  Convert::json2nid(packet.content.at("master_nid")));
  }

  picojson::object param;
  param.insert(std::make_pair("tid", packet.content.at("tid")));
  send_command(packet.pid, my_nid, Module::VM, "warpout", param);

  vtid_t tid = Convert::json2vtid(packet.content.at("tid"));
  if (it_info == processes.end()) {
    ProcessTree info;

    info.pid = packet.pid;
    info.name = packet.content.at("name").get<std::string>();
    info.threads.insert(std::make_pair(tid, my_nid));
    info.gui_nid = SpecialNID::NONE;
    info.having_vm = true;

    processes.insert(std::make_pair(packet.pid, info));

  } else {
    ProcessTree& info = it_info->second;

    info.having_vm = true;
    if (info.threads.find(tid) == info.threads.end()) {
      info.threads.insert(std::make_pair(tid, my_nid));

    } else {
      info.threads.at(tid) = my_nid;
    }
  }

  send_command_update_process_list();
  send_command_show_process_list();
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
 * Listup process information and send process_list command to frontend.
 */
void Scheduler::send_command_show_process_list() {
  picojson::array procs;
  for (auto& it_process : processes) {
    ProcessTree& info = it_process.second;

    picojson::object threads;
    for (auto& it_thread : info.threads) {
      threads.insert(std::make_pair(Convert::vtid2str(it_thread.first),
                                    Convert::nid2json(it_thread.second)));
    }

    picojson::object proc;
    proc.insert(std::make_pair("pid", Convert::vpid2json(info.pid)));
    proc.insert(std::make_pair("name", picojson::value(info.name)));
    proc.insert(std::make_pair("threads", picojson::value(threads)));

    procs.push_back(picojson::value(proc));
  }

  picojson::object param;
  param.insert(std::make_pair("processes", picojson::value(procs)));

  send_command(SpecialPID::BROADCAST, my_nid, Module::FRONTEND, "show_process_list", param);
}

/**
 * Listup process information and send process_list packet to another node.
 */
void Scheduler::send_command_update_process_list() {
  picojson::array procs;
  for (auto& it_process : processes) {
    ProcessTree& info = it_process.second;

    picojson::array threads;
    for (auto& it_thread : info.threads) {
      if (it_thread.second == my_nid) {
        threads.push_back(Convert::vtid2json(it_thread.first));
      }
    }
    if (threads.size() == 0) {
      continue;
    }

    picojson::object proc;
    proc.insert(std::make_pair("pid", Convert::vpid2json(info.pid)));
    proc.insert(std::make_pair("name", picojson::value(info.name)));
    proc.insert(std::make_pair("gui", Convert::nid2json(info.gui_nid)));
    proc.insert(std::make_pair("threads", picojson::value(threads)));

    procs.push_back(picojson::value(proc));
  }

  picojson::object param;
  param.insert(std::make_pair("nid", Convert::nid2json(my_nid)));
  param.insert(std::make_pair("procs", picojson::value(procs)));

  send_command(SpecialPID::BROADCAST, SpecialNID::BROADCAST, Module::SCHEDULER,
               "update_process_list", param);
}
}  // namespace processwarp
