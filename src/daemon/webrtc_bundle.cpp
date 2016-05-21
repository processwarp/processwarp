
#include <string>

#include "webrtc_bundle.hpp"

namespace processwarp {

/**
 * WebrtcBundle instance getter as singleton pattern.
 * @return The singleton instance of WebrtcBundle class.
 */
WebrtcBundle& WebrtcBundle::get_instance() {
  static WebrtcBundle instance;
  return instance;
}

/**
 * Constructor for singleton pattern.
 * Set default value to instance members.
 * This class is singleton.
 * This method is private.
 */
WebrtcBundle::WebrtcBundle() {
}

/**
 * Simple destructor for vtable.
 */
WebrtcBundle::~WebrtcBundle() {
}

/**
 * Change connector's handler to me.
 * @param connector WebRTC connector.
 */
void WebrtcBundle::apply_connector(WebrtcConnector* connector) {
  connector->delegate = this;
}

/**
 * Create new WebRTC connector.
 * Connector handle will change by apply_connector or will release by purge_connector.
 * @return A new WebRTC connector.
 */
WebrtcConnector* WebrtcBundle::create_connector() {
  WebrtcConnector* connector = new WebrtcConnector(peer_connection_factory, pc_config, dc_config);
  connectors.insert(std::make_pair(connector, std::unique_ptr<WebrtcConnector>(connector)));

  return connector;
}

/**
 * Release all connectors and release WebRTC resources.
 */
void WebrtcBundle::finalize() {
  // It must close connections with subthread alive.
  connectors.clear();
  peer_connection_factory = nullptr;

  // Subthread will quit after release resources.
  thread->Quit();
  uv_thread_join(&subthread);

  rtc::CleanupSSL();
}

/**
 * Initialize WebRTC library and create a thread.
 * @param loop_ Loop for WebrtcBundle.
 */
void WebrtcBundle::initialize(uv_loop_t* loop_) {
  loop = loop_;

  rtc::InitializeSSL();

  uv_thread_create(&subthread, WebrtcBundle::subthread_entry, this);
}

/**
 * Purge WebRTC connector.
 * Unset handler and delete the connector instance.
 * @param connector WebRTC onnector.
 */
void WebrtcBundle::purge_connector(WebrtcConnector* connector) {
  connector->delegate = nullptr;
  connectors.erase(connector);
}

void WebrtcBundle::relay(const Packet& packet) {
  /*
  webrtc::DataBuffer buffer(rtc::CopyOnWriteBuffer(parameter.c_str(), parameter.size()), true);
  std::cout << "Send(" << connection.data_channel->state() << ")" << std::endl;
  connection.data_channel->Send(buffer);
  */
}

void WebrtcBundle::webrtc_connector_on_change_stateus(WebrtcConnector& connector, bool is_connect) {
  /// @todo
  assert(false);
}

void WebrtcBundle::webrtc_connector_on_update_ice(WebrtcConnector& connector,
                                                  const std::string ice) {
  /// @todo
  assert(false);
}

/**
 * WebRTC worker thread entry method.
 * Initialize library and start loop.
 */
void WebrtcBundle::subthread_entry(void* arg) {
  WebrtcBundle& THIS = *reinterpret_cast<WebrtcBundle*>(arg);

  THIS.peer_connection_factory = webrtc::CreatePeerConnectionFactory();
  if (THIS.peer_connection_factory.get() == nullptr) {
    std::cout << "Error on CreatePeerConnectionFactory." << std::endl;
    /// @todo error
    assert(false);
  }

  // Using Google's STUN server.
  /// @todo Read STUN url from configure.
  webrtc::PeerConnectionInterface::IceServer ice_server;
  ice_server.uri = "stun:stun.l.google.com:19302";
  THIS.pc_config.servers.push_back(ice_server);

  THIS.thread = rtc::Thread::Current();
  THIS.thread->set_socketserver(&THIS.socket_server);
  THIS.thread->Run();
  THIS.thread->set_socketserver(nullptr);
}

}  // namespace processwarp
