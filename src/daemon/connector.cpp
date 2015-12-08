
#include <cassert>
#include <cstring>
#include <string>
#include <vector>

#include "connector.hpp"

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
    fprintf(stderr, "Bind error %s\n", uv_err_name(r));
    return;
  }
  if ((r = uv_listen(reinterpret_cast<uv_stream_t*>(&listener), 128, Connector::on_connect))) {
    /// @todo error
    fprintf(stderr, "Listen error %s\n", uv_err_name(r));
    return;
  }
}

/**
 * Send packet to client.
 * Packet format is the same to on_recv method.
 * @param client Distination client's pipe.
 * @param packet Packet that formated json.
 */
void Connector::send_packet(uv_pipe_t& client, const picojson::object& packet) {
  std::string str_packet = picojson::value(packet).serialize();
  std::unique_ptr<char[]> buffer(new char[4 + str_packet.size() + 1]);

  *reinterpret_cast<uint32_t*>(buffer.get()) = htonl(str_packet.size());
  memcpy(buffer.get() + 4, str_packet.c_str(), str_packet.size());
  buffer[4 + str_packet.size()] = '\0';

  uv_write_t* write_req = new uv_write_t();
  write_req->data = reinterpret_cast<void*>(&client);
  uv_buf_t write_buf = uv_buf_init(buffer.get(), 4 + str_packet.size() + 1);
  uv_write(write_req, reinterpret_cast<uv_stream_t*>(&client), &write_buf, 1, on_send);
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
 * Reveive stream data from a client, clip packet and call on_recv_packet.
 * Concaenate stream data received yet with just now as buffer.
 * Parse json from buffer.
 * Call on_receive method if json packet (like bellow) is received fully,
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
      fprintf(stderr, "Read error %s\n", uv_err_name(nread));
    }
    uv_close(reinterpret_cast<uv_handle_t*>(client), Connector::on_close);
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
    uv_close(reinterpret_cast<uv_handle_t*>(client), Connector::on_close);
    return;
  }

  picojson::value v;
  std::string err;
  picojson::parse(v, client_buffer.data() + 4, client_buffer.data() + 4 + psize, &err);
  if (!err.empty()) {
    /// @todo err
    fprintf(stderr, "on_read:%s\n", err.c_str());
    uv_close(reinterpret_cast<uv_handle_t*>(client), Connector::on_close);
    return;
  }

  THIS.on_recv_packet(*client, v.get<picojson::object>());
  uint32_t rest_size = client_buffer.size() - 4 - psize - 1;
  memmove(client_buffer.data(), client_buffer.data() + 4 + psize + 1, rest_size);
  client_buffer.resize(rest_size);
}

/**
 * When send is finished, clean-up hundler.
 * If error is occurred, close target pipe.
 * @param req Hundler.
 * @param status Status code.
 */
void Connector::on_send(uv_write_t *req, int status) {
  std::unique_ptr<uv_write_t> x(req);

  if (status < 0) {
    /// @todo err
    fprintf(stderr, "error on uv_write\n");
    uv_close(reinterpret_cast<uv_handle_t*>(req->data), Connector::on_close);
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
