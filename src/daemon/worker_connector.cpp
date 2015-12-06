
#include <uv.h>

#include <cassert>
#include <string>

#include "worker_connector.hpp"

namespace processwarp {
/**
 * Initialize for WorkerConnector.
 * Create UNIX domain socket for worker.
 * @todo Get path of UNIX domain socket from configure.
 */
void WorkerConnector::initialize(uv_loop_t* loop) {
  Connector::initialize(loop, "/tmp/pw.worker.pipe");
}

/**
 * Create pipe for worker when accept connecting.
 * @param client Pipe connect with worker by libuv.
 */
void WorkerConnector::on_connect(const uv_pipe_t& client) {
  /// @todo
  assert(false);
}

void WorkerConnector::on_receive(const uv_pipe_t& client, picojson::object& packet) {
  /// @todo
  assert(false);
}

void WorkerConnector::on_close(const uv_pipe_t& client) {
  /// @todo
  assert(false);
}
}  // namespace processwarp
