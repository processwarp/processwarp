
#include <uv.h>

#include <cassert>
#include <string>
#include <vector>

#include "daemon_define.hpp"
#include "router.hpp"
#include "frontend_connector.hpp"

namespace processwarp {
/**
 * FrontendConnector instance getter as singleton pattern.
 * @return The singleton instance of FrontendConnector class.
 */
FrontendConnector& FrontendConnector::get_instance() {
  static FrontendConnector instance;
  return instance;
}

/**
 * Constructor for singleton pattern.
 * This class is singleton.
 * This method is private.
 */
FrontendConnector::FrontendConnector() {
}

/**
 * Initialize for FrontendConnector.
 * Create UNIX domain socket for controller.
 * @todo Get path of UNIX domain socket from configure.
 */
void FrontendConnector::initialize(uv_loop_t* loop) {
  Connector::initialize(loop, "/tmp/pw.frontend.pipe");
}

/**
 * Send connect-frontend reply to frontend.
 * Packet format: {<br/>
 *   command: 'connect_frontend',
 *   result:  &lt;Result code&gt;
 * }
 * @param client Target frontend.
 * @param result Result code.
 */
void FrontendConnector::send_connect_frontend(uv_pipe_t& client, int result) {
  picojson::object packet;

  packet.insert(std::make_pair("command", picojson::value(std::string("connect_frontend"))));
  packet.insert(std::make_pair("result",  picojson::value(static_cast<double>(result))));

  send_packet(client, packet);
}

/**
 * Create pipe for controller when accept connecting.
 * Set status to SETUP.
 * @param client Pipe connect with controller by libuv.
 */
void FrontendConnector::on_connect(uv_pipe_t& client) {
  FrontendProperty property;

  property.status = PipeStatus::SETUP;
  properties.insert(std::make_pair(&client, property));
}

/**
 * When receive packet, call capable methods.
 * @param client Frontend pipe that send this packet.
 * @param packet Packet.
 */
void FrontendConnector::on_recv_packet(uv_pipe_t& client, picojson::object& packet) {
  const std::string& command = packet.at("command").get<std::string>();

  if (command == "connect_frontend") {
    recv_connect_frontend(client, packet);

  } else if (command == "open_file") {
    recv_open_file(client, packet);

  } else {
    /// @todo error
    assert(false);
  }
}

/**
 * When close pipe, remove status from properties.
 * @param client Target pipe to close.
 */
void FrontendConnector::on_close(uv_pipe_t& client) {
  properties.erase(&client);
}

/**
 * When recieve connect-frontend command from frontend, check account.
 * Reply code 0 if account is valid, and change status to CONNECT.
 * Reply code -1 if account is invalid.
 * @param client Frontend that passed this request.
 * @param packet Account information contain account, passord, type.
 */
void FrontendConnector::recv_connect_frontend(uv_pipe_t& client, picojson::object& packet) {
  Router& router = Router::get_instance();
  const std::string& type_str = packet.at("type").get<std::string>();
  FrontendType::Type type;

  assert(properties.at(&client).status == PipeStatus::SETUP);

  if (type_str == "gui") {
    type = FrontendType::GUI;

  } else if (type_str == "cui") {
    type = FrontendType::CUI;

  } else {
    /// @todo error
    assert(false);
  }

  if (router.check_account(packet.at("account").get<std::string>(),
                           packet.at("password").get<std::string>())) {
    send_connect_frontend(client, 0);
    properties.at(&client).status = PipeStatus::CONNECT;

  } else {
    send_connect_frontend(client, -1);
    close(client);
  }
}

/**
 * When receive open-file command from frontend, pass capable method on Router.
 * @param client Frontend that passed this request.
 * @param packet Account information contain account, passord, type.
 */
void FrontendConnector::recv_open_file(uv_pipe_t& client, picojson::object& packet) {
  Router& router = Router::get_instance();

  router.load_llvm(packet.at("filename").get<std::string>(), std::vector<std::string>());
}
}  // namespace processwarp
