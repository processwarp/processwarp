
#include <picojson.h>

#include <cassert>
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
 * Initialize scheduler.
 * Save delegater.
 * @param delegate_ Delegater instance for scheduler.
 */
void Scheduler::initialize(SchedulerDelegate& delegate_) {
  delegate = &delegate_;
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

  if (command == "warp") {
    recv_packet_warp(pid, content_js);

  } else if (command == "activate") {
    recv_packet_activate(pid, content_js);

  } else {
    /// @todo error
    assert(false);
  }
}

/**
 * It tell scheduler this node was actived by user or any event.
 */
void Scheduler::activate() {
  picojson::object packet;
  packet.insert(std::make_pair("nid",
                               Convert::vpid2json(delegate->scheduler_get_my_nid(*this))));
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
  if (pid == SpecialPID::BROADCAST) {
    /// @todo error
    assert(false);
  }

  auto process_tree = processes.find(pid);
  if (process_tree == processes.end() ||
      process_tree->second.gui_nid != SpecialNID::NONE) {
    /// @todo error
    assert(false);
  }

  process_tree->second.gui_nid = delegate->scheduler_get_my_nid(*this);
  delegate->scheduler_create_gui(*this, pid);
}

/**
 * When receive activate packet, listup process and gui that have to warp active node and
 * call warp method to do it.
 * @param pid Process-id must BROADCAST.
 * @param param Parameters for activate command, containing active node-id.
 */
void Scheduler::recv_packet_activate(const vpid_t& pid, const picojson::object& param) {
  nid_t nid = Convert::json2nid(param.at("nid"));

  if (pid != SpecialPID::BROADCAST) {
    /// @todo error
    assert(false);
  }

  if (nid == delegate->scheduler_get_my_nid(*this)) return;
  /// @todo
  assert(false);
}

/**
 * When recv warp packet, create new vm if not existed in this node and call warpout command.
 * @param pid Process-id bundled.
 * @param param Parameters for warp command and create new vm.
 */
void Scheduler::recv_packet_warp(const vpid_t& pid, const picojson::object& param) {
  auto process_tree = processes.find(pid);
  if (process_tree == processes.end() ||
      !process_tree->second.having_vm) {
    delegate->scheduler_create_vm(*this, pid,
                                  Convert::json2vtid(param.at("root_tid")),
                                  Convert::json2vaddr(param.at("proc_addr")),
                                  Convert::json2nid(param.at("master_nid")));
  }

  picojson::object param_warpout;
  param_warpout.insert(std::make_pair("tid", param.at("tid")));
  send_command(pid, InnerModule::VM, "warpout", param_warpout);

  if (process_tree == processes.end()) {
    ProcessTree info;

    info.pid = pid;
    info.name = param.at("name").get<std::string>();
    info.threads.insert(std::make_pair(Convert::json2vtid(param.at("tid")),
                                       delegate->scheduler_get_my_nid(*this)));
    info.gui_nid = SpecialNID::NONE;
    info.having_vm = true;

    processes.insert(std::make_pair(pid, info));

  } else {
    process_tree->second.having_vm = true;
  }
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
}  // namespace processwarp
