
#include <cassert>
#include <map>
#include <memory>
#include <string>
#include <vector>

#include "convert.hpp"
#include "core_mid.hpp"
#include "daemon/router.hpp"
#include "error.hpp"
#include "logger.hpp"
#include "server_connector.hpp"
#include "utils.hpp"
#include "webrtc_connector.hpp"

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
NodeID get_nid_by_map(sio::message::ptr data, const std::string& key) {
  return NodeID::from_str(get_str_by_map(data, key));
}

/**
 * Convert node-id to Socket.IO value.
 * @param nid node-id.
 * @return Socket.IO value.
 */
sio::message::ptr get_sio_by_nid(const NodeID& nid) {
  return get_sio_by_str(nid.to_str());
}

/**
 * Simple destructor for vtable.
 */
ServerConnectorConnectDelegate::~ServerConnectorConnectDelegate() {
}

/**
 * ServerConnector instance getter as singleton pattern.
 * @return The singleton instance of ServerConnector class.
 */
ServerConnector& ServerConnector::get_instance() {
  static ServerConnector instance;
  return instance;
}

/**
 * Constructor for singleton pattern.
 * This class is singleton.
 * This method is private.
 */
ServerConnector::ServerConnector() :
    connect_status(ConnectStatus::CLOSE) {
}

/**
 * Destructor, close Socket.IO.
 */
ServerConnector::~ServerConnector() {
  disconnect();
}

/**
 * Try to connect to the server by Socket.IO.
 * Save account and hashed password, use for auth command after open the connection.
 * @param delegate
 * @param account_ The account string to sign-in.
 * @param password_ The password row string to sign-in.
 */
void ServerConnector::connect(ServerConnectorConnectDelegate* delegate,
                              const std::string& account_, const std::string& password_) {
  connect_delegate = delegate;
  account = account_;

  std::string hash_password = password_;
  for (int i = 0; i < 10; i ++) {
    hash_password = Utils::calc_sha256(hash_password);
  }
  password = "[10sha256]" + hash_password;
  is_auth_yet = false;

  if (connect_status != ConnectStatus::OPEN) {
    connect_socketio();
  }

  Logger::info(CoreMid::L1009, url.c_str());

  send_auth();
}

/**
 * Disconnect from the server.
 */
void ServerConnector::disconnect() {
  client.sync_close();
  client.clear_con_listeners();
  uv_close(reinterpret_cast<uv_handle_t*>(&async_receive), nullptr);
}

/**
 * Get server connection status.
 * @return ServerConnection status.
 */
ConnectStatus::Type ServerConnector::get_status() {
  Lock::Guard guard(sio_mutex);
  return connect_status;
}

/**
 * Initialize for ServerConnector.
 * @param loop_ Loop for ServerConnector.
 * @param url_ Server's URL.
 */
void ServerConnector::initialize(uv_loop_t* loop_, const std::string& url_) {
  assert(connect_status == ConnectStatus::CLOSE);

  loop  = loop_;
  url   = url_;
  connect_delegate  = nullptr;
  initialize_async();
  initialize_socketio();
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
void ServerConnector::send_auth() {
  assert(connect_status == ConnectStatus::OPEN);

  connect_status = ConnectStatus::AUTH;

  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();

  map.insert(std::make_pair("account",  sio::string_message::create(account)));
  map.insert(std::make_pair("password", sio::string_message::create(password)));

  socket->emit("auth", data);
}

/**
 * Send init_webrtc_deny command to the server.
 * @param prime_nid Prime node-id of WebRTC initialize sequence.
 * @param reason Reason code to deny.
 */
void ServerConnector::send_init_webrtc_deny(const NodeID& prime_nid, const int reason) {
  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();

  map.insert(std::make_pair("type", sio::string_message::create("deny")));

  picojson::object content;
  content.insert(std::make_pair("prime_nid", prime_nid.to_json()));
  content.insert(std::make_pair("reason", Convert::int2json(reason)));
  map.insert(std::make_pair("content",
                            sio::string_message::create(picojson::value(content).serialize())));

  socket->emit("init_webrtc", data);
}

/**
 * Send init_webrtc_reply command to the server.
 * @param prime_nid Prime node-id of WebRTC initialize sequence.
 * @param second_nid Second node-id.
 * @param sdp SDP string.
 */
void ServerConnector::send_init_webrtc_reply(const NodeID& prime_nid, const NodeID& second_nid,
                                             const std::string& sdp) {
  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();

  map.insert(std::make_pair("type", sio::string_message::create("reply")));

  picojson::object content;
  content.insert(std::make_pair("prime_nid", prime_nid.to_json()));
  content.insert(std::make_pair("second_nid", second_nid.to_json()));
  content.insert(std::make_pair("sdp", picojson::value(sdp)));
  map.insert(std::make_pair("content",
                            sio::string_message::create(picojson::value(content).serialize())));

  socket->emit("init_webrtc", data);
}

/**
 * Send init_webrtc command with ICE data.
 * @param local_nid Node-id of local node.
 * @param remote_nid Node-id of remote node.
 * @param ice ICE string generated by WebRTC.
 */
void ServerConnector::send_init_webrtc_ice(const NodeID& local_nid, const NodeID& remote_nid,
                                           const std::string& ice) {
  assert(connect_status == ConnectStatus::CONNECT);

  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();

  map.insert(std::make_pair("type", sio::string_message::create("ice")));

  picojson::object content;
  content.insert(std::make_pair("local_nid", local_nid.to_json()));
  content.insert(std::make_pair("remote_nid", remote_nid.to_json()));
  content.insert(std::make_pair("ice", picojson::value(ice)));
  map.insert(std::make_pair("content",
                            sio::string_message::create(picojson::value(content).serialize())));

  socket->emit("init_webrtc", data);
}

/**
 * Send init_webrtc command with offer SDP data.
 * @param prime_nid Node-id of node that is begin initializeing.
 * @param sdp SDP string generated by WebRTC on the prime node.
 */
void ServerConnector::send_init_webrtc_offer(const NodeID& prime_nid, const std::string& sdp) {
  assert(connect_status == ConnectStatus::CONNECT);

  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();

  map.insert(std::make_pair("type", sio::string_message::create("offer")));

  picojson::object content;
  content.insert(std::make_pair("prime_nid", prime_nid.to_json()));
  content.insert(std::make_pair("sdp", picojson::value(sdp)));
  map.insert(std::make_pair("content",
                            sio::string_message::create(picojson::value(content).serialize())));

  socket->emit("init_webrtc", data);
}

/**
 * Send init_webrtc command with fin signal.
 * @param prime_nid Node-id of prime (offer sender) node.
 */
void ServerConnector::send_init_webrtc_fin(const NodeID& prime_nid) {
  assert(connect_status == ConnectStatus::CONNECT);

  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();

  map.insert(std::make_pair("type", sio::string_message::create("fin")));

  picojson::object content;
  content.insert(std::make_pair("prime_nid", prime_nid.to_json()));
  map.insert(std::make_pair("content",
                            sio::string_message::create(picojson::value(content).serialize())));

  socket->emit("init_webrtc", data);
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
void ServerConnector::send_load_llvm(const std::string& name,
                                     const std::string& file,
                                     const std::vector<std::string>& args,
                                     const vpid_t& pid,
                                     const NodeID& dst_nid) {
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
 * Send console for test.
 * @param pid Source pid.
 * @param dev Device name (stdout/stderr).
 * @param payload output stream or text.
 */
void ServerConnector::send_test_console(const vpid_t& pid,
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
 * When init_webrtc_deny event occures from webrtc module, send init_webrtc_deny packet to prime node of new connection.
 * @param prime_nid Prime node's id.
 * @param reason Reason to deny.
 */
void ServerConnector::webrtc_connector_on_init_webrtc_deny(const NodeID& prime_nid, int reason) {
  send_init_webrtc_deny(prime_nid, reason);
}

/**
 * When init_webrtc_fin event occures from webrtc module, raise on_success event and send init_webrtc_fin packet to the server.
 */
void ServerConnector::webrtc_connector_on_init_webrtc_fin() {
  connect_delegate->server_connector_connect_on_success(*this, my_nid);
  send_init_webrtc_fin(my_nid);
}

/**
 * When init_webrtc_ice event occurs from webrtc module, send init_webrtc_ice packet to remote node.
 * @param local_nid Local node's id.
 * @param remote_nid Remote node's id.
 * @param ice ICE string.
 */
void ServerConnector::webrtc_connector_on_init_webrtc_ice(
    const NodeID& local_nid, const NodeID& remote_nid, const std::string& ice) {
  send_init_webrtc_ice(local_nid, remote_nid, ice);
}

/**
 * When init_webrtc_offer event occurs from webrtc module, save SDP and send init_webrtc_offer packet to other node.
 * @param sdp Local node's WebRTC SDP string.
 */
void ServerConnector::webrtc_connector_on_init_webrtc_offer(const std::string& sdp) {
  assert(init_sdp.empty());
  init_sdp = sdp;
  send_init_webrtc_offer(my_nid, sdp);
}

/**
 * When init_webrtc_reply event occurs from webrtc module, send init_webrtc_reply packet to prime node.
 * @param prime_nid Prime node's id.
 * @param second_nid Second node's id.
 * @param sdp Local node's SDP string.
 */
void ServerConnector::webrtc_connector_on_init_webrtc_reply(
    const NodeID& prime_nid, const NodeID& second_nid, const std::string& sdp) {
  send_init_webrtc_reply(prime_nid, second_nid, sdp);
}

/**
 * When receive async event by Socket.IO's thread, expand a packet and call capable method.
 * @param handle Not use.
 */
void ServerConnector::on_recv(uv_async_t* handle) {
  ServerConnector& THIS = ServerConnector::get_instance();

  while (true) {
    std::string name;
    sio::message::ptr data;
    {
      Lock::Guard guard(THIS.sio_mutex);
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

    } else if (name == "auth") {
      THIS.recv_auth(data);

    } else if (name == "init_webrtc") {
      THIS.recv_init_webrtc(data);

    } else if (name == "relay") {
      THIS.recv_relay(data);

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
void ServerConnector::on_close() {
  Lock::Guard guard(sio_mutex);
  sio_cond.notify_all();
  connect_status = ConnectStatus::CLOSE;
}

/**
 * Event listener for Socket.IO's fail event.
 */
void ServerConnector::on_fail() {
  Lock::Guard guard(sio_mutex);
  sio_cond.notify_all();
  connect_status = ConnectStatus::CLOSE;
}

/**
 * Event listener for Socket.IO's connect event.
 */
void ServerConnector::on_open() {
  Lock::Guard guard(sio_mutex);
  sio_cond.notify_all();
  connect_status = ConnectStatus::OPEN;
}

void ServerConnector::connect_socketio() {
  assert(connect_status == ConnectStatus::CLOSE);

  connect_status = ConnectStatus::BEGIN;
  client.connect(url);
  {
    Lock::Guard guard(sio_mutex);
    while (connect_status == ConnectStatus::BEGIN) {
      sio_cond.wait(sio_mutex);
    }
  }

  if (connect_status == ConnectStatus::OPEN) {
    socket = client.socket();

  } else {
    throw_error(Error::NETWORK);
  }

  // Bind 'on' event to Socket.IO.
#  define M_BIND_SOCKETIO_EVENT(_name) {                                \
    socket->on(_name,                                                   \
               [&](sio::event& event) {                                 \
                 Lock::Guard guard(sio_mutex);                          \
                 sio_queue.push(make_pair(_name, event.get_message())); \
                 uv_async_send(&async_receive);                         \
               });                                                      \
  }

  M_BIND_SOCKETIO_EVENT("sys_error");
  M_BIND_SOCKETIO_EVENT("app_error");
  M_BIND_SOCKETIO_EVENT("auth");
  M_BIND_SOCKETIO_EVENT("init_webrtc");
  M_BIND_SOCKETIO_EVENT("relay");

#undef M_BIND_SOCKETIO_EVENT
}

/**
 * Initialize synchronizer.
 */
void ServerConnector::initialize_async() {
  uv_async_init(loop, &async_receive, on_recv);
}

/**
 * Initialize Socket.IO, bind event listener and connect to server.
 * @param url Server's URL.
 */
void ServerConnector::initialize_socketio() {
  // Bind basic event to Socket.IO.
  client.set_close_listener(std::bind(&ServerConnector::on_close, this));
  client.set_fail_listener(std::bind(&ServerConnector::on_fail, this));
  client.set_open_listener(std::bind(&ServerConnector::on_open, this));
}

/**
 * Initialize for WebRTC connector.
 * It create initalize connector.
 */
void ServerConnector::initialize_webrtc() {
  if (my_nid == NodeID::NONE) {
    my_nid = NodeID::make_random();
  }

  Router& router = Router::get_instance();
  WebrtcConnector& webrtc = WebrtcConnector::get_instance();
  router.set_nid(my_nid);
  webrtc.set_nid(my_nid);
  webrtc.create_init_edge();
}

/**
 * When recieve connect-node command's reply,
 * change status to APPROACH2 and call Router's method.
 * Receive data having member 'result',0 means success, other means error code.
 * @param data Receive data.
 */
void ServerConnector::recv_auth(sio::message::ptr data) {
  assert(connect_status == ConnectStatus::AUTH);

  if (data->get_map().at("result")->get_int() == 0) {
    {
      Lock::Guard guard(sio_mutex);
      connect_status = ConnectStatus::CONNECT;
    }

    if (!is_auth_yet) {
      is_auth_yet = true;
    }

    Logger::info(CoreMid::L1010, account.c_str());
    initialize_webrtc();

  } else {
    {
      Lock::Guard guard(sio_mutex);
      connect_status = ConnectStatus::OPEN;
      connect_delegate->server_connector_connect_on_failure(*this, -1);
    }
    Logger::info(CoreMid::L1011, account.c_str());
    disconnect();
  }
}

/**
 * When receive init_webrtc command, split by sub type of it and call capable method.
 * @param data Receive data containing type and content.
 */
void ServerConnector::recv_init_webrtc(sio::message::ptr data) {
  const std::string& type = get_str_by_map(data, "type", true);
  const std::string& content_str = get_str_by_map(data, "content", true);

  picojson::value v;
  std::istringstream is(content_str);
  std::string err = picojson::parse(v, is);
  if (!err.empty()) {
    /// @todo error
    assert(false);
  }
  picojson::object& content = v.get<picojson::object>();

  if (type == "deny") {
    recv_init_webrtc_deny(content);

  } else if (type == "ice") {
    recv_init_webrtc_ice(content);

  } else if (type == "offer") {
    recv_init_webrtc_offer(content);

  } else if (type == "reply") {
    recv_init_webrtc_reply(content);

  } else {
    /// @todo error
    assert(false);
  }
}

/**
 * When receive init_webrtc command with deny, retry with re-assign nid if exists duplicate nid.
 * Other wise initialize is finish (another node is not exist.)
 * @param content Receive data containing prime_nid, reason.
 */
void ServerConnector::recv_init_webrtc_deny(const picojson::object& content) {
  Router& router = Router::get_instance();
  WebrtcConnector& webrtc = WebrtcConnector::get_instance();

  switch (Convert::json2int<int>(content.at("reason"))) {
    case 0: {
      // If exists duplicate nid, re-assign nid and send init_sdp command.
      my_nid = NodeID::make_random();
      router.set_nid(my_nid);
      webrtc.set_nid(my_nid);

      send_init_webrtc_offer(my_nid, init_sdp);
    } break;

    case 1: {
      // If another node is not exist, initialize is finish.
      init_sdp.clear();
      webrtc.cancel_init_edge_by_isolation();
      connect_delegate->server_connector_connect_on_success(*this, my_nid);
      send_init_webrtc_fin(my_nid);
    } break;

    default: {
      /// @todo wrong packet
      assert(false);
    } break;
  }
}

/**
 * When receive init_webrtc command with ice, update ICE.
 * @param content Receive data containing local_nid, remote_nid, ice.
 */
void ServerConnector::recv_init_webrtc_ice(const picojson::object& content) {
  NodeID local_nid  = NodeID::from_json(content.at("local_nid"));
  NodeID remote_nid = NodeID::from_json(content.at("remote_nid"));
  const std::string& ice = content.at("ice").get<std::string>();

  WebrtcConnector& webrtc = WebrtcConnector::get_instance();
  webrtc.relay_init_webrtc_ice(local_nid, remote_nid, ice);
}

/**
 * When receive init_webrtc offer command, relay it to target node.
 * @param content Receive data containing prime_nid, sdp.
 */
void ServerConnector::recv_init_webrtc_offer(const picojson::object& content) {
  NodeID prime_nid = NodeID::from_json(content.at("prime_nid"));
  const std::string& sdp = content.at("sdp").get<std::string>();

  WebrtcConnector& webrtc = WebrtcConnector::get_instance();
  webrtc.relay_init_webrtc_offer(prime_nid, sdp);
}

/**
 * When receive init_webrtc command with relay SDP, update initialize connector's nid and SDP.
 * @param content Receive data containing prime_nid, second_nid, sdp.
 */
void ServerConnector::recv_init_webrtc_reply(const picojson::object& content) {
  NodeID prime_nid  = NodeID::from_json(content.at("prime_nid"));
  NodeID second_nid = NodeID::from_json(content.at("second_nid"));
  const std::string& sdp = content.at("sdp").get<std::string>();

  WebrtcConnector& webrtc = WebrtcConnector::get_instance();
  webrtc.relay_init_webrtc_reply(prime_nid, second_nid, sdp);
}

/**
 * When receive relay packet from server, check if me should receive it, and relay to capable modules.
 * @param data Received data.
 */
void ServerConnector::recv_relay(sio::message::ptr data) {
  assert(connect_status == ConnectStatus::CONNECT);

  const std::string& content = get_str_by_map(data, "content", true);
  picojson::value v;
  std::istringstream is(content);
  std::string err = picojson::parse(v, is);
  if (!err.empty()) {
    /// @todo error
    assert(false);
  }

  Packet packet = {
    Convert::str2int<uint32_t>(get_str_by_map(data, "packet_id", true)),
    get_str_by_map(data, "command", true),
    Convert::str2int<PacketMode::Type>(get_str_by_map(data, "mode", true)),
    Convert::str2int<Module::Type>(get_str_by_map(data, "dst_module", true)),
    Convert::str2int<Module::Type>(get_str_by_map(data, "src_module", true)),
    get_pid_by_map(data, "pid"),
    get_nid_by_map(data, "dst_nid"),
    get_nid_by_map(data, "src_nid"),
    v.get<picojson::object>()
  };

  WebrtcConnector& webrtc = WebrtcConnector::get_instance();
  webrtc.relay(packet);
}
}  // namespace processwarp
