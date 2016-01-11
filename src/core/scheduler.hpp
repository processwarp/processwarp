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
  virtual void scheduler_send_command(Scheduler& scheduler, const CommandPacket& packet) = 0;
};

class Scheduler {
 public:
  Scheduler();
  void initialize(SchedulerDelegate& delegate_);
  nid_t get_dst_nid(const vpid_t& pid, Module::Type module);
  void recv_command(const CommandPacket& packet);
  void set_my_nid(const nid_t& nid);

  void activate();

 private:
  /** Node-id of this node. */
  nid_t my_nid;
  /** Pointer for delegater instance.  */
  SchedulerDelegate* delegate;
  /** A list of processes these are running in all of nodes used by the same account. */
  std::map<vpid_t, ProcessTree> processes;

  void send_command(const vpid_t& pid, const nid_t& dst_nid, Module::Type module,
                    const std::string& command, picojson::object& param);
  void recv_command_activate(const CommandPacket& packet);
  void recv_command_create_gui(const CommandPacket& packet);
  void recv_command_create_gui_done(const CommandPacket& packet);
  void recv_command_update_gui_node(const CommandPacket& packet);
  void recv_command_update_process_list(const CommandPacket& packet);
  void recv_command_update_threads(const CommandPacket& packet);
  void recv_command_warp_gui(const CommandPacket& packet);
  void recv_command_warp_thread(const CommandPacket& packet);
  void send_command_show_process_list();
  void send_command_update_process_list();
};
}  // namespace processwarp
