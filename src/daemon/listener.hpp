#pragma once

#include <uv.h>

#include <map>
#include <memory>
#include <string>
#include <vector>

namespace processwarp {
class Listener {
 public:
  Listener();
  virtual ~Listener();

 protected:
  void initialize(uv_loop_t* loop_, const std::string& path);
  virtual void on_connection(uv_pipe_t* client) = 0;

 private:
  /** Main loop of libuv. */
  uv_loop_t* loop;
  /** Server pipe of uv-pipe. */
  uv_pipe_t server;

  Listener(const Listener&);
  Listener& operator=(const Listener&);

  static void on_connection(uv_stream_t* server, int status);
  static void on_close_client(uv_handle_t* handle);
};
}  // namespace processwarp
