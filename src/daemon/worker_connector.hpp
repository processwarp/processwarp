#pragma once

#include <picojson.h>
#include <uv.h>

#include "connector.hpp"

namespace processwarp {
class WorkerConnector : public Connector {
 public:
  void initialize(uv_loop_t* loop);

 protected:
  void on_connect(const uv_pipe_t& client) override;
  void on_receive(const uv_pipe_t& client, picojson::object& packet) override;
  void on_close(const uv_pipe_t& client) override;
};
}  // namespace processwarp
