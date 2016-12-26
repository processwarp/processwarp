
#include <uv.h>

#include <cassert>
#include <string>
#include <vector>

#include "constant.hpp"
#include "constant_native.hpp"
#include "convert.hpp"
#include "frontend_connector.hpp"
#include "router.hpp"
#include "net/webrtc/server_connector.hpp"
#include "worker_connector.hpp"

namespace processwarp {
/**
 * FrontendConnector instance getter as singleton pattern.
 * @return The singleton instance of FrontendConnector class.
 */
FrontendConnector& FrontendConnector::get_instance() {
  static FrontendConnector instance;
  return instance;
}

/**
 * Constructor for singleton pattern.
 * Set default value to instance members.
 * This class is singleton.
 * This method is private.
 */
FrontendConnector::FrontendConnector() :
    pipe(nullptr),
    connect_status(ConnectStatus::CLOSE) {
}

/**
 * Initialize for FrontendConnector.
 * Create UNIX domain socket for controller.
 * @param loop libuv's loop for WorkerConnector.
 * @param pipe_path Path of pipe that for connecting with worker.
 * @param common_key_ The common key for authenticate.
 */
void FrontendConnector::initialize(uv_loop_t* loop, const std::string& pipe_path,
                                   const std::string& common_key_) {
  common_key = common_key_;
  Connector::initialize(loop, pipe_path);
}


/**
 * Send create command to the GUi type frontend.
 * @param pid Target process-id.
 */
void FrontendConnector::create_gui(const vpid_t& pid) {
  assert(pid != PID::BROADCAST);

  if (pipe == nullptr || frontend_type != FrontendType::GUI) {
    /// @todo error
    assert(false);
  }

  picojson::object data;
  data.insert(std::make_pair("command", picojson::value(std::string("create"))));
  data.insert(std::make_pair("pid", Convert::vpid2json(pid)));

  send_data(*pipe, data);
}

/**
 * Relay packet to frontend.
 * @param packet A packet relay to frontend.
 */
void FrontendConnector::relay_packet(const Packet& packet) {
  assert(packet.dst_module & Module::CONTROLLER || packet.dst_module & Module::GUI);

  if (pipe == nullptr) return;

  picojson::object data;
  data.insert(std::make_pair("command", picojson::value(std::string("relay_packet"))));
  data.insert(std::make_pair("packet_id", Convert::int2json(packet.packet_id)));
  data.insert(std::make_pair("packet_command", picojson::value(packet.command)));
  data.insert(std::make_pair("mode", Convert::int2json(packet.mode)));
  data.insert(std::make_pair("dst_module", Convert::int2json(packet.dst_module)));
  data.insert(std::make_pair("src_module", Convert::int2json(packet.src_module)));
  data.insert(std::make_pair("pid", Convert::vpid2json(packet.pid)));
  data.insert(std::make_pair("dst_nid", packet.dst_nid.to_json()));
  data.insert(std::make_pair("src_nid", packet.src_nid.to_json()));
  data.insert(std::make_pair("content", picojson::value(packet.content)));

  send_data(*pipe, data);
}

/**
 * When connect to server has success, change status and send reply packet to frontend.
 * @param server_connector Instance call from.
 * @param my_nid Node-id for this node.
 */
void FrontendConnector::server_connector_connect_on_success(
    ServerConnector& server_connector, const NodeID& my_nid) {
  assert(connect_status == ConnectStatus::AUTH);

  connect_status = ConnectStatus::CONNECT;
  reply_authenticate(*pipe, 0, my_nid);
}

/**
 * When connect to server has failed, change status and send reply packet to frontend.
 * @param server_connector Instance call from.
 * @param code Error code.
 */
void FrontendConnector::server_connector_connect_on_failure(
    ServerConnector& server_connector, int code) {
  reply_authenticate(*pipe, code, NodeID::NONE);
  connect_status = ConnectStatus::OPEN;
}

/**
 * When accept pipe without another one, seve it and change status to BEGIN.
 * When another pipe has exist yet, close new pipe.
 * @param client Pipe connect with controller by libuv.
 */
void FrontendConnector::on_connect(uv_pipe_t& client) {
  if (pipe == nullptr) {
    pipe = &client;
    connect_status = ConnectStatus::BEGIN;

  } else {
    /// @todo send refuse message;
    close(client);
  }
}

/**
 * When receive data, call capable methods.
 * @param client Frontend pipe that send this packet.
 * @param data Packet.
 */
void FrontendConnector::on_recv_data(uv_pipe_t& client, picojson::object& data) {
  const std::string& command = data.at("command").get<std::string>();

  if (command == "relay_packet") {
    recv_relay_packet(client, data);

  } else if (command == "open") {
    recv_open(client, data);

  } else if (command == "authenticate") {
    recv_authenticate(client, data);

  } else if (command == "open_file") {
    recv_open_file(client, data);

  } else {
    /// @todo error
    assert(false);
  }
}

/**
 * When close pipe, remove status from properties.
 * If client type is GUI, set GUI pipe null.
 * @param client Target pipe to close.
 */
void FrontendConnector::on_close(uv_pipe_t& client) {
  if (pipe == &client) {
    pipe = nullptr;
    connect_status = ConnectStatus::CLOSE;
  }
}

/**
 * When receive authenticate command from frontend, change status to AUTH and try connect to server.
 * @param client Frontend that passed this request.
 * @param param Parameter contain account, password.
 */
void FrontendConnector::recv_authenticate(uv_pipe_t& client, picojson::object& param) {
  ServerConnector& server = ServerConnector::get_instance();
  const std::string& account = param.at("account").get<std::string>();
  const std::string& password = param.at("password").get<std::string>();

  if (connect_status == ConnectStatus::OPEN) {
    connect_status = ConnectStatus::AUTH;
    server.connect(this, account, password);

  } else {
    /// @todo error
    close(*pipe);
    return;
  }
}

/**
 * When receive open command from frontend, change status to OPEN if the common key is
 * the same to passed by then pipe.
 * @param client Frontend that passed this request.
 * @param param Parameter contain common key, frontend type.
 */
void FrontendConnector::recv_open(uv_pipe_t& client, picojson::object& param) {
  const std::string& type = param.at("type").get<std::string>();

  if (connect_status != ConnectStatus::BEGIN) {
    /// @todo error
    close(*pipe);
    return;
  }

  if (type == "gui") {
    frontend_type = FrontendType::GUI;

  } else if (type == "cui") {
    frontend_type = FrontendType::CUI;

  } else {
    reply_open(client, -1);
    close(*pipe);
    return;
  }

  // Check common key.
  if (common_key.empty()) {
    connect_status = ConnectStatus::OPEN;
    reply_open(client, 0);
    return;

  } else {
    if (param.find("key") != param.end()) {
      const std::string& client_common_key = param.at("key").get<std::string>();
      if (client_common_key == common_key) {
        connect_status = ConnectStatus::OPEN;
        reply_open(client, 0);
        return;
      }
    }
  }

  reply_open(client, -1);
  close(*pipe);
}

/**
 * When receive open_file command from frontend, pass capable method on Router.
 * @param client Frontend that passed this request.
 * @param param Parameter contain a filename to open.
 */
void FrontendConnector::recv_open_file(uv_pipe_t& client, picojson::object& param) {
  Router& router = Router::get_instance();

  router.load_llvm(param.at("filename").get<std::string>(), std::vector<std::string>());
}

/**
 * When receive relay_packet from frontend, decode packet and pass it to router.
 * @param client Frontend that passed this request.
 * @param content Data contain target module, pid, content of command.
 */
void FrontendConnector::recv_relay_packet(uv_pipe_t& client, picojson::object& content) {
    Packet packet = {
      Convert::json2int<uint32_t>(content.at("packet_id")),
      content.at("packet_command").get<std::string>(),
      Convert::json2int<PacketMode::Type>(content.at("mode")),
      Convert::json2int<Module::Type>(content.at("dst_module")),
      Convert::json2int<Module::Type>(content.at("src_module")),
      Convert::json2vpid(content.at("pid")),
      NodeID::from_json(content.at("dst_nid")),
      NodeID::NONE,
      content.at("content").get<picojson::object>()
    };

    Router& router = Router::get_instance();
    router.relay_from_local(packet);
}

/**
 * Send authenticate reply command.
 * @param client Target frontend.
 * @param result Result code.
 * @param my_nid Node-id for this node.
 */
void FrontendConnector::reply_authenticate(uv_pipe_t& client, int result, const NodeID& my_nid) {
  picojson::object data;

  data.insert(std::make_pair("command", picojson::value(std::string("authenticate"))));
  data.insert(std::make_pair("result",  picojson::value(static_cast<double>(result))));
  data.insert(std::make_pair("my_nid",  my_nid.to_json()));

  send_data(client, data);
}

/**
 * Send open reply command.
 * @param client Target frontend.
 * @param result Result code.
 */
void FrontendConnector::reply_open(uv_pipe_t& client, int result) {
  picojson::object data;

  data.insert(std::make_pair("command", picojson::value(std::string("open"))));
  data.insert(std::make_pair("result",  picojson::value(static_cast<double>(result))));

  send_data(client, data);
}
}  // namespace processwarp
