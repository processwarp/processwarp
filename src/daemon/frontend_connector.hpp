#pragma once

#include <picojson.h>
#include <uv.h>

#include <map>
#include <string>

#include "connector.hpp"
#include "constant.hpp"
#include "daemon_define.hpp"
#include "type.hpp"

namespace processwarp {
class FrontendConnector : public Connector {
 public:
  static FrontendConnector& get_instance();

  void initialize(uv_loop_t* loop, const std::string& pipe_path);
  void create_gui(const vpid_t& pid);
  void relay_frontend_command(const CommandPacket& packet);

 private:
  struct FrontendProperty {
    PipeStatus::Type status;
    FrontendType::Type type;
    std::string account;
    std::string password;
  };

  /** Map of pipe and propertiy. */
  std::map<uv_pipe_t*, FrontendProperty> properties;
  /** The pipe connectiong frontend that having gui */
  uv_pipe_t* gui_pipe;
  /** Timer switch, true if timer event has enabled. */
  bool connect_timer_enable;
  /** Libuv timer event handler. */
  uv_timer_t connect_timer;

  FrontendConnector();
  FrontendConnector(const FrontendConnector&);
  FrontendConnector& operator=(const FrontendConnector&);

  static void on_connect_timer(uv_timer_t* handle);

  void on_connect(uv_pipe_t& client) override;
  void on_recv_data(uv_pipe_t& client, picojson::object& data) override;
  void on_close(uv_pipe_t& client) override;

  void initialize_connect_timer();
  void recv_connect_frontend(uv_pipe_t& client, picojson::object& param);
  void recv_open_file(uv_pipe_t& client, picojson::object& param);
  void recv_relay_command(uv_pipe_t& client, picojson::object& content);
  void send_connect_frontend(uv_pipe_t& client, int result, const nid_t& my_nid);
};
}  // namespace processwarp
