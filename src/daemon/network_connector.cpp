
#include <cassert>
#include <map>
#include <memory>
#include <string>
#include <vector>

#include "constant.hpp"
#include "convert.hpp"
#include "error.hpp"
#include "network_connector.hpp"
#include "router.hpp"
#include "util.hpp"

namespace processwarp {
/**
 * Get string value by key from Socket.IO map.
 * @param data Pointer to Socket.IO map.
 * @param key Key in map.
 * @param is_must True if value must be contain by data.
 * @return Value as string in map.
 */
std::string get_str_by_map(sio::message::ptr data, std::string key, bool is_must = false) {
  if (data->get_map().find(key) == data->get_map().end()) {
    if (is_must) {
      throw_error_message(Error::PROTOCOL, key);

    } else {
      return "";
    }

  } else {
    sio::message::ptr ptr = data->get_map().at(key);
    if (ptr.get() == nullptr) {
      if (is_must) {
        throw_error_message(Error::PROTOCOL, key);

      } else {
        return "";
      }
    } else {
      return data->get_map().at(key)->get_string();
    }
  }
}

/**
 * Convert string to Socket.IO value.
 * @param str Source string value.
 * @return Socket.IO value.
 */
sio::message::ptr get_sio_by_str(const std::string& str) {
  return sio::string_message::create(str);
}

/**
 * Get process-id value by key from Socket.IO map.
 * @param data Pointer to Socket.IO map.
 * @param key Key in map.
 * @return Value as process-id in map.
 */
vpid_t get_pid_by_map(sio::message::ptr data, const std::string& key) {
  return Convert::str2vpid(get_str_by_map(data, key));
}

/**
 * Convert process-id to Socket.IO value.
 * @param pid process-id.
 * @return Socket.IO value.
 */
sio::message::ptr get_sio_by_pid(const vpid_t& pid) {
  return get_sio_by_str(Convert::vpid2str(pid));
}

/**
 * Get thread-id value by key from Socket.IO map.
 * @param data Pointer to Socket.IO map.
 * @param key Key in map.
 * @return Value as thread-id in map.
 */
vtid_t get_tid_by_map(sio::message::ptr data, const std::string& key) {
  return Convert::str2vtid(get_str_by_map(data, key));
}

/**
 * Convert thread-id to Socket.IO value.
 * @param tid thread-id.
 * @return Socket.IO value.
 */
sio::message::ptr get_sio_by_tid(vtid_t tid) {
  return get_sio_by_str(Convert::vtid2str(tid));
}

/**
 * Convert virtual-address by key from Socket.IO value.
 * @param data Pointer to Socket.IO map.
 * @param key Key in map.
 * @return Value as virtual-address in map.
 */
vaddr_t get_addr_by_map(sio::message::ptr data, const std::string& key) {
  return Convert::str2vaddr(get_str_by_map(data, key));
}

/**
 * Convert virtual-address to Socket.IO value.
 * @param addr Virtual address.
 * @return Socket.IO value.
 */
sio::message::ptr get_sio_by_addr(vaddr_t addr) {
  return get_sio_by_str(Convert::vaddr2str(addr));
}

/**
 * Get node-id value by key from Socket.IO map.
 * @param data Pointer to Socket.IO map.
 * @param key Key in map.
 * @return Value as node-id in map.
 */
nid_t get_nid_by_map(sio::message::ptr data, const std::string& key) {
  return Convert::str2nid(get_str_by_map(data, key));
}

/**
 * Convert node-id to Socket.IO value.
 * @param nid node-id.
 * @return Socket.IO value.
 */
sio::message::ptr get_sio_by_nid(nid_t nid) {
  return get_sio_by_str(Convert::nid2str(nid));
}

/**
 * NetworkConnector instance getter as singleton pattern.
 * @return The singleton instance of NetworkConnector class.
 */
NetworkConnector& NetworkConnector::get_instance() {
  static NetworkConnector instance;
  return instance;
}

/**
 * Constructor for singleton pattern.
 * This class is singleton.
 * This method is private.
 */
NetworkConnector::NetworkConnector() :
    status(ServerStatus::CLOSE) {
}

/**
 * Destructor, close Socket.IO.
 */
NetworkConnector::~NetworkConnector() {
  disconnect();
}

/**
 * Initialize for NetworkConnector.
 * @param loop_ Loop for NetworkConnector.
 * @param url Server's URL.
 */
void NetworkConnector::initialize(uv_loop_t* loop_, const std::string& url) {
  assert(status == ServerStatus::CLOSE);

  loop = loop_;
  status = ServerStatus::SETUP;
  initialize_async();
  initialize_socketio(url);
}

/**
 * Disconnect from the server.
 */
void NetworkConnector::disconnect() {
  client.sync_close();
  client.clear_con_listeners();
  uv_close(reinterpret_cast<uv_handle_t*>(&async_receive), nullptr);
}

/**
 * Get server connection status.
 * @return ServerConnection status.
 */
ServerStatus::Type NetworkConnector::get_status() {
  std::lock_guard<std::mutex> guard(sio_mutex);
  return status;
}

/**
 * Relay command to another node by throgh server.
 * Packet format: {
 *   pid: &lt;Target process-id&gt;
 *   dst_nid: &lt;Destination node-id&gt;
 *   src_nid: &lt;This node-id, added by server&gt;
 *   module: &lt;Module type&gt;
 *   content: &lt;Content of command packet&gt;
 * }
 * @param packet Command packet.
 */
void NetworkConnector::send_relay_command(const CommandPacket& packet) {
  sio::message::ptr sio_packet(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = sio_packet->get_map();

  map.insert(std::make_pair("pid", get_sio_by_pid(packet.pid)));
  map.insert(std::make_pair("dst_nid", get_sio_by_nid(packet.dst_nid)));
  map.insert(std::make_pair("module",
                            get_sio_by_str(Convert::int2str<Module::Type>(packet.module))));
  map.insert(std::make_pair("content",
                            get_sio_by_str(picojson::value(packet.content).serialize())));

  socket->emit("relay_command", sio_packet);
}

/**
 * Send connect-node command.
 * Packet format: {<br/>
 *   account: &lt;account&gt;,<br/>
 *   password: &lt;password&gt;<br/>
 * }<br/>
 * @param account Account name.
 * @param password Passward for account.
 */
void NetworkConnector::send_connect_node(const std::string& account,
                                        const std::string& password) {
  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();

  assert(status == ServerStatus::APPROACH1);

  map.insert(std::make_pair("account",  sio::string_message::create(account)));
  map.insert(std::make_pair("password", sio::string_message::create(password)));

  socket->emit("connect_node", data);
}

/**
 * Send load llvm command.
 * Packet format: {
 *   name: &lt;Application name&gt;,
 *   file: &lt;File content(binary)&gt;,
 *   args: [&lt;arg1&gt;, &lt;arg2&gt;,...],
 *   pid: &lt;pid&gt;,
 *   dst_nid: &lt;Destination node-id&gt;
 * }
 * @param name Application name.
 * @param file File content(binary).
 * @param args List of arguments for program.
 * @param dst_nid Destination node-id.
 */
void NetworkConnector::send_load_llvm(const std::string& name,
                                     const std::string& file,
                                     const std::vector<std::string>& args,
                                     const vpid_t& pid,
                                     const nid_t& dst_nid) {
  sio::message::ptr data(sio::object_message::create());
  sio::message::ptr args_ptr(sio::array_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();
  std::vector<sio::message::ptr>& args_vtr = args_ptr->get_vector();

  map.insert(std::make_pair("name", sio::string_message::create(name)));
  map.insert(std::make_pair("file", sio::binary_message::create
                            (std::shared_ptr<const std::string>(new std::string(file)))));
  for (auto& arg : args) {
    args_vtr.push_back(sio::string_message::create(arg));
  }
  map.insert(std::make_pair("args", args_ptr));
  map.insert(std::make_pair("pid", get_sio_by_pid(pid)));
  map.insert(std::make_pair("dst_nid", get_sio_by_nid(dst_nid)));

  socket->emit("load_llvm", data);
}

/**
 * Send node bind command.
 * Packet format: {
 *   nid: &lt;Node-id just using or empty if not assigned&gt;,
 *   node_name: &lt;Name of node&gt;
 * }
 * @param nid Node-id just using or empty string if not assigned.
 * @param node_name Name of node.
 */
void NetworkConnector::send_bind_node(const nid_t& nid,
                                     const std::string& node_name) {
  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();

  assert(status == ServerStatus::APPROACH2);

  if (!nid.empty()) {
    map.insert(std::make_pair("nid", get_sio_by_nid(nid)));
  }
  map.insert(std::make_pair("node_name", sio::string_message::create(node_name)));

  socket->emit("bind_node", data);
}

/**
 * Send console for test.
 * @param pid Source pid.
 * @param dev Device name (stdout/stderr).
 * @param payload output stream or text.
 */
void NetworkConnector::send_test_console(const vpid_t& pid,
                                        const std::string& dev,
                                        const std::string& payload) {
#ifndef NDEBUG
  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();

  map.insert(std::make_pair("pid", get_sio_by_pid(pid)));
  map.insert(std::make_pair("dev", sio::string_message::create(dev)));
  map.insert(std::make_pair("payload", sio::binary_message::create
                            (std::shared_ptr<const std::string>(new std::string(payload)))));

  socket->emit("test_console", data);
#endif
}

/**
 * When receive async event by Socket.IO's thread, expand a packet and call capable method.
 * @param handle Not use.
 */
void NetworkConnector::on_recv(uv_async_t* handle) {
  NetworkConnector& THIS = NetworkConnector::get_instance();

  while (true) {
    std::string name;
    sio::message::ptr data;
    {
      std::lock_guard<std::mutex> guard(THIS.sio_mutex);
      if (THIS.sio_queue.empty()) break;
      auto front = THIS.sio_queue.front();
      name = front.first;
      data = front.second;
      THIS.sio_queue.pop();
    }

    if (name == "sys_error") {
      /// @todo
      assert(false);

    } else if (name == "app_error") {
      /// @todo
      assert(false);

    } else if (name == "connect_node") {
      THIS.recv_connect_node(data);

    } else if (name == "bind_node") {
      THIS.recv_bind_node(data);

    } else if (name == "relay_command") {
      THIS.recv_relay_command(data);

    } else if (name == "test_console") {
      /// @todo
      assert(false);

    } else {
      /// @todo error
      assert(false);
    }
  }
}

/**
 * Event listener for Socket.IO's close event.
 * Change status to CLOSE without CONNECT_FAILD or BIND_FAILED.
 * Because CONNECT_FAILD and BIND_FAILED are containing CLOSE status,
 * and these status tell why had the node closed by server.
 */
void NetworkConnector::on_close() {
  std::lock_guard<std::mutex> guard(sio_mutex);
  sio_cond.notify_all();
  if (status != ServerStatus::CONNECT_FAILED && status != ServerStatus::BIND_FAILED) {
    status = ServerStatus::CLOSE;
  }
}

/**
 * Event listener for Socket.IO's fail event.
 */
void NetworkConnector::on_fail() {
  std::lock_guard<std::mutex> guard(sio_mutex);
  sio_cond.notify_all();
  status = ServerStatus::ERROR;
}

/**
 * Event listener for Socket.IO's connect event.
 */
void NetworkConnector::on_open() {
  std::lock_guard<std::mutex> guard(sio_mutex);
  sio_cond.notify_all();
  status = ServerStatus::APPROACH1;
}

/**
 * Initialize synchronizer.
 */
void NetworkConnector::initialize_async() {
  uv_async_init(loop, &async_receive, on_recv);
}

/**
 * Initialize Socket.IO, bind event listener and connect to server.
 * @param url Server's URL.
 */
void NetworkConnector::initialize_socketio(const std::string& url) {
  // Bind basic event to Socket.IO.
  client.set_close_listener(std::bind(&NetworkConnector::on_close, this));
  client.set_fail_listener(std::bind(&NetworkConnector::on_fail, this));
  client.set_open_listener(std::bind(&NetworkConnector::on_open, this));

  client.connect(url);
  {
    std::lock_guard<std::mutex> guard(sio_mutex);
    if (status == ServerStatus::SETUP) {
      sio_cond.wait(sio_mutex);
    }
  }

  if (status == ServerStatus::APPROACH1) {
    socket = client.socket();

  } else {
    throw_error(Error::NETWORK);
  }

  // Bind 'on' event to Socket.IO.
#define M_BIND_SOCKETIO_EVENT(_name) {                                  \
    socket->on(_name,                                                   \
               [&](sio::event& event) {                                 \
                 std::lock_guard<std::mutex> guard(sio_mutex);          \
                 sio_queue.push(make_pair(_name, event.get_message())); \
                 uv_async_send(&async_receive);                         \
               });                                                      \
  }

  M_BIND_SOCKETIO_EVENT("sys_error");
  M_BIND_SOCKETIO_EVENT("app_error");
  M_BIND_SOCKETIO_EVENT("connect_node");
  M_BIND_SOCKETIO_EVENT("bind_node");
  M_BIND_SOCKETIO_EVENT("relay_command");
  M_BIND_SOCKETIO_EVENT("test_console");

#undef M_BIND_SOCKETIO_EVENT
}

/**
 * When receive bind-node command's reply,
 * change status to CONNECT and call Router's method.
 * Receive data having member 'result',0 means success, other means error code.
 * Receive data having member 'nid' is assigned node-id for this node.
 * @param data Receive data.
 */
void NetworkConnector::recv_bind_node(sio::message::ptr data) {
  Router& router = Router::get_instance();

  assert(status == ServerStatus::APPROACH2);

  if (data->get_map().at("result")->get_int() == 0) {
    {
      std::lock_guard<std::mutex> guard(sio_mutex);
      status = ServerStatus::CONNECT;
    }
    router.recv_bind_node(get_nid_by_map(data, "nid"));

  } else {
    {
      std::lock_guard<std::mutex> guard(sio_mutex);
      status = ServerStatus::BIND_FAILED;
    }
    disconnect();
  }
}

/**
 * When recieve connect-node command's reply,
 * change status to APPROACH2 and call Router's method.
 * Receive data having member 'result',0 means success, other means error code.
 * @param data Receive data.
 */
void NetworkConnector::recv_connect_node(sio::message::ptr data) {
  Router& router = Router::get_instance();

  assert(status == ServerStatus::APPROACH1);

  if (data->get_map().at("result")->get_int() == 0) {
    {
      std::lock_guard<std::mutex> guard(sio_mutex);
      status = ServerStatus::APPROACH2;
    }
    router.recv_connect_node();

  } else {
    {
      std::lock_guard<std::mutex> guard(sio_mutex);
      status = ServerStatus::CONNECT_FAILED;
    }
    disconnect();
  }
}

/**
 * When receive relay_command packet from server, check if me should receive it, and relay to capable modules.
 * @param data Received data.
 */
void NetworkConnector::recv_relay_command(sio::message::ptr data) {
  Router& router = Router::get_instance();
  const nid_t& dst_nid = get_nid_by_map(data, "dst_nid");
  const nid_t& src_nid = get_nid_by_map(data, "src_nid");
  const nid_t& my_nid  = router.get_my_nid();

  assert(status == ServerStatus::CONNECT);

  if (dst_nid == my_nid ||
      (dst_nid == NID::BROADCAST && src_nid != my_nid)) {
    const vpid_t& pid = get_pid_by_map(data, "pid");
    Module::Type module = Convert::str2int<Module::Type>(get_str_by_map(data, "module", true));
    const std::string& content = get_str_by_map(data, "content", true);

    picojson::value v;
    std::istringstream is(content);
    std::string err = picojson::parse(v, is);
    if (!err.empty()) {
      /// @todo error
      assert(false);
    }

    CommandPacket packet = {
      pid,
      dst_nid,
      src_nid,
      module,
      v.get<picojson::object>()
    };

    router.relay_command(packet, true);
  }
}
}  // namespace processwarp
