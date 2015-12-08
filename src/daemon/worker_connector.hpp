#pragma once

#include <picojson.h>
#include <uv.h>

#include "connector.hpp"

namespace processwarp {
class WorkerConnector : public Connector {
 public:
  static WorkerConnector& get_instance();

  void initialize(uv_loop_t* loop);

 private:
  WorkerConnector();
  WorkerConnector(const WorkerConnector&);
  WorkerConnector& operator=(const WorkerConnector&);

  void on_connect(uv_pipe_t& client) override;
  void on_recv_packet(uv_pipe_t& client, picojson::object& packet) override;
  void on_close(uv_pipe_t& client) override;
};
}  // namespace processwarp
