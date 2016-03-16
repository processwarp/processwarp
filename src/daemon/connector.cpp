
#include <cassert>
#include <cstring>
#include <memory>
#include <string>
#include <vector>

#include "connector.hpp"
#include "daemon_mid.hpp"
#include "logger.hpp"
#include "util.hpp"

namespace processwarp {
/**
 * Memory allocator for client pipe that is created by libuv.
 * @param handle
 * @param suggested_size
 * @param buf
 */
void connector_alloc(uv_handle_t *handle, size_t suggested_size, uv_buf_t *buf) {
  buf->base = new char[suggested_size];
  buf->len = suggested_size;
}

/**
 * Simple constructor.
 */
Connector::Connector() :
    loop(nullptr) {
}

/**
 * Simple destructor for vtable.
 */
Connector::~Connector() {
}

/**
 * Initialize listener pipe.
 * Create pipe by libuv and listen.
 * @param loop_ Libuv-loop for event of pipe.
 * @param path Full path for UNIX domain socket.
 */
void Connector::initialize(uv_loop_t* loop_, const std::string& path) {
  int r;
  this->loop = loop_;

  uv_pipe_init(loop, &listener, 0);
  listener.data = this;

  if ((r = uv_pipe_bind(&listener, path.c_str()))) {
    /// @todo error
    Logger::err(DaemonMid::L3001, uv_err_name(r), path.c_str());
    return;
  }
  if ((r = uv_listen(reinterpret_cast<uv_stream_t*>(&listener), 128, Connector::on_connect))) {
    /// @todo error
    Logger::err(DaemonMid::L3002, uv_err_name(r), path.c_str());
    return;
  }
}

/**
 * Send packet to client.
 * Packet format is the same to on_recv method.
 * @param client Distination client's pipe.
 * @param data Packet that formated json.
 */
void Connector::send_data(uv_pipe_t& client, const picojson::object& data) {
  std::string bin_data = picojson::value(data).serialize();
  std::unique_ptr<uv_write_t> write_req(new uv_write_t());
  std::unique_ptr<WriteHandler> handler(new WriteHandler());
  std::unique_ptr<char[]> buffer(new char[4 + bin_data.size() + 1]);

  assert(bin_data.size() != 0);

  *reinterpret_cast<uint32_t*>(buffer.get()) = htonl(bin_data.size());
  memcpy(buffer.get() + 4, bin_data.c_str(), bin_data.size());
  buffer[4 + bin_data.size()] = '\0';

  handler->THIS = this;
  handler->pipe = &client;
  handler->buffer = buffer.get();
  write_req->data = reinterpret_cast<void*>(handler.get());
  uv_buf_t write_buf = uv_buf_init(buffer.get(), 4 + bin_data.size() + 1);
  uv_write(write_req.get(), reinterpret_cast<uv_stream_t*>(&client),
           &write_buf, 1, Connector::on_write_end);
  buffer.release();
  handler.release();
  write_req.release();
}

/**
 * Close pipe and set clean-up.
 * @param client Target pipe.
 */
void Connector::close(uv_pipe_t& client) {
  uv_close(reinterpret_cast<uv_handle_t*>(&client), Connector::on_close);
}

/**
 * Method that is call by libuv when client is connect.
 * Accept client and push it to the set of clients and the queue of receive event.
 * @param listener
 * @param status
 */
void Connector::on_connect(uv_stream_t *listener, int status) {
  Connector& THIS = *reinterpret_cast<Connector*>(listener->data);
  if (status == -1) {
    /// @todo error
    return;
  }

  uv_pipe_t* client = new uv_pipe_t();
  uv_pipe_init(THIS.loop, client, 0);
  int r = uv_accept(listener, reinterpret_cast<uv_stream_t*>(client));

  if (r == 0) {
    client->data = &THIS;
    THIS.buffers.insert(std::make_pair(client, std::vector<uint8_t>()));
    uv_read_start(reinterpret_cast<uv_stream_t*>(client), connector_alloc, Connector::on_recv);
    THIS.on_connect(*client);

  } else {
    uv_close(reinterpret_cast<uv_handle_t*>(client), Connector::on_close);
  }
}

/**
 * Reveive stream data from a client, clip packet and call on_recv_data.
 * Concaenate stream data received yet with just now as buffer.
 * Parse json from buffer.
 * Call on_recv_data method if json packet (like bellow) is received fully,
 * and cut off a stream of packet data in head of buffer.
 * Packet:<br/>
 * [packet size (json length 4Byte big endian)][packet body (json)][\0]...(repeat)<br/>
 */
void Connector::on_recv(uv_stream_t* stream, ssize_t nread, const uv_buf_t* buf) {
  Connector& THIS = *reinterpret_cast<Connector*>(stream->data);
  uv_pipe_t* client = reinterpret_cast<uv_pipe_t*>(stream);
  std::vector<uint8_t>& client_buffer = THIS.buffers.at(client);
  std::unique_ptr<char[]> recv_buffer(buf->base);

  if (nread < 0) {
    if (nread != UV_EOF) {
      /// @todo error
      Logger::err(DaemonMid::L3003, uv_err_name(nread));
    }
    uv_close(reinterpret_cast<uv_handle_t*>(client), Connector::on_close);
    return;
  }

  std::size_t idx_dst = client_buffer.size();
  client_buffer.resize(idx_dst + nread);
  std::memcpy(client_buffer.data() + idx_dst, recv_buffer.get(), nread);

  while (client_buffer.size() >= 4) {
    uint32_t psize = ntohl(*reinterpret_cast<uint32_t*>(client_buffer.data()));
    if (client_buffer.size() < 4 + psize + 1) return;

    if (client_buffer.data()[4 + psize] != 0) {
      Logger::warn(DaemonMid::L3004);
      uv_close(reinterpret_cast<uv_handle_t*>(client), Connector::on_close);
      assert(false);
      return;
    }

    picojson::value v;
    std::string err;
    picojson::parse(v, client_buffer.data() + 4, client_buffer.data() + 4 + psize, &err);
    if (!err.empty()) {
      Logger::warn(DaemonMid::L3004);
      Logger::dbg(DaemonMid::L3005, client_buffer.data() + 4);
      return;
    }

    THIS.on_recv_data(*client, v.get<picojson::object>());
    uint32_t rest_size = client_buffer.size() - 4 - psize - 1;
    memmove(client_buffer.data(), client_buffer.data() + 4 + psize + 1, rest_size);
    client_buffer.resize(rest_size);
  }
}

/**
 * When uv_write is finished, clean-up hundler.
 * If error is occurred in this method, close target pipe.
 * @param req Hundler.
 * @param status Status code.
 */
void Connector::on_write_end(uv_write_t *req, int status) {
  std::unique_ptr<uv_write_t> write_req(req);
  std::unique_ptr<WriteHandler> handler(reinterpret_cast<WriteHandler*>(write_req->data));
  std::unique_ptr<char[]> buffer(handler->buffer);

  if (status < 0) {
    /// @todo err
    Logger::err(DaemonMid::L3006, uv_err_name(status));
    uv_close(reinterpret_cast<uv_handle_t*>(handler->pipe), Connector::on_close);
  }
}

/**
 * Method that is call by libuv when accepting client socket is failed.
 * Free pointer of pipe that is allocated in on_connection.
 * @param handle Handler that equal to pointer of pipe.
 */
void Connector::on_close(uv_handle_t* handle) {
  Connector& THIS = *reinterpret_cast<Connector*>(handle->data);
  uv_pipe_t* client = reinterpret_cast<uv_pipe_t*>(handle);

  THIS.on_close(*client);
  THIS.buffers.erase(client);
  delete client;
}
}  // namespace processwarp
