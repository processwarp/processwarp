
#include <uv.h>

#include <string>

#include "controller_listener.hpp"
#include "controller_pipe.hpp"
#include "pipe_bundler.hpp"

namespace processwarp {
/**
 * Initialize for ControllerListener.
 * Create UNIX domain socket for controller.
 * @todo Get path of UNIX domain socket from configure.
 */
void ControllerListener::initialize(uv_loop_t* loop) {
  Listener::initialize(loop, "/tmp/pw.controller.pipe");
}

/**
 * Create pipe for controller when accept connection.
 * @param client Pipe connect with controller by libuv.
 */
void ControllerListener::on_connection(uv_pipe_t* client) {
  PipeBundler& bundler = PipeBundler::get_instance();
  bundler.insert(new ControllerPipe(client));
}
}  // namespace processwarp
