#pragma once

#include <picojson.h>

#include <map>
#include <random>
#include <string>

#include "packet.hpp"
#include "type.hpp"

namespace processwarp {
class Scheduler;

class SchedulerDelegate {
 public:
  virtual ~SchedulerDelegate();
  virtual void scheduler_create_vm(Scheduler& scheduler, const vpid_t& pid, vtid_t root_tid,
                                   vaddr_t proc_addr, const NodeID& master_nid,
                                   const std::string& name) = 0;
  virtual void scheduler_create_gui(Scheduler& scheduler, const vpid_t& pid) = 0;
  virtual void scheduler_send_packet(Scheduler& scheduler, const Packet& packet) = 0;
};

class Scheduler : public PacketControllerDelegate {
 public:
  Scheduler();
  void initialize(SchedulerDelegate& delegate_);
  NodeID get_dst_nid(const vpid_t& pid, Module::Type module);
  vpid_t get_new_pid();
  void recv_packet(const Packet& packet);
  bool require_create_vm(const vpid_t& pid);
  void set_node_information(const NodeID& nid, const std::string& name);
  void execute();

 private:
  /** Node information for this node. */
  NodeInfo my_info;
  /** Pointer for delegater instance.  */
  SchedulerDelegate* delegate;
  /** A list of processes these are running in all of nodes used by the same account. */
  std::map<vpid_t, ProcessInfo> processes;
  /** All node information as far as I can connect. */
  std::map<NodeID, NodeInfo> nodes;
  /** Random value generator. */
  std::mt19937_64 rnd;
  /** Packet controller. */
  PacketController packet_controller;

  void packet_controller_on_recv(const Packet& packet) override;
  void packet_controller_send(const Packet& packet) override;

  void cleanup_unresponsive_node();
  void cleanup_unresponsive_process();

  void recv_command_activate(const Packet& packet);
  void recv_command_create_gui(const Packet& packet);
  void recv_command_distribute(const Packet& packet);
  void recv_command_heartbeat_gui(const Packet& packet);
  void recv_command_heartbeat_scheduler(const Packet& packet);
  void recv_command_heartbeat_vm(const Packet& packet);
  void recv_command_require_processes_info(const Packet& packet);
  void recv_command_warp_gui(const Packet& packet);
  void recv_command_warp_thread(const Packet& packet);

  void send_command_heartbeat_scheduler();
  void send_command_processes_info();
  void send_command_require_warp_gui(const vpid_t& pid, const NodeID& target_nid);
  void send_command_require_warp_thread(const vpid_t& pid, vtid_t tid, const NodeID& target_nid);
  void send_command_warp_thread(const vpid_t& pid, vtid_t tid);
};
}  // namespace processwarp
