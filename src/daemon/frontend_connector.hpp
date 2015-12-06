#pragma once

#include <picojson.h>
#include <uv.h>

#include <map>

#include "connector.hpp"
#include "daemon_define.hpp"

namespace processwarp {
class FrontendConnector : public Connector {
 public:
  void initialize(uv_loop_t* loop);

 protected:
  struct FrontendProperty {
    PipeStatus::Type status;
    FrontendType::Type type;
  };

  /** Map of pipe and propertiy. */
  std::map<const uv_pipe_t*, FrontendProperty> properties;

  void on_connect(const uv_pipe_t& client) override;
  void on_receive(const uv_pipe_t& client, picojson::object& packet) override;
  void on_close(const uv_pipe_t& client) override;
};
}  // namespace processwarp
