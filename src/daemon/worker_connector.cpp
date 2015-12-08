
#include <uv.h>

#include <cassert>
#include <string>

#include "worker_connector.hpp"

namespace processwarp {
/**
 * WorkerConnector instance getter as singleton pattern.
 * @return The singleton instance of WorkerConnector class.
 */
WorkerConnector& WorkerConnector::get_instance() {
  static WorkerConnector instance;
  return instance;
}

/**
 * Constructor for singleton pattern.
 * This class is singleton.
 * This method is private.
 */
WorkerConnector::WorkerConnector() {
}

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
void WorkerConnector::on_connect(uv_pipe_t& client) {
  /// @todo
  assert(false);
}

void WorkerConnector::on_recv_packet(uv_pipe_t& client, picojson::object& packet) {
  /// @todo
  assert(false);
}

void WorkerConnector::on_close(uv_pipe_t& client) {
  /// @todo
  assert(false);
}
}  // namespace processwarp
