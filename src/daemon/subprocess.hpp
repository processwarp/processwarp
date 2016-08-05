#pragma once

#include <uv.h>
#include <picojson.h>

#include <string>
#include <vector>

namespace processwarp {
class Subprocess {
 public:
  Subprocess();
  virtual ~Subprocess();

 protected:
  /** Main loop of libuv. */
  uv_loop_t* loop;
  /** Connect handler to backend. */
  uv_connect_t connect;
  /** Pipe handler to backend. */
  uv_pipe_t pipe;
  /** This buffer storing data that are received from backend but not all yet. */
  std::vector<uint8_t> recv_buffer;

  virtual void on_connect() = 0;
  virtual void on_recv_data(const picojson::object& data) = 0;

  void connect_pipe(const std::string& pipe_path);
  void initialize(uv_loop_t* loop_);
  void send_data(const picojson::object& data);

 private:
  struct WriteHandler {
    Subprocess* THIS;
    char* buffer;
  };

  static void on_alloc(uv_handle_t *handle, size_t suggested_size, uv_buf_t *buf);
  static void on_close(uv_handle_t* handle);
  static void on_connect(uv_connect_t* connect, int status);
  static void on_recv(uv_stream_t* stream, ssize_t nread, const uv_buf_t* buf);
  static void on_write_end(uv_write_t *req, int status);
};
}  // namespace processwarp
