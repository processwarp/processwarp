
#include <cassert>
#include <memory>
#include <string>

#include "daemon_mid.hpp"
#include "logger.hpp"
#include "subprocess.hpp"

namespace processwarp {
Subprocess::Subprocess() {
}

Subprocess::~Subprocess() {
}

/**
 * Connect a pipe with the backend process.
 */
void Subprocess::connect_pipe(const std::string& pipe_path) {
  int r = uv_pipe_init(loop, &pipe, 0);

  if (r) {
    /// @todo error
    Logger::err(DaemonMid::L3008, uv_err_name(r));
    std::cerr << uv_err_name(r) << std::endl;
    assert(false);
  }
  pipe.data    = this;
  connect.data = this;
  uv_pipe_connect(&connect, &pipe, pipe_path.c_str(), Subprocess::on_connect);
}

/**
 * Initializer.
 * @param Libuv's loop instance to use to subprocess's routine.
 */
void Subprocess::initialize(uv_loop_t* loop_) {
  loop = loop_;
}

/**
 * Send JSON format data to backend by converting to binary format.
 * @param data A JSON formated data.
 */
void Subprocess::send_data(const picojson::object& data) {
  std::string bin_data = picojson::value(data).serialize();
  std::unique_ptr<uv_write_t> write_req(new uv_write_t());
  std::unique_ptr<WriteHandler> handler(new WriteHandler());
  std::unique_ptr<char[]> buffer(new char[4 + bin_data.size() + 1]);

  assert(bin_data.size() != 0);

  *reinterpret_cast<uint32_t*>(buffer.get()) = htonl(bin_data.size());
  memcpy(buffer.get() + 4, bin_data.c_str(), bin_data.size());
  buffer[4 + bin_data.size()] = '\0';

  handler->THIS = this;
  handler->buffer = buffer.get();
  write_req->data = reinterpret_cast<void*>(handler.get());
  uv_buf_t write_buf = uv_buf_init(buffer.get(), 4 + bin_data.size() + 1);
  uv_write(write_req.get(), reinterpret_cast<uv_stream_t*>(&pipe),
           &write_buf, 1, Subprocess::on_write_end);
  buffer.release();
  handler.release();
  write_req.release();
}

/**
 * Memory allocator for pipe that is created by libuv.
 * @param handle
 * @param suggested_size
 * @param buf
 */
void Subprocess::on_alloc(uv_handle_t *handle, size_t suggested_size, uv_buf_t *buf) {
  buf->base = new char[suggested_size];
  buf->len = suggested_size;
}

/**
 * When close pipe, do nothing.
 * @param handle Handler thant equal to pointer of pipe.
 */
void Subprocess::on_close(uv_handle_t* handle) {
  /// @todo
  assert(false);
}

/**
 * When connect pipe to backend, bind receive function to libuv's connecter instance.
 * And invoke sub-class's on_connect event.
 * @param connect Libuv's connecter instance.
 * @param status Connect status ? (not used.)
 */
void Subprocess::on_connect(uv_connect_t* connect, int status) {
  if (status != 0) {
    // @todo error
    assert(false);
  }

  Subprocess& THIS = *reinterpret_cast<Subprocess*>(connect->data);

  uv_read_start(reinterpret_cast<uv_stream_t*>(connect->handle),
                Subprocess::on_alloc, Subprocess::on_recv);

  THIS.on_connect();
}

/**
 * When recv stream data from backend, clip packet and call recv_data.
 * Concaenate stream data received yet with just now as buffer.
 * Parse json from buffer.
 * Call on_receive method if json packet (like bellow) is received fully,
 * and cut off a stream of packet data in head of buffer.
 * Packet:<br/>
 * [packet size (json length 4Byte big endian)][packet body (json)][\0]...(repeat)<br/>
 */
void Subprocess::on_recv(uv_stream_t* stream, ssize_t nread, const uv_buf_t* buf) {
  Subprocess& THIS = *reinterpret_cast<Subprocess*>(stream->data);
  std::unique_ptr<char[]> recv_buffer(buf->base);

  if (nread < 0) {
    if (nread != UV_EOF) {
      /// @todo error
      Logger::err(DaemonMid::L3003, uv_err_name(nread));
    }
    uv_close(reinterpret_cast<uv_handle_t*>(&THIS.pipe), Subprocess::on_close);
    return;
  }

  std::size_t idx_dst = THIS.recv_buffer.size();
  THIS.recv_buffer.resize(idx_dst + nread);
  std::memcpy(THIS.recv_buffer.data() + idx_dst, recv_buffer.get(), nread);

  while (THIS.recv_buffer.size() >= 4) {
    uint32_t psize = ntohl(*reinterpret_cast<uint32_t*>(THIS.recv_buffer.data()));
    if (THIS.recv_buffer.size() < 4 + psize + 1) return;

    if (THIS.recv_buffer.data()[4 + psize] != 0) {
      /// @todo error
      Logger::warn(DaemonMid::L3004);
      uv_close(reinterpret_cast<uv_handle_t*>(&THIS.pipe), Subprocess::on_close);
      assert(false);
      return;
    }

    picojson::value v;
    std::string err;
    picojson::parse(v, THIS.recv_buffer.data() + 4, THIS.recv_buffer.data() + 4 + psize, &err);
    if (!err.empty()) {
      Logger::warn(DaemonMid::L3004);
      Logger::dbg(DaemonMid::L3005, THIS.recv_buffer.data() + 4);
      return;
    }

    THIS.on_recv_data(v.get<picojson::object>());
    uint32_t rest_size = THIS.recv_buffer.size() - 4 - psize - 1;
    memmove(THIS.recv_buffer.data(), THIS.recv_buffer.data() + 4 + psize + 1, rest_size);
    THIS.recv_buffer.resize(rest_size);
  }
}

/**
 * When uv_write is finished, clean-up hundler.
 * If error is occurred in this method, close target pipe.
 * @param req Hundler.
 * @param status Status code.
 */
void Subprocess::on_write_end(uv_write_t *req, int status) {
  std::unique_ptr<uv_write_t> write_req(req);
  std::unique_ptr<WriteHandler> handler(reinterpret_cast<WriteHandler*>(write_req->data));
  std::unique_ptr<char[]> buffer(handler->buffer);

  if (status < 0) {
    /// @todo error
    Logger::err(DaemonMid::L3006, uv_err_name(status));
    uv_close(reinterpret_cast<uv_handle_t*>(&handler->THIS->pipe), Subprocess::on_close);
  }
}
}  // namespace processwarp
