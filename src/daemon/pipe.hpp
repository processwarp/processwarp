#pragma once

#include <uv.h>

#include <memory>
#include <vector>

namespace processwarp {
class Pipe {
 public:
  explicit Pipe(uv_pipe_t* pipe_);
  virtual ~Pipe();

 protected:
  virtual void on_recv_packet(uv_pipe_t* client, uint32_t psize, const uint8_t* packet) = 0;

 private:
  uv_pipe_t* pipe;
  std::unique_ptr<std::vector<uint8_t>> buffer;

  Pipe();
  Pipe(const Pipe&);
  Pipe& operator=(const Pipe&);

  static void on_read(uv_stream_t* stream, ssize_t nread, const uv_buf_t* buf);
  static void on_close(uv_handle_t* handle);
};
}  // namespace processwarp
