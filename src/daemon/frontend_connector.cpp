
#include <uv.h>

#include <cassert>
#include <string>
#include <vector>

#include "constant.hpp"
#include "convert.hpp"
#include "daemon_define.hpp"
#include "frontend_connector.hpp"
#include "router.hpp"
#include "server_connector.hpp"
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
    gui_pipe(nullptr) {
}

/**
 * Initialize for FrontendConnector.
 * Create UNIX domain socket for controller.
 * Initialize timer to deal with the connect_frontend packet.
 * @param loop libuv's loop for WorkerConnector.
 * @param pipe_path Path of pipe that for connecting with worker.
 */
void FrontendConnector::initialize(uv_loop_t* loop, const std::string& pipe_path) {
  Connector::initialize(loop, pipe_path);
  initialize_connect_timer();
}


/**
 * Send create command to the GUi type frontend.
 * @param pid Target process-id.
 */
void FrontendConnector::create_gui(const vpid_t& pid) {
  assert(pid != PID::BROADCAST);

  if (gui_pipe == nullptr) {
    /// @todo error
    assert(false);
  }

  picojson::object data;
  data.insert(std::make_pair("command", picojson::value(std::string("create"))));
  data.insert(std::make_pair("pid", Convert::vpid2json(pid)));

  send_data(*gui_pipe, data);
}

/**
 * Relay command to frontend.
 * Packet format: {<br/>
 *   command: 'relay_command',
 *   pid: &lt;Process-id of packet&gt;
 *   dst_nid: &lt;Destination node-id&gt;
 *   src_nid: &lt;Source node-id&gt;
 *   content: &lt;Command content&gt;
 * }
 * @param packet Command packet for relaying.
 */
void FrontendConnector::relay_frontend_command(const CommandPacket& packet) {
  assert(packet.module == Module::CONTROLLER || packet.module == Module::GUI);

  if (gui_pipe == nullptr) return;

  picojson::object data;
  data.insert(std::make_pair("command", picojson::value(std::string("relay_command"))));
  data.insert(std::make_pair("pid", Convert::vpid2json(packet.pid)));
  data.insert(std::make_pair("dst_nid", Convert::nid2json(packet.dst_nid)));
  data.insert(std::make_pair("src_nid", Convert::nid2json(packet.src_nid)));
  data.insert(std::make_pair("module", Convert::int2json(packet.module)));
  data.insert(std::make_pair("content", picojson::value(packet.content)));

  send_data(*gui_pipe, data);
}

/**
 * When timer event has happen and after connecting server,
 * send reply for clients send a connect_frontend packet.
 * After send reply to all clients, turn off the timer event.
 * @param handle Libuv's event handler.
 */
void FrontendConnector::on_connect_timer(uv_timer_t* handle) {
  FrontendConnector& THIS = FrontendConnector::get_instance();
  Router& router = Router::get_instance();
  ServerConnector &server = ServerConnector::get_instance();

  switch (server.get_status()) {
    case ServerStatus::SETUP:
    case ServerStatus::APPROACH1:
    case ServerStatus::APPROACH2:
      return;

    case ServerStatus::CONNECT: {
      for (auto& it_property : THIS.properties) {
        uv_pipe_t* client = it_property.first;
        FrontendProperty& property = it_property.second;

        // Skip if pipe has accept.
        if (property.status == PipeStatus::CONNECT ||
            property.account.empty()) {
          continue;
        }

        if (router.check_account(property.account, property.password)) {
          if (property.type == FrontendType::GUI) {
            if (THIS.gui_pipe == nullptr) {
              THIS.gui_pipe = client;

            } else {
              THIS.send_connect_frontend(*client, -1, NID::NONE);
              THIS.close(*client);
              continue;
            }
          }

          THIS.send_connect_frontend(*client, 0, router.get_my_nid());
          property.status = PipeStatus::CONNECT;
          property.account.clear();
          property.password.clear();

        } else {
          THIS.send_connect_frontend(*client, -1, NID::NONE);
          THIS.close(*client);
        }
      }
    } break;

    case ServerStatus::CONNECT_FAILED:
    case ServerStatus::BIND_FAILED: {
      for (auto& it_property : THIS.properties) {
        uv_pipe_t* client = it_property.first;
        FrontendProperty& property = it_property.second;

        assert(property.status == PipeStatus::SETUP || !property.account.empty());

        THIS.send_connect_frontend(*client, -1, NID::NONE);
      }
    } break;

    case ServerStatus::CLOSE:
    case ServerStatus::ERROR:
      /// @todo send error
      assert(false);

    default:
      assert(false);
  }

  uv_timer_stop(&(THIS.connect_timer));
  THIS.connect_timer_enable = false;
}

/**
 * Create pipe for controller when accept connecting.
 * Set status to SETUP.
 * @param client Pipe connect with controller by libuv.
 */
void FrontendConnector::on_connect(uv_pipe_t& client) {
  FrontendProperty property;

  property.status = PipeStatus::SETUP;
  properties.insert(std::make_pair(&client, property));
}

/**
 * When receive data, call capable methods.
 * @param client Frontend pipe that send this packet.
 * @param data Packet.
 */
void FrontendConnector::on_recv_data(uv_pipe_t& client, picojson::object& data) {
  const std::string& command = data.at("command").get<std::string>();

  if (command == "relay_command") {
    recv_relay_command(client, data);

  } else if (command == "connect_frontend") {
    recv_connect_frontend(client, data);

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
  properties.erase(&client);
  if (gui_pipe == &client) {
    gui_pipe = nullptr;
  }
}

/**
 * Initialize timer event handler but don't start timer.
 * Timer start at connect_frontend command has received to avoid too much processes.
 */
void FrontendConnector::initialize_connect_timer() {
  connect_timer_enable = false;
  uv_timer_init(loop, &connect_timer);
}

/**
 * When receive connect_frontend command from frontend, change client status that
 * the account and password are stored to property, and start timer.
 * @param client Frontend that passed this request.
 * @param param Parameter contain account, password, frontend type.
 */
void FrontendConnector::recv_connect_frontend(uv_pipe_t& client, picojson::object& param) {
  const std::string& type = param.at("type").get<std::string>();
  const std::string& account  = param.at("account").get<std::string>();
  const std::string& password = param.at("password").get<std::string>();
  FrontendProperty& property = properties.at(&client);

  assert(property.status == PipeStatus::SETUP);
  assert(!account.empty() && !password.empty());

  if (type == "gui") {
    property.type = FrontendType::GUI;

  } else if (type == "cui") {
    property.type = FrontendType::CUI;

  } else {
    /// @todo error
    assert(false);
  }

  property.account  = account;
  property.password = password;

  if (!connect_timer_enable) {
    uv_timer_start(&connect_timer, on_connect_timer, 0, 1000);
    connect_timer_enable = true;
  }
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
 * When receive command from frontend, relay to capable module.
 * @param client Frontend that passed this request.
 * @param content Data contain target module, pid, content of command.
 */
void FrontendConnector::recv_relay_command(uv_pipe_t& client, picojson::object& content) {
  CommandPacket packet = {
    Convert::json2vpid(content.at("pid")),
    Convert::json2nid(content.at("dst_nid")),
    NID::NONE,
    Convert::json2int<Module::Type>(content.at("module")),
    content.at("content").get<picojson::object>()
  };

  Router& router = Router::get_instance();
  router.relay_command(packet, false);
}

/**
 * Send connect_frontend command.
 * @param client Target frontend.
 * @param result Result code.
 * @param my_nid 
 */
void FrontendConnector::send_connect_frontend(uv_pipe_t& client, int result, const nid_t& my_nid) {
  picojson::object data;

  data.insert(std::make_pair("command", picojson::value(std::string("connect_frontend"))));
  data.insert(std::make_pair("result",  picojson::value(static_cast<double>(result))));
  data.insert(std::make_pair("my_nid",  Convert::nid2json(my_nid)));

  send_data(client, data);
}
}  // namespace processwarp
