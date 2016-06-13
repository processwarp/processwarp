#pragma once

#include <picojson.h>
#include <uv.h>

#include <map>
#include <string>

#include "connector.hpp"
#include "constant.hpp"
#include "constant_native.hpp"
#include "packet.hpp"
#include "server_connector.hpp"
#include "type.hpp"

namespace processwarp {
class FrontendConnector : public Connector, public ServerConnectorConnectDelegate {
 public:
  static FrontendConnector& get_instance();

  void initialize(uv_loop_t* loop, const std::string& pipe_path, const std::string& common_key_);
  void create_gui(const vpid_t& pid);
  void relay_packet(const Packet& packet);

 private:
  /** The pipe connectiong frontend. */
  uv_pipe_t* pipe;
  /** Frontend connect status. */
  ConnectStatus::Type connect_status;
  /** Frontend type. */
  FrontendType::Type frontend_type;
  /** The common key for authenticate. */
  std::string common_key;

  FrontendConnector();
  FrontendConnector(const FrontendConnector&);
  FrontendConnector& operator=(const FrontendConnector&);

  void server_connector_connect_on_success(ServerConnector& server_connector,
                                            const NodeID& my_nid) override;
  void server_connector_connect_on_failure(ServerConnector& server_connector, int code) override;

  void on_connect(uv_pipe_t& client) override;
  void on_recv_data(uv_pipe_t& client, picojson::object& data) override;
  void on_close(uv_pipe_t& client) override;

  void recv_authenticate(uv_pipe_t& client, picojson::object& param);
  void recv_open(uv_pipe_t& client, picojson::object& param);
  void recv_open_file(uv_pipe_t& client, picojson::object& param);
  void recv_relay_packet(uv_pipe_t& client, picojson::object& content);
  void reply_authenticate(uv_pipe_t& client, int result, const NodeID& my_nid);
  void reply_open(uv_pipe_t& client, int result);
};
}  // namespace processwarp
