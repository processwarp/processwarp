
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
 * It tell scheduler this node was actived by user or any event.
 */
void Scheduler::activate() {
  picojson::object p;
  p.insert(std::make_pair("nid",
                          Convert::vpid2json(delegate->scheduler_get_my_nid(*this))));
  send_packet(SpecialPID::BROADCAST, SpecialNID::BROADCAST, "activate", p);
}

/**
 * When recv packet from scheduler on other node, read sub-command and call capable method with parameter.
 * @param pid Process-id packet is bundled.
 * @param packet A packet data that must contain json formated command and parameter.
 */
void Scheduler::on_recv_packet(const vpid_t& pid, const std::string& packet) {
  picojson::value v;
  std::istringstream is(packet);
  std::string err = picojson::parse(v, is);

  if (!err.empty()) {
    /// @todo error
    assert(false);
  }

  picojson::object& js_packet = v.get<picojson::object>();
  std::string& command = js_packet.at("command").get<std::string>();

  if (command == "warp") {
    recv_warp(pid, js_packet);

  } else if (command == "activate") {
    recv_activate(js_packet);

  } else {
    /// @todo error
    assert(false);
  }
}

/**
 * When receive activate command, listup process and gui that have to warp active node and
 * call warp method to do it.
 * @param packet Parameters for activate command, containing active node-id.
 */
void Scheduler::recv_activate(const picojson::object& packet) {
  nid_t nid = Convert::json2nid(packet.at("nid"));
  if (nid == delegate->scheduler_get_my_nid(*this)) return;
  /// @todo
  assert(false);
}

/**
 * When recv warp command, create new vm if not existed in this node and call warpout command.
 * @param pid Process-id bundled.
 * @param packet Parameters for warp command.
 */
void Scheduler::recv_warp(const vpid_t& pid, const picojson::object& packet) {
  if (!delegate->scheduler_have_process(*this, pid)) {
    delegate->scheduler_create_vm(*this, pid,
                                  Convert::json2vtid(packet.at("root_tid")),
                                  Convert::json2vaddr(packet.at("proc_addr")),
                                  Convert::json2nid(packet.at("master_nid")));
  }

  picojson::object command;
  command.insert(std::make_pair("tid", packet.at("tid")));
  delegate->scheduler_vm_command(*this, pid, "warpout", command);

  if (processes.find(pid) == processes.end()) {
    ProcessTree info;

    info.pid = pid;
    info.name = packet.at("name").get<std::string>();
    info.threads.insert(std::make_pair(Convert::json2vtid(packet.at("tid")),
                                       delegate->scheduler_get_my_nid(*this)));
    processes.insert(std::make_pair(pid, info));
  }
}

/**
 * Convert command string and JSON fomat parameter to string format and pass delegate to
 * send packet.
 * @param pid Process-id bindle to packet.
 * @param dest_nid Destination node-id.
 * @param command Command string.
 * @param packet Parameter JSON formatted.
 */
void Scheduler::send_packet(const vpid_t& pid, const nid_t& dst_nid,
                            const std::string& command, picojson::object& packet) {
  packet.insert(std::make_pair("command", picojson::value(command)));
  delegate->scheduler_send_packet(*this, pid, dst_nid, picojson::value(packet).serialize());
}
}  // namespace processwarp
