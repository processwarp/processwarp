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
  /** Main loop of libuv. */
  uv_loop_t* loop;

  void initialize(uv_loop_t* loop_, const std::string& path);
  void send_data(uv_pipe_t& client, const picojson::object& data);
  void close(uv_pipe_t& client);
  virtual void on_connect(uv_pipe_t& client) = 0;
  virtual void on_recv_data(uv_pipe_t& client, picojson::object& data) = 0;
  virtual void on_close(uv_pipe_t& client) = 0;

 private:
  struct WriteHandler {
    Connector* THIS;
    uv_pipe_t* pipe;
    char* buffer;
  };
  /** Listener pipe of libuv. */
  uv_pipe_t listener;
  /** Map of pipe and buffer that read by pipe yet. */
  std::map<uv_pipe_t*, std::vector<uint8_t>> buffers;

  Connector(const Connector&);
  Connector& operator=(const Connector&);

  static void on_connect(uv_stream_t* server, int status);
  static void on_recv(uv_stream_t* stream, ssize_t nread, const uv_buf_t* buf);
  static void on_write_end(uv_write_t *req, int status);
  static void on_close(uv_handle_t* handle);
};
}  // namespace processwarp
