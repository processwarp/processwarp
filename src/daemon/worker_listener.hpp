#pragma once

#include <uv.h>

#include "listener.hpp"

namespace processwarp {
class WorkerListener : public Listener {
 public:
  void initialize(uv_loop_t* loop);

 protected:
  void on_connection(uv_pipe_t* client) override;
};
}  // namespace processwarp
