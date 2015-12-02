
#include <uv.h>

#include <string>

#include "worker_listener.hpp"
#include "worker_pipe.hpp"
#include "pipe_bundler.hpp"

namespace processwarp {
/**
 * Initialize for WorkerListener.
 * Create UNIX domain socket for worker.
 * @todo Get path of UNIX domain socket from configure.
 */
void WorkerListener::initialize(uv_loop_t* loop) {
  Listener::initialize(loop, "/tmp/pw.worker.pipe");
}

/**
 * Create pipe for worker when accept connection.
 * @param client Pipe connect with worker by libuv.
 */
void WorkerListener::on_connection(uv_pipe_t* client) {
  PipeBundler& bundler = PipeBundler::get_instance();
  bundler.insert(new WorkerPipe(client));
}
}  // namespace processwarp
