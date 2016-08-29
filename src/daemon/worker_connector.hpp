#pragma once

#include <picojson.h>
#include <uv.h>

#include <deque>
#include <map>
#include <string>
#include <tuple>
#include <utility>

#include "connector.hpp"
#include "constant_native.hpp"
#include "packet.hpp"
#include "type.hpp"
#ifdef WITH_WORKER_DEBUG
#  include "worker_subprocess.hpp"
#endif

namespace processwarp {
class WorkerConnector;

class WorkerConnectorDelegate {
 public:
  virtual ~WorkerConnectorDelegate();
  virtual bool worker_connector_require_create_vm(WorkerConnector& caller, const vpid_t& pid) = 0;
};

class WorkerConnector : public Connector {
 public:
  static WorkerConnector& get_instance();

  void beat_routine();
  void create_vm(const vpid_t& pid, vtid_t root_tid, vaddr_t proc_addr, const std::string& name);
  void initialize(WorkerConnectorDelegate& delegate_, uv_loop_t* loop,
                  const std::string& pipe_path_, const std::string& message_fname_,
                  const picojson::array& libs, const picojson::array& lib_filter);
  void relay_packet(const Packet& packet);

 private:
  struct WorkerProperty {
    ConnectStatus::Type status;
    vpid_t pid;
    uv_pipe_t* pipe;
    uv_process_t process;
    std::deque<picojson::object> send_wait;
  };

  /** Pointer to a instance of delegating some method. */
  WorkerConnectorDelegate* delegate;
  std::map<uv_pipe_t*, const vpid_t> pid_map;
  /** Map of pid and propertiy. */
  std::map<const vpid_t, WorkerProperty> properties;
  /** Library pathes to dynamic link on worker. */
  picojson::array config_libs;
  /** Library filter that list of api names to allow virtual machine to call. */
  picojson::array config_lib_filter;
  /** Path of pipe that for connecting with worker. */
  std::string pipe_path;
  /** Message file's path. */
  std::string message_fname;
#ifdef WITH_WORKER_DEBUG
  std::map<const vpid_t, std::unique_ptr<WorkerSubprocess>> debug_workers;
#endif

  WorkerConnector();
  WorkerConnector(const WorkerConnector&);
  WorkerConnector& operator=(const WorkerConnector&);

  static void on_exit(uv_process_t *req, int64_t exit_status, int term_signal);

  void on_connect(uv_pipe_t& client) override;
  void on_recv_data(uv_pipe_t& client, picojson::object& data) override;
  void on_close(uv_pipe_t& client) override;

  void recv_connect_worker(uv_pipe_t& pipe, picojson::object& param);
  void recv_relay_packet(const vpid_t& pid, picojson::object& content);
  void send_data(const vpid_t&pid, const picojson::object& data);
};
}  // namespace processwarp
