#pragma once

#include <picojson.h>
#include <uv.h>

#include <map>
#include <string>
#include <utility>
#include <vector>

#include "connector.hpp"
#include "daemon_define.hpp"
#include "definitions.hpp"

namespace processwarp {
class WorkerConnector : public Connector {
 public:
  static WorkerConnector& get_instance();

  void initialize(uv_loop_t* loop, const std::string& config_file_);
  void create_vm(const vpid_t& pid, vtid_t root_tid, vaddr_t proc_addr, const nid_t& master_nid);
  bool have_process(const vpid_t& pid);
  void relay_packet(const vpid_t& pid, const std::string& type, const std::string& packet);
  void send_scheduler_command(const vpid_t& pid, const std::string& command,
                              const picojson::object& param);

 private:
  struct WorkerProperty {
    PipeStatus::Type status;
    vpid_t pid;
    uv_pipe_t* pipe;
    uv_process_t process;
    std::vector<picojson::object> send_wait;
  };

  std::map<uv_pipe_t*, const vpid_t> pid_map;
  /** Map of pid and propertiy. */
  std::map<const vpid_t, WorkerProperty> properties;
  /** Config filename to pass worker. */
  std::string config_file;

  WorkerConnector();
  WorkerConnector(const WorkerConnector&);
  WorkerConnector& operator=(const WorkerConnector&);

  static void on_exit(uv_process_t *req, int64_t exit_status, int term_signal);

  void on_connect(uv_pipe_t& client) override;
  void on_recv_packet(uv_pipe_t& client, picojson::object& packet) override;
  void on_close(uv_pipe_t& client) override;

  void recv_connect_worker(uv_pipe_t& pipe, picojson::object& packet);
  void recv_relay(const vpid_t& pid, picojson::object& packet);
  void send_packet(const vpid_t&pid, const picojson::object& packet);
};
}  // namespace processwarp
