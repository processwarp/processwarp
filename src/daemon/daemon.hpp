#pragma once

#include <string>

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

  int daemonize();
  bool read_options(int argc, char* argv[]);
  void show_help(bool is_error, const std::string& command);
};

}  // namespace processwarp
