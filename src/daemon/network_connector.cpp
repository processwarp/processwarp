
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
#include "webrtc_bundle.hpp"

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
NetworkConnectorConnectDelegate::~NetworkConnectorConnectDelegate() {
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
    connect_status(ConnectStatus::CLOSE) {
}

/**
 * Destructor, close Socket.IO.
 */
NetworkConnector::~NetworkConnector() {
  disconnect();
}

/**
 * Try to connect to the server by Socket.IO.
 * Save account and hashed password, use for auth command after open the connection.
 * @param delegate
 * @param account_ The account string to sign-in.
 * @param password_ The password row string to sign-in.
 */
void NetworkConnector::connect(NetworkConnectorConnectDelegate* delegate,
                               const std::string& account_, const std::string& password_) {
  connect_delegate = delegate;
  account = account_;

  std::string hash_password = password_;
  for (int i = 0; i < 10; i ++) {
    hash_password = Util::calc_sha256(hash_password);
  }
  password = "[10sha256]" + hash_password;
  is_auth_yet = false;

  if (connect_status != ConnectStatus::OPEN) {
    connect_socketio();
  }

  send_auth();
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
ConnectStatus::Type NetworkConnector::get_status() {
  std::lock_guard<std::mutex> guard(sio_mutex);
  return connect_status;
}

/**
 * Initialize for NetworkConnector.
 * @param loop_ Loop for NetworkConnector.
 * @param url_ Server's URL.
 */
void NetworkConnector::initialize(uv_loop_t* loop_, const std::string& url_) {
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
void NetworkConnector::send_auth() {
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
void NetworkConnector::send_init_webrtc_deny(const NodeID& prime_nid, const int reason) {
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
void NetworkConnector::send_init_webrtc_reply(const NodeID& prime_nid, const NodeID& second_nid,
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
void NetworkConnector::send_init_webrtc_ice(const NodeID& local_nid, const NodeID& remote_nid,
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
void NetworkConnector::send_init_webrtc_offer(const NodeID& prime_nid, const std::string& sdp) {
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
void NetworkConnector::send_init_webrtc_fin(const NodeID& prime_nid) {
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
void NetworkConnector::send_load_llvm(const std::string& name,
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
 * Process on change connector's status and it enable connection.
 * Apply connecotr to WebRTC bundler.
 * Rise connect success event on delegate.
 * Send init_webrtc command with fin signal.
 * Tell nid to router module.
 */
void NetworkConnector::webrtc_connector_on_change_stateus(WebrtcConnector& connector,
                                                          bool is_connect) {
  assert(&connector == webrtc_init_connector);

  if (is_connect) {
    Router& router = Router::get_instance();
    WebrtcBundle& webrtc = WebrtcBundle::get_instance();

    router.set_nid(my_nid);
    webrtc.set_nid(my_nid);
    webrtc.apply_connector(webrtc_init_connector);
    webrtc_init_connector = nullptr;
    connect_delegate->network_connector_connect_on_success(*this, NodeID::NONE);
    send_init_webrtc_fin(my_nid);
  }
}

/**
 * When ICE has update, pass it to opposite node.
 * @param connector Connector that event has happen.
 * @param ice ICE string.
 */
void NetworkConnector::webrtc_connector_on_update_ice(WebrtcConnector& connector,
                                                      const std::string ice) {
  assert(&connector == webrtc_init_connector);

  if (connector.nid == NodeID::NONE) {
    webrtc_init_ice.push_back(ice);

  } else {
    send_init_webrtc_ice(my_nid, connector.nid, ice);
  }
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

    } else if (name == "auth") {
      THIS.recv_auth(data);

    } else if (name == "init_webrtc") {
      THIS.recv_init_webrtc(data);

    } else if (name == "relay") {
      THIS.recv_relay(data);

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
  connect_status = ConnectStatus::CLOSE;
}

/**
 * Event listener for Socket.IO's fail event.
 */
void NetworkConnector::on_fail() {
  std::lock_guard<std::mutex> guard(sio_mutex);
  sio_cond.notify_all();
  connect_status = ConnectStatus::CLOSE;
}

/**
 * Event listener for Socket.IO's connect event.
 */
void NetworkConnector::on_open() {
  std::lock_guard<std::mutex> guard(sio_mutex);
  sio_cond.notify_all();
  connect_status = ConnectStatus::OPEN;
}

void NetworkConnector::connect_socketio() {
  assert(connect_status == ConnectStatus::CLOSE);

  connect_status = ConnectStatus::BEGIN;
  client.connect(url);
  {
    std::lock_guard<std::mutex> guard(sio_mutex);
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
  M_BIND_SOCKETIO_EVENT("auth");
  M_BIND_SOCKETIO_EVENT("init_webrtc");
  M_BIND_SOCKETIO_EVENT("relay");
  M_BIND_SOCKETIO_EVENT("test_console");

#undef M_BIND_SOCKETIO_EVENT
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
void NetworkConnector::initialize_socketio() {
  // Bind basic event to Socket.IO.
  client.set_close_listener(std::bind(&NetworkConnector::on_close, this));
  client.set_fail_listener(std::bind(&NetworkConnector::on_fail, this));
  client.set_open_listener(std::bind(&NetworkConnector::on_open, this));
}

/**
 * Start to make WebRTC connector after open connetion with server.
 * Create new connector and send offer to opposite node.
 */
void NetworkConnector::make_init_webrtc_connector() {
  assert(webrtc_init_connector == nullptr);

  WebrtcBundle& webrtc = WebrtcBundle::get_instance();
  webrtc_init_connector = webrtc.create_connector();
  webrtc_init_connector->delegate = this;

  if (my_nid == NodeID::NONE) {
    my_nid = NodeID::make_random();
  }

  send_init_webrtc_offer(my_nid, webrtc_init_connector->get_local_sdp());
}

/**
 * When recieve connect-node command's reply,
 * change status to APPROACH2 and call Router's method.
 * Receive data having member 'result',0 means success, other means error code.
 * @param data Receive data.
 */
void NetworkConnector::recv_auth(sio::message::ptr data) {
  assert(connect_status == ConnectStatus::AUTH);

  if (data->get_map().at("result")->get_int() == 0) {
    {
      std::lock_guard<std::mutex> guard(sio_mutex);
      connect_status = ConnectStatus::CONNECT;
    }

    if (!is_auth_yet) {
      is_auth_yet = true;
    }

    make_init_webrtc_connector();

  } else {
    {
      std::lock_guard<std::mutex> guard(sio_mutex);
      connect_status = ConnectStatus::OPEN;
      connect_delegate->network_connector_connect_on_failure(*this, -1);
    }
    disconnect();
  }
}

/**
 * When receive init_webrtc command, split by sub type of it and call capable method.
 * @param data Receive data containing type and content.
 */
void NetworkConnector::recv_init_webrtc(sio::message::ptr data) {
  const std::string& type = get_str_by_map(data, "type", true);
  const std::string& content_str = get_str_by_map(data, "content", true);

  std::cout << "recv_init_webrtc:" << type << ":" << content_str << std::endl;

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
void NetworkConnector::recv_init_webrtc_deny(const picojson::object& content) {
  switch (Convert::json2int<int>(content.at("reason"))) {
    case 0: {
      // If exists duplicate nid, re-assign nid and send init_sdp command.
      my_nid = NodeID::make_random();
      send_init_webrtc_offer(my_nid, webrtc_init_connector->get_local_sdp());
    } break;

    case 1: {
      // If another node is not exist, initialize is finish.
      Router& router = Router::get_instance();
      WebrtcBundle& webrtc = WebrtcBundle::get_instance();

      webrtc.close_connector(webrtc_init_connector);
      webrtc_init_connector = nullptr;
      connect_delegate->network_connector_connect_on_success(*this, NodeID::NONE);
      send_init_webrtc_fin(my_nid);
      router.set_nid(my_nid);
      webrtc.set_nid(my_nid);
      webrtc_init_ice.clear();
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
void NetworkConnector::recv_init_webrtc_ice(const picojson::object& content) {
  NodeID local_nid  = NodeID::from_json(content.at("local_nid"));
  NodeID remote_nid = NodeID::from_json(content.at("remote_nid"));
  const std::string& ice = content.at("ice").get<std::string>();

  if (webrtc_init_connector == nullptr) {
    WebrtcBundle& webrtc = WebrtcBundle::get_instance();
    webrtc.relay_init_webrtc_ice(local_nid, remote_nid, ice);

  } else if (webrtc_init_connector->nid == local_nid &&
             my_nid == remote_nid) {
    webrtc_init_connector->update_ice(ice);
  }
}

/**
 * When receive init_webrtc offer command, relay it to target node.
 * @param content Receive data containing prime_nid, sdp.
 */
void NetworkConnector::recv_init_webrtc_offer(const picojson::object& content) {
  assert(webrtc_init_connector == nullptr);

  NodeID prime_nid = NodeID::from_json(content.at("prime_nid"));
  const std::string& sdp = content.at("sdp").get<std::string>();
  WebrtcBundle& webrtc = WebrtcBundle::get_instance();

  webrtc.relay_init_webrtc_offer(prime_nid, sdp);
}

/**
 * When receive init_webrtc command with relay SDP, update initialize connector's nid and SDP.
 * @param content Receive data containing prime_nid, second_nid, sdp.
 */
void NetworkConnector::recv_init_webrtc_reply(const picojson::object& content) {
  NodeID prime_nid  = NodeID::from_json(content.at("prime_nid"));
  NodeID second_nid = NodeID::from_json(content.at("second_nid"));
  const std::string& sdp = content.at("sdp").get<std::string>();

  if (webrtc_init_connector == nullptr || prime_nid != my_nid) {
    return;
  }

  webrtc_init_connector->nid = second_nid;
  webrtc_init_connector->set_remote_sdp(sdp);

  for (auto ice : webrtc_init_ice) {
    send_init_webrtc_ice(my_nid, webrtc_init_connector->nid, ice);
  }
}

/**
 * When receive relay packet from server, check if me should receive it, and relay to capable modules.
 * @param data Received data.
 */
void NetworkConnector::recv_relay(sio::message::ptr data) {
  Router& router = Router::get_instance();
  const NodeID& dst_nid = get_nid_by_map(data, "dst_nid");
  const NodeID& src_nid = get_nid_by_map(data, "src_nid");
  const NodeID& my_nid  = router.get_my_nid();

  assert(connect_status == ConnectStatus::CONNECT);

  if (dst_nid == my_nid ||
      (dst_nid == NodeID::BROADCAST && src_nid != my_nid)) {
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

#warning TODO
    /*
    CommandPacket packet = {
      pid,
      dst_nid,
      src_nid,
      module,
      v.get<picojson::object>()
    };

    router.relay_command(packet, true);
    */
  }
}
}  // namespace processwarp
