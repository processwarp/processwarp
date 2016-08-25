
#include <unistd.h>

#include <cassert>
#include <string>

#include "convert.hpp"
#include "router.hpp"
#include "webrtc_connector.hpp"

namespace processwarp {
WebrtcConnectorDelegate::~WebrtcConnectorDelegate() {
}

/**
 * WebrtcConnector instance getter as singleton pattern.
 * @return The singleton instance of WebrtcConnector class.
 */
WebrtcConnector& WebrtcConnector::get_instance() {
  static WebrtcConnector instance;
  return instance;
}

WebrtcConnector::WebrtcConnector() :
    client_pipe(nullptr),
    delegate(nullptr) {
}

void WebrtcConnector::cancel_init_edge_by_isolation() {
  picojson::object data;
  data.insert(std::make_pair("command", picojson::value(std::string("cancel_init_edge"))));

  send_data(data);
}

void WebrtcConnector::create_init_edge() {
  picojson::object data;
  data.insert(std::make_pair("command", picojson::value(std::string("create_init_edge"))));

  send_data(data);
}

void WebrtcConnector::initialize(WebrtcConnectorDelegate* delegate_, uv_loop_t* loop,
                                 const std::string& pipe_path_, const std::string& message_fname) {
  delegate = delegate_;
  std::string pipe_path = pipe_path_ + "/pw-webrtc-" + Convert::int2str(getpid()) + ".pipe";

  Connector::initialize(loop, pipe_path);

  initialize_subprocess(pipe_path, message_fname);
}

void WebrtcConnector::relay(const Packet& packet) {
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

  send_data(data);
}
void WebrtcConnector::relay_init_webrtc_ice(const NodeID& local_nid, const NodeID& remote_nid,
                                            const std::string& ice) {
  picojson::object data;
  data.insert(std::make_pair("command", picojson::value(std::string("init_webrtc_ice"))));
  data.insert(std::make_pair("local_nid", local_nid.to_json()));
  data.insert(std::make_pair("remote_nid", remote_nid.to_json()));
  data.insert(std::make_pair("ice", picojson::value(ice)));

  send_data(data);
}

void WebrtcConnector::relay_init_webrtc_offer(const NodeID& prime_nid, const std::string& sdp) {
  picojson::object data;
  data.insert(std::make_pair("command", picojson::value(std::string("init_webrtc_offer"))));
  data.insert(std::make_pair("prime_nid", prime_nid.to_json()));
  data.insert(std::make_pair("sdp", picojson::value(sdp)));

  send_data(data);
}

void WebrtcConnector::relay_init_webrtc_reply(const NodeID& prime_nid, const NodeID& second_nid,
                                              const std::string& sdp) {
  picojson::object data;
  data.insert(std::make_pair("command", picojson::value(std::string("init_webrtc_reply"))));
  data.insert(std::make_pair("prime_nid", prime_nid.to_json()));
  data.insert(std::make_pair("second_nid", second_nid.to_json()));
  data.insert(std::make_pair("sdp", picojson::value(sdp)));

  send_data(data);
}

void WebrtcConnector::set_nid(const NodeID& nid) {
  my_nid = nid;

  picojson::object data;
  data.insert(std::make_pair("command", picojson::value(std::string("set_my_nid"))));
  data.insert(std::make_pair("my_nid", nid.to_json()));

  send_data(data);
}

/**
 * When subprocess was finished, close a hundle and remove a property it bundled to worker.
 * @param req
 * @param exit_status
 * @param term_signal
 */
void WebrtcConnector::on_exit(uv_process_t *req, int64_t exit_status, int term_signal) {
  WebrtcConnector& THIS = WebrtcConnector::get_instance();
  uv_close(reinterpret_cast<uv_handle_t*>(&THIS.subprocess), nullptr);
}


void WebrtcConnector::on_connect(uv_pipe_t& client) {
  client_pipe = &client;

  for (auto& it : send_wait) {
    Connector::send_data(*client_pipe, it);
  }
  send_wait.clear();
}

void WebrtcConnector::on_recv_data(uv_pipe_t& client, picojson::object& data) {
  std::string command = data.at("command").get<std::string>();

  if (command == "connect_subprocess") {
    // do nothing.

  } else if (command == "init_webrtc_deny") {
    delegate->webrtc_connector_on_init_webrtc_deny(NodeID::from_json(data.at("prime_nid")),
                                                   Convert::json2int<int>(data.at("reason")));

  } else if (command == "init_webrtc_fin") {
    delegate->webrtc_connector_on_init_webrtc_fin();

  } else if (command == "init_webrtc_ice") {
    delegate->webrtc_connector_on_init_webrtc_ice(NodeID::from_json(data.at("local_nid")),
                                                  NodeID::from_json(data.at("remote_nid")),
                                                  data.at("ice").get<std::string>());

  } else if (command == "init_webrtc_offer") {
    delegate->webrtc_connector_on_init_webrtc_offer(data.at("sdp").get<std::string>());

  } else if (command == "init_webrtc_reply") {
    delegate->webrtc_connector_on_init_webrtc_reply(NodeID::from_json(data.at("prime_nid")),
                                                  NodeID::from_json(data.at("second_nid")),
                                                  data.at("sdp").get<std::string>());

  } else if (command == "relay_to_local") {
    recv_relay_to_local(data);

  } else {
    /// @todo
    std::cerr << __LINE__ << "@" << __FILE__ << " " << command << std::endl;
    assert(false);
  }
}

void WebrtcConnector::on_close(uv_pipe_t& client) {
  assert(false);
}

void WebrtcConnector::initialize_subprocess(const std::string& pipe_path,
                                            const std::string& message_fname) {
  std::string program_path = Util::file_dirname(Util::get_my_fullpath()) + "/webrtc_subprocess";

  char* args[] = {
    // const_cast<char*>(VALGRIND_PATH),
    const_cast<char*>(program_path.c_str()),
    const_cast<char*>(pipe_path.c_str()),
    const_cast<char*>(message_fname.c_str()),
    nullptr
  };

#ifndef WITH_WEBRTC_DEBUG
  uv_stdio_container_t program_stdio[3];
  program_stdio[0].flags = UV_IGNORE;
  program_stdio[1].flags = UV_INHERIT_FD;
  program_stdio[1].data.fd = STDOUT_FILENO;
  program_stdio[2].flags = UV_INHERIT_FD;
  program_stdio[2].data.fd = STDERR_FILENO;

  uv_process_options_t options;
  memset(&options, 0, sizeof(options));
  options.exit_cb = WebrtcConnector::on_exit;
  // options.file    = VALGRIND_PATH;
  options.file    = program_path.c_str();
  options.args    = args;
  options.stdio_count = 3;
  options.stdio   = program_stdio;

  int r = uv_spawn(loop, &subprocess, &options);
  if (r) {
    /// @todo error
    assert(false);
  }
#else
  debug_subprocess.reset(new WebrtcSubprocess());
  debug_subprocess->entry(sizeof(args) / sizeof(args[0]) - 1, args);
#endif
}

void WebrtcConnector::recv_relay_to_local(const picojson::object& content) {
  Packet packet = {
    Convert::json2int<uint32_t>(content.at("packet_id")),
    content.at("packet_command").get<std::string>(),
    Convert::json2int<PacketMode::Type>(content.at("mode")),
    Convert::json2int<Module::Type>(content.at("dst_module")),
    Convert::json2int<Module::Type>(content.at("src_module")),
    Convert::json2vpid(content.at("pid")),
    NodeID::from_json(content.at("dst_nid")),
    NodeID::from_json(content.at("src_nid")),
    content.at("content").get<picojson::object>()
  };

  Router& router = Router::get_instance();
  router.relay_from_global(packet);
}

/**
 * Send data by Connecotr, if connection is enable. Otherwise keep data in queue.
 * @param data A JSON formatten data.
 */
void WebrtcConnector::send_data(const picojson::object& data) {
  if (client_pipe == nullptr) {
    send_wait.push_back(data);
  } else {
    Connector::send_data(*client_pipe, data);
  }
}
}  // namespace processwarp
