#pragma once

#include <uv.h>

#include <string>

#include "daemon_define.hpp"
#include "frontend_connector.hpp"
#include "worker_connector.hpp"

namespace processwarp {
class Daemon {
 public:
  Daemon();
  int entry(int argc, char* argv[]);

 private:
  /** Daemon run mode. */
  DaemonRunMode::Type run_mode;
  /** Main loop of libuv. */
  uv_loop_t* loop;
  /** Connector for frontends. */
  FrontendConnector frontend_connector;
  /** Connector for workers. */
  WorkerConnector   worker_connector;

  int daemonize();
  int main_loop();
  bool read_options(int argc, char* argv[]);
  void show_help(bool is_error, const std::string& command);
};
}  // namespace processwarp
