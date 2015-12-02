
#include <cassert>
#include <vector>

#include "pipe.hpp"
#include "pipe_bundler.hpp"

namespace processwarp {
/**
 * Memory allocator for client pipe that is created by libuv.
 * @param handle
 * @param suggested_size
 * @param buf
 */
void pipe_alloc(uv_handle_t *handle, size_t suggested_size, uv_buf_t *buf) {
  buf->base = new char[suggested_size];
  buf->len = suggested_size;
}

/**
 * Constructor with libuv's pipe.
 * This class manage libuv's pipe, receive event and free when close.
 * @param pipe_ Target libuv's pipe.
 */
Pipe::Pipe(uv_pipe_t* pipe_) :
    pipe(pipe_),
    buffer(new std::vector<uint8_t>()) {
}

/**
 * Destructor, check pipe was closed.
 */
Pipe::~Pipe() {
  assert(pipe == nullptr);
}

/**
 * Reveive stream data from a client, clip packet and call on_recv_packet.
 * Concaenate stream data received yet with just now as buffer.
 * Call on_recv_packet method if packet (like bellow) is received fully,
 * and cut off a stream of packet data in head of buffer.
 * Packet:<br/>
 * [packet size (4Byte big endian)][packet body (binary contain '\0')][\0]...(repeat)<br/>
 */
void Pipe::on_read(uv_stream_t* stream, ssize_t nread, const uv_buf_t* buf) {
  Pipe& THIS = *reinterpret_cast<Pipe*>(stream->data);
  uv_pipe_t* client = reinterpret_cast<uv_pipe_t*>(stream);
  std::vector<uint8_t>& client_buffer = *THIS.buffer.get();
  std::unique_ptr<char[]> recv_buffer(buf->base);

  if (nread < 0) {
    if (nread != UV_EOF) {
      /// @todo error
      fprintf(stderr, "Read error %s\n", uv_err_name(nread));
    }
    uv_close(reinterpret_cast<uv_handle_t*>(client), Pipe::on_close);
    return;
  }

  std::size_t idx_dst = client_buffer.size();
  client_buffer.resize(idx_dst + nread);
  std::memcpy(client_buffer.data() + idx_dst, recv_buffer.get(), nread);

  if (client_buffer.size() < 4) return;

  uint32_t psize = ntohl(*reinterpret_cast<uint32_t*>(client_buffer.data()));
  if (client_buffer.size() < 4 + psize + 1) return;

  if (client_buffer.data()[4 + psize] != 0) {
    /// @todo error
    fprintf(stderr, "Wrong packet terminate.");
    uv_close(reinterpret_cast<uv_handle_t*>(client), Pipe::on_close);
    return;
  }

  THIS.on_recv_packet(client, psize, client_buffer.data() + 4);
  uint32_t rest_size = client_buffer.size() - 4 - psize - 1;
  memmove(client_buffer.data(), client_buffer.data() + 4 + psize + 1, rest_size);
  client_buffer.resize(rest_size);
}

/**
 * Receive close event from libuv.
 * Delete libuv's pipe and erase from PipeBundler.
 * @param handle Event hundler from libuv.
 */
void Pipe::on_close(uv_handle_t* handle) {
  Pipe& THIS = *reinterpret_cast<Pipe*>(handle->data);
  PipeBundler& bundler = PipeBundler::get_instance();

  assert(THIS.pipe == reinterpret_cast<uv_pipe_t*>(handle));

  delete THIS.pipe;
  THIS.pipe = nullptr;

  bundler.erase(&THIS);
}
}  // namespace processwarp
