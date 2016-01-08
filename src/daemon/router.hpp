#pragma once

#include <picojson.h>
#include <uv.h>

#include <map>
#include <string>
#include <vector>

#include "daemon_define.hpp"
#include "definitions.hpp"
#include "scheduler.hpp"

namespace processwarp {
class Router : public SchedulerDelegate {
 public:
  static Router& get_instance();

  void initialize(uv_loop_t* loop_, const picojson::object& config_);
  bool check_account(const std::string& account_, const std::string& password_);
  void load_llvm(const std::string& filename, const std::vector<std::string>& args);
  const nid_t& get_my_nid();
  void recv_connect_node();
  void recv_bind_node(const nid_t& nid);
  void relay_command(const CommandPacket& packet);
  void relay_scheduler_command(const CommandPacket& packet);

 private:
  /** Main loop of libuv. */
  uv_loop_t* loop;
  /** Configuration. */
  picojson::object config;
  /** This node's node-id. */
  nid_t my_nid;
  /** Scheduler for this node. */
  Scheduler scheduler;

  Router();
  Router(const Router&);
  Router& operator=(const Router&);

  void scheduler_create_vm(Scheduler& scheduler, const vpid_t& pid, vtid_t root_tid,
                           vaddr_t proc_addr, const nid_t& master_nid) override;
  void scheduler_create_gui(Scheduler& scheduler, const vpid_t& pid) override;
  void scheduler_send_command(Scheduler& scheduler, const CommandPacket& packet) override;
};
}  // namespace processwarp
