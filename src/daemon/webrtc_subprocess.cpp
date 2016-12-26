
#include <unistd.h>

#include <string>
#include <tuple>

#include "convert.hpp"
#include "daemon_mid.hpp"
#include "logger.hpp"
#include "net/webrtc/webrtc_bundle.hpp"
#include "webrtc_subprocess.hpp"

namespace processwarp {
WebrtcSubprocess::WebrtcSubprocess() :
    init_edge(nullptr) {
}

int WebrtcSubprocess::entry(int argc, char* argv[]) {
  std::string pipe_path;
  std::string message_fname;
  std::tie(pipe_path, message_fname) = read_options(argc, argv);

  Logger::initialize_boot();
  Message::load(message_fname);

  initialize(uv_default_loop());
  connect_pipe(pipe_path);

  WebrtcBundle& webrtc = WebrtcBundle::get_instance();
  webrtc.initialize(this, loop);

  return uv_run(loop, UV_RUN_DEFAULT);
}

void WebrtcSubprocess::on_connect() {
  send_connect_subprocess();
}

void WebrtcSubprocess::on_recv_data(const picojson::object& data) {
  std::string command = data.at("command").get<std::string>();

  if (command == "relay_packet") {
    recv_relay_packet(data);

  } else if (command == "cancel_init_edge") {
    recv_cancel_init_edge(data);

  } else if (command == "create_init_edge") {
    recv_create_init_edge(data);

  } else if (command == "init_webrtc_ice") {
    recv_init_webrtc_ice(data);

  } else if (command == "init_webrtc_offer") {
    recv_init_webrtc_offer(data);

  } else if (command == "init_webrtc_reply") {
    recv_init_webrtc_reply(data);

  } else if (command == "initialize") {
    recv_initialize(data);

  } else if (command == "set_my_nid") {
    recv_set_my_nid(data);

  } else {
    std::cerr << __LINE__ << "@" << __FILE__ << " " << command << std::endl;
    assert(false);
  }
}

void WebrtcSubprocess::webrtc_bundle_relay_to_local(const Packet& packet) {
  send_relay_to_local(packet);
}

void WebrtcSubprocess::webrtc_bundle_init_webrtc_deny(const NodeID& prime_nid, int reason) {
  send_init_webrtc_deny(prime_nid, reason);
}

void WebrtcSubprocess::webrtc_bundle_init_webrtc_ice(
    const NodeID& local_nid, const NodeID& remote_nid, const std::string& ice) {
  send_init_webrtc_ice(local_nid, remote_nid, ice);
}

void WebrtcSubprocess::webrtc_bundle_init_webrtc_reply(const NodeID& prime_nid,
                                                       const NodeID& second_nid,
                                                       const std::string& sdp) {
  send_init_webrtc_reply(prime_nid, second_nid, sdp);
}

/**
 * Process on change edge's status and it enable connection.
 * Apply connecotr to WebRTC bundler.
 * Rise connect success event on delegate.
 * Send init_webrtc command with fin signal.
 * Tell nid to router module.
 */
void WebrtcSubprocess::webrtc_edge_on_change_stateus(WebrtcEdge& edge, bool is_connect) {
  assert(&edge == init_edge);

  if (is_connect) {
    WebrtcBundle& webrtc = WebrtcBundle::get_instance();

    webrtc.apply_edge(init_edge);
    init_edge = nullptr;

    send_init_webrtc_fin();
  }
}

void WebrtcSubprocess::webrtc_edge_on_update_ice(WebrtcEdge& edge, const std::string& ice) {
  assert(&edge == init_edge);

  if (edge.nid == NodeID::NONE) {
    init_ice.push_back(ice);

  } else {
    send_init_webrtc_ice(my_nid, edge.nid, ice);
  }
}

/**
 * Get options by reading command line arguments.
 * @param argc Count of command line arguments.
 * @param argv Values of command line arguments.
 * @return Pipe path, Message file path.
 */
std::tuple<std::string, std::string> WebrtcSubprocess::read_options(int argc, char* argv[]) {
  assert(argc == 3);

  return std::tuple<std::string, std::string>(std::string(argv[1]), std::string(argv[2]));
}

void WebrtcSubprocess::recv_cancel_init_edge(const picojson::object& content) {
  assert(init_edge != nullptr);

  WebrtcBundle& webrtc = WebrtcBundle::get_instance();
  webrtc.close_edge(init_edge);
  init_edge = nullptr;
  init_ice.clear();
}

void WebrtcSubprocess::recv_create_init_edge(const picojson::object& content) {
  assert(init_edge == nullptr);

  WebrtcBundle& bundle = WebrtcBundle::get_instance();
  init_edge = bundle.create_edge();
  init_edge->delegate = this;

  send_init_webrtc_offer(init_edge->get_local_sdp());
}

void WebrtcSubprocess::recv_init_webrtc_ice(const picojson::object& content) {
  NodeID local_nid = NodeID::from_json(content.at("local_nid"));
  NodeID remote_nid = NodeID::from_json(content.at("remote_nid"));
  const std::string& ice = content.at("ice").get<std::string>();

  if (init_edge == nullptr) {
    WebrtcBundle& webrtc = WebrtcBundle::get_instance();
    webrtc.relay_init_webrtc_ice(local_nid, remote_nid, ice);

  } else if (init_edge->nid == local_nid &&
             my_nid == remote_nid) {
    init_edge->update_ice(ice);
  }
}

void WebrtcSubprocess::recv_init_webrtc_offer(const picojson::object& content) {
  assert(init_edge == nullptr);
  WebrtcBundle& bundle = WebrtcBundle::get_instance();
  bundle.relay_init_webrtc_offer(NodeID::from_json(content.at("prime_nid")),
                                 content.at("sdp").get<std::string>());
}

void WebrtcSubprocess::recv_init_webrtc_reply(const picojson::object& content) {
  NodeID prime_nid = NodeID::from_json(content.at("prime_nid"));
  NodeID second_nid = NodeID::from_json(content.at("second_nid"));
  const std::string& sdp = content.at("sdp").get<std::string>();

  if (init_edge == nullptr || prime_nid != my_nid) {
    return;
  }

  init_edge->nid = second_nid;
  init_edge->set_remote_sdp(sdp);

  for (auto ice : init_ice) {
    send_init_webrtc_ice(my_nid, init_edge->nid, ice);
  }
}

void WebrtcSubprocess::recv_initialize(const picojson::object& content) {
  // Save configure.
  config = content.at("config").get<picojson::object>();

  Logger::initialize(config, "native");
}

void WebrtcSubprocess::recv_relay_packet(const picojson::object& content) {
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

  WebrtcBundle& bundle = WebrtcBundle::get_instance();
  bundle.relay(packet);
}

void WebrtcSubprocess::recv_set_my_nid(const picojson::object& content) {
  my_nid = NodeID::from_json(content.at("my_nid"));
  Logger::dbg(DaemonMid::L1013, getpid(), my_nid.to_str().c_str());

  WebrtcBundle& bundle = WebrtcBundle::get_instance();
  bundle.set_nid(my_nid);
}

void WebrtcSubprocess::send_connect_subprocess() {
  picojson::object packet;
  packet.insert(std::make_pair("command", picojson::value(std::string("connect_subprocess"))));
  send_data(packet);
}

void WebrtcSubprocess::send_init_webrtc_deny(const NodeID& prime_nid, int reason) {
  picojson::object data;

  data.insert(std::make_pair("command", picojson::value(std::string("init_webrtc_deny"))));
  data.insert(std::make_pair("prime_nid", prime_nid.to_json()));
  data.insert(std::make_pair("reason", Convert::int2json(reason)));

  send_data(data);
}

void WebrtcSubprocess::send_init_webrtc_fin() {
  picojson::object data;

  data.insert(std::make_pair("command", picojson::value(std::string("init_webrtc_fin"))));

  send_data(data);
}

void WebrtcSubprocess::send_init_webrtc_ice(const NodeID& local_nid, const NodeID& remote_nid,
                                            const std::string ice) {
  picojson::object data;

  data.insert(std::make_pair("command", picojson::value(std::string("init_webrtc_ice"))));
  data.insert(std::make_pair("local_nid", local_nid.to_json()));
  data.insert(std::make_pair("remote_nid", remote_nid.to_json()));
  data.insert(std::make_pair("ice", picojson::value(ice)));

  send_data(data);
}

void WebrtcSubprocess::send_init_webrtc_offer(const std::string& sdp) {
  picojson::object data;

  data.insert(std::make_pair("command", picojson::value(std::string("init_webrtc_offer"))));
  data.insert(std::make_pair("sdp", picojson::value(sdp)));

  send_data(data);
}

void WebrtcSubprocess::send_init_webrtc_reply(
    const NodeID& prime_nid, const NodeID& second_nid, const std::string& sdp) {
  picojson::object data;

  data.insert(std::make_pair("command",
                             picojson::value(std::string("init_webrtc_reply"))));
  data.insert(std::make_pair("prime_nid", prime_nid.to_json()));
  data.insert(std::make_pair("second_nid", second_nid.to_json()));
  data.insert(std::make_pair("sdp", picojson::value(sdp)));

  send_data(data);
}

void WebrtcSubprocess::send_relay_to_local(const Packet& packet) {
  picojson::object data;

  data.insert(std::make_pair("command", picojson::value(std::string("relay_to_local"))));
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

}  // namespace processwarp


#ifndef WITH_WEBRTC_DEBUG
int main(int argc, char* argv[]) {
  processwarp::WebrtcSubprocess THIS;

  return THIS.entry(argc, argv);
}
#endif
