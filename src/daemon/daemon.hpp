#pragma once

#include <uv.h>

#include <string>

#include "controller_listener.hpp"
#include "worker_listener.hpp"

namespace processwarp {
namespace DaemonRunMode {
/**
 * Daemon run modes.
 */
enum Type {
  CONSOLE,  ///< Node program run as console application.
  DAEMON,   ///< Node program run as daemon.
  HELP,     ///< Show help.
};
}  // namespace DaemonRunMode

class Daemon {
 public:
  Daemon();
  int entry(int argc, char* argv[]);

 private:
  /** Daemon run mode. */
  DaemonRunMode::Type run_mode;
  /** Main loop of libuv. */
  uv_loop_t* loop;
  /** Controller listener. */
  ControllerListener controller_listener;
  /** Worker listener. */
  WorkerListener worker_listener;

  int daemonize();
  int main_loop();
  bool read_options(int argc, char* argv[]);
  void show_help(bool is_error, const std::string& command);
};

}  // namespace processwarp
