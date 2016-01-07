
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
 * Get destination node-id for packet when source module didn't know it.
 * @param pid Process-id packet is bundled.
 * @param module Target module.
 */
nid_t Scheduler::get_dst_nid(const vpid_t& pid, OuterModule::Type module) {
  switch (module) {
    case OuterModule::FRONTEND: {
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
 * When receive command from other module in this node, read command and call capable method with parameter.
 * @param pid Process-id command is bundled.
 * @param content A JSON that contain a command string adn any parameter.
 */
void Scheduler::recv_command(const vpid_t& pid, const picojson::object& content) {
  const std::string& command = content.at("command").get<std::string>();

  if (command == "activate") {
    recv_command_activate(pid, content);

  } else if (command == "create_gui") {
    recv_command_create_gui(pid, content);

  } else if (command == "create_gui_done") {
    recv_command_create_gui_done(pid, content);

  } else {
    /// @todo error
    assert(false);
  }
}

/**
 * When receive packet from scheduler in other node, read command and call capable method with parameter.
 * @param pid Process-id packet is bundled.
 * @param content A string that contain a command string and any parameter JSON formated.
 */
void Scheduler::recv_packet(const vpid_t& pid, const std::string& content) {
  picojson::value v;
  std::istringstream is(content);
  std::string err = picojson::parse(v, is);

  if (!err.empty()) {
    /// @todo error
    assert(false);
  }

  picojson::object& content_js = v.get<picojson::object>();
  std::string& command = content_js.at("command").get<std::string>();

  if (command == "activate") {
    recv_packet_activate(pid, content_js);

  } else if (command == "process_list") {
    recv_packet_process_list(pid, content_js);

  } else if (command == "update_gui_node") {
    recv_packet_update_gui_node(pid, content_js);

  } else if (command == "warp") {
    recv_packet_warp(pid, content_js);

  } else if (command == "warp_gui") {
    recv_packet_warp_gui(pid, content_js);

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
 * It tell scheduler this node was actived by user or any event.
 */
void Scheduler::activate() {
  picojson::object packet;
  packet.insert(std::make_pair("nid", Convert::nid2json(my_nid)));
  send_packet(SpecialPID::BROADCAST, SpecialNID::BROADCAST, "activate", packet);
}

/**
 * When receive activate command, decode parameter and call activate method.
 * @param pid Not used.
 * @param param Not used.
 */
void Scheduler::recv_command_activate(const vpid_t& pid, const picojson::object& param) {
  if (pid != SpecialPID::BROADCAST) {
    /// @todo error
    assert(false);
  }

  activate();
}

/**
 * When receive create_gui command, call create_gui on frontend through the frontend.
 * @param pid Process-id to create GUI.
 * @param param Not used.
 */
void Scheduler::recv_command_create_gui(const vpid_t& pid, const picojson::object& param) {
  assert(my_nid != SpecialNID::NONE);

  if (pid == SpecialPID::BROADCAST) {
    /// @todo error
    assert(false);
  }

  auto it_info = processes.find(pid);
  if (it_info == processes.end() ||
      it_info->second.gui_nid != SpecialNID::NONE) {
    /// @todo error
    assert(false);
  }

  it_info->second.gui_nid = my_nid;
  delegate->scheduler_create_gui(*this, pid);
}

/**
 * When receive create_gui_done command from frontend, update destination node-id for GUI and
 * Tell it to another nodes.
 * @param pid Process-id bundled for GUI.
 * @param param Not used.
 */
void Scheduler::recv_command_create_gui_done(const vpid_t& pid, const picojson::object& param) {
  auto process_tree = processes.find(pid);
  picojson::object packet_param;

  assert(my_nid != SpecialNID::NONE);
  assert(pid != SpecialPID::BROADCAST);
  assert(process_tree != processes.end());

  process_tree->second.gui_nid = my_nid;

  packet_param.insert(std::make_pair("nid", Convert::nid2json(my_nid)));
  send_packet(pid, SpecialNID::BROADCAST, "update_gui_node", packet_param);
}

/**
 * When receive activate packet, listup process and gui that have to warp active node and
 * call warp method to do it.
 * @param pid Process-id must BROADCAST.
 * @param param Parameters for activate command, containing active node-id.
 */
void Scheduler::recv_packet_activate(const vpid_t& pid, const picojson::object& param) {
  const nid_t& active_nid = Convert::json2nid(param.at("nid"));

  assert(my_nid != SpecialNID::NONE);

  if (pid != SpecialPID::BROADCAST) {
    /// @todo error
    assert(false);
  }

  for (auto& it : processes) {
    ProcessTree& info = it.second;

    if (info.gui_nid == my_nid) {
      picojson::object packet_param;
      send_packet(info.pid, active_nid, "warp_gui", packet_param);
    }
  }
}

/**
 * When receive process_list packet, update local processes list and
 * send the same format packet to another node if list was changed.
 * @param pid Process-id must BROADCAST.
 * @param param Parameter containing pid, name, and array of threads source node having.
 */
void Scheduler::recv_packet_process_list(const vpid_t& pid, const picojson::object& param) {
  const nid_t& nid = Convert::json2nid(param.at("nid"));
  bool is_changed = false;
  bool is_need_update = false;

  assert(my_nid != SpecialNID::NONE);

  for (auto& it_proc : param.at("procs").get<picojson::array>()) {
    const picojson::object& proc = it_proc.get<picojson::object>();
    const vpid_t& pid = Convert::json2vpid(proc.at("pid"));

    if (processes.find(pid) == processes.end()) {
      // If process was not saved in local list, create new information.
      ProcessTree info;

      info.pid = pid;
      info.name = proc.at("name").get<std::string>();
      for (auto& it_thread : proc.at("threads").get<picojson::array>()) {
        info.threads.insert(std::make_pair(Convert::json2vtid(it_thread),
                                           nid));
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
          info.threads.insert(std::make_pair(tid, nid));
          is_changed = true;

        } else if (thread_pair->second == my_nid) {
          /// @todo maybe warpout
          info.threads.at(tid) = nid;
          is_changed = true;
          is_need_update = true;

        } else if (thread_pair->second != nid) {
          info.threads.at(tid) = nid;
          is_changed = true;
        }
      }

      // Remove thread-id from list if it had run in source node but not run at now.
      auto it_thread = info.threads.begin();
      while (it_thread != info.threads.end()) {
        if (it_thread->second == nid &&
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
  if (is_changed) send_process_list();
  if (is_need_update) send_packet_process_list();
}

/**
 * When receive update_gui_node packet, update GUI node-id to pass frontend packet.
 * @param pid Process-id bundled for packet.
 * @param param Parameter containing node-id to change property.
 */
void Scheduler::recv_packet_update_gui_node(const vpid_t& pid, const picojson::object& param) {
  const nid_t& active_nid = Convert::json2nid(param.at("nid"));

  assert(my_nid != SpecialNID::NONE);

  if (active_nid == my_nid) return;

  auto it = processes.find(pid);
  if (it == processes.end()) return;

  ProcessTree& info = it->second;
  if (info.gui_nid == my_nid) {
    picojson::object content;
    content.insert(std::make_pair("command", picojson::value(std::string("warpin"))));
    content.insert(std::make_pair("nid", Convert::nid2json(active_nid)));
    delegate->scheduler_send_outer_module_packet(*this, pid, my_nid, OuterModule::FRONTEND,
                                                 picojson::value(content).serialize());
  }
  info.gui_nid = active_nid;
}

/**
 * When recv warp packet, create new vm if not existed in this node and call warpout command,
 * and update process information this node having.
 * @param pid Process-id bundled.
 * @param param Parameters for warp command and create new vm.
 */
void Scheduler::recv_packet_warp(const vpid_t& pid, const picojson::object& param) {
  assert(my_nid != SpecialNID::NONE);

  auto it = processes.find(pid);
  if (it == processes.end() ||
      !it->second.having_vm) {
    delegate->scheduler_create_vm(*this, pid,
                                  Convert::json2vtid(param.at("root_tid")),
                                  Convert::json2vaddr(param.at("proc_addr")),
                                  Convert::json2nid(param.at("master_nid")));
  }

  picojson::object param_warpout;
  vtid_t tid = Convert::json2vtid(param.at("tid"));
  param_warpout.insert(std::make_pair("tid", param.at("tid")));
  send_command(pid, InnerModule::VM, "warpout", param_warpout);

  if (it == processes.end()) {
    ProcessTree info;

    info.pid = pid;
    info.name = param.at("name").get<std::string>();
    info.threads.insert(std::make_pair(tid, my_nid));
    info.gui_nid = SpecialNID::NONE;
    info.having_vm = true;

    processes.insert(std::make_pair(pid, info));

  } else {
    ProcessTree& info = it->second;

    info.having_vm = true;
    if (info.threads.find(tid) == info.threads.end()) {
      info.threads.insert(std::make_pair(tid, my_nid));

    } else {
      info.threads.at(tid) = my_nid;
    }
  }
  send_packet_process_list();
  send_process_list();
}

/**
 * When receive warp_gui packet, create gui in this node.
 * @param pid Process-id bundled to packet.
 * @param param Not used.
 */
void Scheduler::recv_packet_warp_gui(const vpid_t& pid, const picojson::object& param) {
  delegate->scheduler_create_gui(*this, pid);
}

/**
 * Pass command to delegate to send command to other module in the same node.
 * @param pid Process-id bundle to command.
 * @param module Target module.
 * @param command Command string.
 * @param param Parameter for command JSON fromatted.
 */
void Scheduler::send_command(const vpid_t& pid, InnerModule::Type module,
                             const std::string& command, picojson::object& param) {
  assert(param.find("command") == param.end());

  param.insert(std::make_pair("command", picojson::value(command)));
  delegate->scheduler_send_command(*this, pid, module, param);
}

/**
 * Convert packet string with JSON fomat parameter to string format, and pass delegate to
 * send packet to other node.
 * @param pid Process-id bindle to packet.
 * @param dst_nid Destination node-id.
 * @param command Command string.
 * @param param Parameter JSON formatted.
 */
void Scheduler::send_packet(const vpid_t& pid, const nid_t& dst_nid,
                            const std::string& command, picojson::object& param) {
  assert(param.find("command") == param.end());

  param.insert(std::make_pair("command", picojson::value(command)));
  delegate->scheduler_send_inner_module_packet(*this, pid, dst_nid, InnerModule::SCHEDULER,
                                               picojson::value(param).serialize());
}

/**
 * Listup process information and send process_list packet to another node.
 */
void Scheduler::send_packet_process_list() {
  assert(my_nid != SpecialNID::NONE);

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

  send_packet(SpecialPID::BROADCAST, SpecialNID::BROADCAST, "process_list", param);
}

/**
 * Listup process information and send process_list command to frontend.
 */
void Scheduler::send_process_list() {
  assert(my_nid != SpecialNID::NONE);

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

  picojson::object content;
  content.insert(std::make_pair("command", picojson::value(std::string("process_list"))));
  content.insert(std::make_pair("processes", picojson::value(procs)));

  delegate->scheduler_send_outer_module_packet(*this, SpecialPID::BROADCAST, my_nid,
                                               OuterModule::FRONTEND,
                                               picojson::value(content).serialize());
}
}  // namespace processwarp
