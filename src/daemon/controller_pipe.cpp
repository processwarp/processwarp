
#include <cassert>

#include "controller_pipe.hpp"

namespace processwarp {
/**
 * Constructor with pipe.
 */
ControllerPipe::ControllerPipe(uv_pipe_t* pipe_) :
    Pipe(pipe_) {
}

/**
 * Receiver for packet.
 */
void ControllerPipe::on_recv_packet(uv_pipe_t* client, uint32_t psize, const uint8_t* packet) {
  /// @todo
  assert(false);
}
}  // namespace processwarp
