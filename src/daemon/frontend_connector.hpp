#pragma once

#include <picojson.h>
#include <uv.h>

#include <map>
#include <string>

#include "connector.hpp"
#include "definitions.hpp"
#include "daemon_define.hpp"

namespace processwarp {
class FrontendConnector : public Connector {
 public:
  static FrontendConnector& get_instance();

  void initialize(uv_loop_t* loop);
  void create_gui(const vpid_t& pid);
  void relay_frontend_packet(const vpid_t& pid, const std::string& content);
  void destroy_gui(const vpid_t& pid);

 private:
  struct FrontendProperty {
    PipeStatus::Type status;
    FrontendType::Type type;
  };

  /** Map of pipe and propertiy. */
  std::map<const uv_pipe_t*, FrontendProperty> properties;
  /** The pipe connectiong frontend that having gui */
  uv_pipe_t* gui_pipe;

  FrontendConnector();
  FrontendConnector(const FrontendConnector&);
  FrontendConnector& operator=(const FrontendConnector&);

  void on_connect(uv_pipe_t& client) override;
  void on_recv_data(uv_pipe_t& client, picojson::object& data) override;
  void on_close(uv_pipe_t& client) override;

  void recv_connect_frontend(uv_pipe_t& client, picojson::object& param);
  void recv_open_file(uv_pipe_t& client, picojson::object& param);
  void recv_relay_command(uv_pipe_t& client, picojson::object& content);
  void send_connect_frontend(uv_pipe_t& client, int result);
};
}  // namespace processwarp
