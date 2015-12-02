
#include <cassert>

#include "worker_pipe.hpp"

namespace processwarp {
/**
 * Constructor with pipe.
 */
WorkerPipe::WorkerPipe(uv_pipe_t* pipe_) :
    Pipe(pipe_) {
}

/**
 * Receiver for packet.
 */
void WorkerPipe::on_recv_packet(uv_pipe_t* client, uint32_t psize, const uint8_t* packet) {
  /// @todo
  assert(false);
}
}  // namespace processwarp
