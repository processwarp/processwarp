#pragma once

#include <picojson.h>

#include <map>
#include <string>

#include "definitions.hpp"

namespace processwarp {
class Scheduler;

class SchedulerDelegate {
 public:
  virtual ~SchedulerDelegate();
  virtual void scheduler_create_vm(Scheduler& scheduler, const vpid_t& pid, vtid_t root_tid,
                                   vaddr_t proc_addr, const nid_t& master_nid) = 0;
  virtual void scheduler_create_gui(Scheduler& scheduler, const vpid_t& pid) = 0;
  virtual void scheduler_send_command(Scheduler& scheduler, const vpid_t& pid,
                                      InnerModule::Type module,
                                      const picojson::object& content) = 0;
  virtual void scheduler_send_inner_module_packet(Scheduler& scheduler, const vpid_t& pid,
                                                  const nid_t& dst_nid, InnerModule::Type module,
                                                  const std::string& content) = 0;
  virtual void scheduler_send_outer_module_packet(Scheduler& scheduler, const vpid_t& pid,
                                                  const nid_t& dst_nid, OuterModule::Type module,
                                                  const std::string& content) = 0;
};

class Scheduler {
 public:
  Scheduler();
  void initialize(SchedulerDelegate& delegate_);
  nid_t get_dst_nid(const vpid_t& pid, OuterModule::Type module);
  void recv_command(const vpid_t& pid, const picojson::object& content);
  void recv_packet(const vpid_t& pid, const std::string& content);
  void set_my_nid(const nid_t& nid);

  void activate();

 private:
  /** Node-id of this node. */
  nid_t my_nid;
  /** Pointer for delegater instance.  */
  SchedulerDelegate* delegate;
  /** A list of processes these are running in all of nodes used by the same account. */
  std::map<vpid_t, ProcessTree> processes;

  void recv_command_activate(const vpid_t& pid, const picojson::object& param);
  void recv_command_create_gui(const vpid_t& pid, const picojson::object& param);
  void recv_command_create_gui_done(const vpid_t& pid, const picojson::object& param);
  void recv_packet_activate(const vpid_t& pid, const picojson::object& param);
  void recv_packet_process_list(const vpid_t& pid, const picojson::object& param);
  void recv_packet_update_gui_node(const vpid_t& pid, const picojson::object& param);
  void recv_packet_warp(const vpid_t& pid, const picojson::object& param);
  void recv_packet_warp_gui(const vpid_t& pid, const picojson::object& param);
  void send_command(const vpid_t& pid, InnerModule::Type module,
                    const std::string& command, picojson::object& param);
  void send_packet(const vpid_t& pid, const nid_t& dst_nid,
                   const std::string& command, picojson::object& param);
  void send_packet_process_list();
  void send_process_list();
};
}  // namespace processwarp
