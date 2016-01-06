
#include <uv.h>

#include <cassert>
#include <string>
#include <vector>

#include "convert.hpp"
#include "daemon_define.hpp"
#include "frontend_connector.hpp"
#include "router.hpp"
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
 * @param loop libuv's loop for WorkerConnector.
 * @param pipe_path Path of pipe that for connecting with worker.
 */
void FrontendConnector::initialize(uv_loop_t* loop, const std::string& pipe_path) {
  Connector::initialize(loop, pipe_path);
}


/**
 * Send create command to the GUi type frontend.
 * @param pid Target process-id.
 */
void FrontendConnector::create_gui(const vpid_t& pid) {
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
 * Relay packet to frontend.
 * Packet format: {<br/>
 *   command: 'relay_command',
 *   pid: &lt;Process-id send from&gt;
 *   content: &lt;GUI command&gt;
 * }
 * @param pid Target process-id.
 * @param content A Packet data binary formatted.
 */
void FrontendConnector::relay_frontend_packet(const vpid_t& pid, const std::string& content) {
  if (gui_pipe == nullptr) {
    /// @todo error
    assert(false);
  }

  picojson::object data;
  data.insert(std::make_pair("command", picojson::value(std::string("relay_packet"))));
  data.insert(std::make_pair("pid", Convert::vpid2json(pid)));
  data.insert(std::make_pair("content", picojson::value(content)));

  send_data(*gui_pipe, data);
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
 * When receive connect-frontend command from frontend, check account.
 * Reply code 0 if account is valid, and change status to CONNECT.
 * Reply code -1 if account is invalid.
 * If client type is GUI, set GUI pipe to this pipe.
 * @param client Frontend that passed this request.
 * @param param Parameter contain account, password, frontend type.
 */
void FrontendConnector::recv_connect_frontend(uv_pipe_t& client, picojson::object& param) {
  Router& router = Router::get_instance();
  const std::string& type = param.at("type").get<std::string>();
  FrontendProperty& property = properties.at(&client);

  assert(property.status == PipeStatus::SETUP);

  if (type == "gui") {
    property.type = FrontendType::GUI;

  } else if (type == "cui") {
    property.type = FrontendType::CUI;

  } else {
    /// @todo error
    assert(false);
  }

  if (router.check_account(param.at("account").get<std::string>(),
                           param.at("password").get<std::string>())) {
    if (property.type == FrontendType::GUI) {
      if (gui_pipe == nullptr) {
        gui_pipe = &client;

      } else {
        send_connect_frontend(client, -1);
        close(client);
        return;
      }
    }
    send_connect_frontend(client, 0);
    property.status = PipeStatus::CONNECT;

  } else {
    send_connect_frontend(client, -1);
    close(client);
  }
}

/**
 * When receive open-file command from frontend, pass capable method on Router.
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
  InnerModule::Type module = Convert::json2int<InnerModule::Type>(content.at("module"));

  switch (module) {
    case InnerModule::MEMORY:
    case InnerModule::VM: {
      WorkerConnector& worker = WorkerConnector::get_instance();
      worker.relay_command(Convert::json2vpid(content.at("pid")), module,
                           content.at("content").get<picojson::object>());
    } break;

    case InnerModule::SCHEDULER: {
      Router& router = Router::get_instance();
      router.relay_command(Convert::json2vpid(content.at("pid")),
                           content.at("content").get<picojson::object>());
    } break;

    default: {
      /// @todo error
      assert(false);
    }
  }
}

/**
 * Send connect-frontend reply to frontend.
 * Packet format: {<br/>
 *   command: 'connect_frontend',
 *   result:  &lt;Result code&gt;
 * }
 * @param client Target frontend.
 * @param result Result code.
 */
void FrontendConnector::send_connect_frontend(uv_pipe_t& client, int result) {
  picojson::object data;

  data.insert(std::make_pair("command", picojson::value(std::string("connect_frontend"))));
  data.insert(std::make_pair("result",  picojson::value(static_cast<double>(result))));

  send_data(client, data);
}
}  // namespace processwarp
