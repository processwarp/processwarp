#pragma once

#include <uv.h>

#include "pipe.hpp"

namespace processwarp {
class ControllerPipe : public Pipe {
 public:
  explicit ControllerPipe(uv_pipe_t* pipe_);

 protected:
  void on_recv_packet(uv_pipe_t* client, uint32_t psize, const uint8_t* packet) override;
};
}  // namespace processwarp
