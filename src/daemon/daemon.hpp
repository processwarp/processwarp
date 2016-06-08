#pragma once

#include <uv.h>
#include <picojson.h>

#include <string>

#include "constant_native.hpp"
#include "logger_syslog.hpp"
#include "network_connector.hpp"

namespace processwarp {
class Daemon : public NetworkConnectorConnectDelegate {
 public:
  Daemon();

  int entry(int argc, char* argv[]);

 private:
  /** Syslog logger. */
  Logger::Syslog logger;
  /** Daemon run mode. */
  RunMode::Type run_mode;
  /** Configuration. */
  picojson::object config;
  /** Main loop of libuv. */
  uv_loop_t* loop;

  void network_connector_connect_on_success(
      NetworkConnector& network_connector, const NodeID& my_nid) override;
  void network_connector_connect_on_failure(
      NetworkConnector& network_connector, int code) override;

  int daemonize();
  bool config_subprocess();
  bool initialize_cui();
  bool initialize_logger();
  bool initialize_message();
  bool initialize_subprocess();
  int main_loop();
  bool read_config(const std::string& file);
  bool read_options(int argc, char* argv[]);
  void set_stdin_echo(bool is_enable);
  void show_help(bool is_error, const std::string& command);
};
}  // namespace processwarp
