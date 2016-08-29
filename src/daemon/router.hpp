#pragma once

#include <picojson.h>
#include <uv.h>

#include <map>
#include <string>
#include <vector>

#include "constant_native.hpp"
#include "packet.hpp"
#include "scheduler.hpp"
#include "type.hpp"

namespace processwarp {
class Router : public SchedulerDelegate {
 public:
  static Router& get_instance();

  void initialize(uv_loop_t* loop_, const picojson::object& config_);
  void load_llvm(const std::string& filename, const std::vector<std::string>& args);
  const NodeID& get_my_nid();
  void relay_from_local(const Packet& packet);
  void relay_from_global(const Packet& packet);
  bool require_create_vm(const vpid_t& pid);
  void set_nid(const NodeID& nid);

 private:
  /** Main loop of libuv. */
  uv_loop_t* loop;
  /** Timer for heartbeat. */
  uv_timer_t heartbeat_timer;
  /** Timer for beat routine. */
  uv_timer_t routine_timer;
  /** Configuration. */
  picojson::object config;
  /** This node's node-id. */
  NodeID my_nid;
  /** Scheduler for this node. */
  Scheduler scheduler;

  Router();
  Router(const Router&);
  Router& operator=(const Router&);

  void scheduler_create_vm(Scheduler& scheduler, const vpid_t& pid, vtid_t root_tid,
                           vaddr_t proc_addr, const std::string& name) override;
  void scheduler_create_gui(Scheduler& scheduler, const vpid_t& pid) override;
  void scheduler_send_packet(Scheduler& scheduler, const Packet& packet) override;

  static void on_timer_heartbeat(uv_timer_t* handle);
  static void on_timer_routine(uv_timer_t* handle);

  void initialize_timer();
};
}  // namespace processwarp
