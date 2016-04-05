#pragma once

#include <uv.h>
#include <picojson.h>

#include <string>

#include "daemon_define.hpp"

namespace processwarp {
class Daemon {
 public:
  Daemon();
  int entry(int argc, char* argv[]);

 private:
  /** Daemon run mode. */
  DaemonRunMode::Type run_mode;
  /** Configuration. */
  picojson::object config;
  /** Main loop of libuv. */
  uv_loop_t* loop;

  int daemonize();
  bool initialize_logger();
  bool initialize_message();
  int main_loop();
  bool read_config(const std::string& file);
  bool read_options(int argc, char* argv[]);
  void show_help(bool is_error, const std::string& command);
  bool subprocess_config();
};
}  // namespace processwarp
