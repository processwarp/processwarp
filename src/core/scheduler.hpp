#pragma once

#include <picojson.h>

#include <map>
#include <random>
#include <string>

#include "definitions.hpp"

namespace processwarp {
class Scheduler;

class SchedulerDelegate {
 public:
  virtual ~SchedulerDelegate();
  virtual void scheduler_create_vm(Scheduler& scheduler, const vpid_t& pid, vtid_t root_tid,
                                   vaddr_t proc_addr, const nid_t& master_nid,
                                   const std::string& name) = 0;
  virtual void scheduler_create_gui(Scheduler& scheduler, const vpid_t& pid) = 0;
  virtual void scheduler_send_command(Scheduler& scheduler, const CommandPacket& packet) = 0;
};

class Scheduler {
 public:
  Scheduler();
  void initialize(SchedulerDelegate& delegate_);
  nid_t get_dst_nid(const vpid_t& pid, Module::Type module);
  vpid_t get_new_pid();
  void recv_command(const CommandPacket& packet);
  void set_node_information(const nid_t& nid, const std::string& name);
  void execute();

 private:
  /** Node information for this node. */
  NodeInfo my_info;
  /** Pointer for delegater instance.  */
  SchedulerDelegate* delegate;
  /** A list of processes these are running in all of nodes used by the same account. */
  std::map<vpid_t, ProcessInfo> processes;
  /** All node information as far as I can connect. */
  std::map<nid_t, NodeInfo> nodes;
  /** Random value generator. */
  std::mt19937_64 rnd;

  void cleanup_unresponsive_node();
  void cleanup_unresponsive_process();

  void recv_command_activate(const CommandPacket& packet);
  void recv_command_create_gui(const CommandPacket& packet);
  void recv_command_distribute(const CommandPacket& packet);
  void recv_command_heartbeat_gui(const CommandPacket& packet);
  void recv_command_heartbeat_scheduler(const CommandPacket& packet);
  void recv_command_heartbeat_vm(const CommandPacket& packet);
  void recv_command_require_processes_info(const CommandPacket& packet);
  void recv_command_warp_gui(const CommandPacket& packet);
  void recv_command_warp_thread(const CommandPacket& packet);

  void send_command(const vpid_t& pid, const nid_t& dst_nid, Module::Type module,
                    const std::string& command, picojson::object& param);
  void send_command_heartbeat_scheduler();
  void send_command_processes_info();
  void send_command_require_warp_gui(const vpid_t& pid, const nid_t& target_nid);
  void send_command_require_warp_thread(const vpid_t& pid, vtid_t tid, const nid_t& target_nid);
  void send_command_warp_thread(const vpid_t& pid, vtid_t tid);
};
}  // namespace processwarp
