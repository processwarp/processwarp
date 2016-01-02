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
  virtual void scheduler_create_vm(Scheduler& scheduler,
                                   const vpid_t& pid,
                                   vtid_t root_tid,
                                   vaddr_t proc_addr,
                                   const nid_t& master_nid) = 0;
  virtual nid_t scheduler_get_my_nid(Scheduler& scheduler) = 0;
  virtual void scheduler_vm_command(Scheduler& scheduler,
                                    const vpid_t& pid,
                                    const std::string& command,
                                    const picojson::object& param) = 0;
  virtual bool scheduler_have_process(Scheduler& scheduler,
                                      const vpid_t& pid) = 0;
  virtual void scheduler_send_packet(Scheduler& scheduler, const vpid_t& pid,
                                     const nid_t& dst_nid, const std::string& packet) = 0;
};

class Scheduler {
 public:
  void initialize(SchedulerDelegate& delegate_);
  void on_recv_packet(const vpid_t& pid, const std::string& packet);
  void activate();

 private:
  /** Pointer for delegater instance.  */
  SchedulerDelegate* delegate;
  /** A list of processes these are running in all of nodes used by the same account. */
  std::map<vpid_t, ProcessTree> processes;

  void recv_activate(const picojson::object& packet);
  void recv_warp(const vpid_t& pid, const picojson::object& packet);
  void send_packet(const vpid_t& pid, const nid_t& dst_nid,
                   const std::string& command, picojson::object& packet);
};
}  // namespace processwarp
