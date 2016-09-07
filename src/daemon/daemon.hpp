#pragma once

#include <uv.h>
#include <picojson.h>

#include <string>

#include "constant_native.hpp"
#include "logger.hpp"
#include "server_connector.hpp"
#include "worker_connector.hpp"

namespace processwarp {
class Daemon : public ServerConnectorConnectDelegate, public WorkerConnectorDelegate {
 public:
  Daemon();

  int entry(int argc, char* argv[]);

 private:
  /** Daemon run mode. */
  RunMode::Type run_mode;
  /** Configuration. */
  picojson::object config;
  /** Main loop of libuv. */
  uv_loop_t* loop;

  void server_connector_connect_on_success(
      ServerConnector& server_connector, const NodeID& my_nid) override;
  void server_connector_connect_on_failure(
      ServerConnector& server_connector, int code) override;

  bool worker_connector_require_create_vm(WorkerConnector& caller, const vpid_t& pid) override;

  int daemonize();
  bool config_subprocess();
  bool initialize_cui();
  bool initialize_subprocess();
  bool read_config(const std::string& file);
  bool read_options(int argc, char* argv[]);
  void set_stdin_echo(bool is_enable);
  void show_help(bool is_error, const std::string& command);
};
}  // namespace processwarp
