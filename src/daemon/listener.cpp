
#include <cassert>
#include <cstring>
#include <string>

#include "listener.hpp"

namespace processwarp {

/**
 * Simple constructor.
 */
Listener::Listener() :
    loop(nullptr) {
}

/**
 * Simple destructor for vtable.
 */
Listener::~Listener() {
}

/**
 * Initialize for server listener.
 * Create pipe by libuv and listen.
 * @param loop_ Libuv-loop for event of pipe.
 * @param path Full path for UNIX domain socket.
 */
void Listener::initialize(uv_loop_t* loop_, const std::string& path) {
  int r;
  this->loop = loop_;

  uv_pipe_init(loop, &server, 0);
  server.data = this;

  if ((r = uv_pipe_bind(&server, path.c_str()))) {
    /// @todo error
    fprintf(stderr, "Bind error %s\n", uv_err_name(r));
    return;
  }
  if ((r = uv_listen(reinterpret_cast<uv_stream_t*>(&server), 128, Listener::on_connection))) {
    /// @todo error
    fprintf(stderr, "Listen error %s\n", uv_err_name(r));
    return;
  }
}

/**
 * Method that is call by libuv when client is connect.
 * Accept client and push it to the set of clients and the queue of receive event.
 * @param server
 * @param status
 */
void Listener::on_connection(uv_stream_t *server, int status) {
  Listener& THIS = *reinterpret_cast<Listener*>(server->data);
  if (status == -1) {
    /// @todo error
    return;
  }

  uv_pipe_t* client = new uv_pipe_t();
  uv_pipe_init(THIS.loop, client, 0);
  int r = uv_accept(server, reinterpret_cast<uv_stream_t*>(client));

  if (r == 0) {
    THIS.on_connection(client);

  } else {
    uv_close(reinterpret_cast<uv_handle_t*>(client), Listener::on_close_client);
  }
}

/**
 * Method that is call by libuv when accepting client socket is failed.
 * Free pointer of pipe that is allocated in on_connection.
 * @param handle Handler that equal to pointer of pipe.
 */
void Listener::on_close_client(uv_handle_t* handle) {
  uv_pipe_t* client = reinterpret_cast<uv_pipe_t*>(handle);

  delete client;
}
}  // namespace processwarp
