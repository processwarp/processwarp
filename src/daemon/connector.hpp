#pragma once

#include <picojson.h>
#include <uv.h>

#include <map>
#include <string>
#include <vector>

namespace processwarp {
class Connector {
 public:
  Connector();
  virtual ~Connector();

 protected:
  void initialize(uv_loop_t* loop_, const std::string& path);
  virtual void on_connect(const uv_pipe_t& client) = 0;
  virtual void on_receive(const uv_pipe_t& client, picojson::object& packet) = 0;
  virtual void on_close(const uv_pipe_t& client) = 0;

 private:
  /** Main loop of libuv. */
  uv_loop_t* loop;
  /** Listener pipe of libuv. */
  uv_pipe_t listener;
  /** Map of pipe and buffer that read by pipe yet. */
  std::map<uv_pipe_t*, std::vector<uint8_t>> buffers;

  Connector(const Connector&);
  Connector& operator=(const Connector&);

  static void on_connect(uv_stream_t* server, int status);
  static void on_read(uv_stream_t* stream, ssize_t nread, const uv_buf_t* buf);
  static void on_close(uv_handle_t* handle);
};
}  // namespace processwarp
