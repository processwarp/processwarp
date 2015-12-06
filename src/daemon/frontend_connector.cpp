
#include <uv.h>

#include <string>

#include "frontend_connector.hpp"

namespace processwarp {
/**
 * Initialize for FrontendConnector.
 * Create UNIX domain socket for controller.
 * @todo Get path of UNIX domain socket from configure.
 */
void FrontendConnector::initialize(uv_loop_t* loop) {
  Connector::initialize(loop, "/tmp/pw.frontend.pipe");
}

/**
 * Create pipe for controller when accept connecting.
 * Set status to SETUP.
 * @param client Pipe connect with controller by libuv.
 */
void FrontendConnector::on_connect(const uv_pipe_t& client) {
  FrontendProperty property;

  property.status = PipeStatus::SETUP;
  properties.insert(std::make_pair(&client, property));
}

void FrontendConnector::on_receive(const uv_pipe_t& client, picojson::object& packet) {
  std::string j = picojson::value(packet).serialize();
  printf("F.reveive:%s\n", j.c_str());
  /// @todo
  assert(false);
}

/**
 * On close pipe, remove status from properties.
 * @param client Target pipe to close.
 */
void FrontendConnector::on_close(const uv_pipe_t& client) {
  properties.erase(&client);
}
}  // namespace processwarp
