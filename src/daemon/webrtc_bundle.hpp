#pragma once

#include <uv.h>

#include <webrtc/api/peerconnectioninterface.h>
#include <webrtc/api/test/fakeconstraints.h>
#include <webrtc/base/flags.h>
#include <webrtc/base/physicalsocketserver.h>
#include <webrtc/base/ssladapter.h>
#include <webrtc/base/thread.h>

#include <map>
#include <memory>
#include <string>

#include "packet.hpp"
#include "type.hpp"
#include "webrtc_connector.hpp"

namespace processwarp {
class WebrtcBundle : public WebrtcConnectorDelegate {
 public:
  static WebrtcBundle& get_instance();

  void apply_connector(WebrtcConnector* connector);
  WebrtcConnector* create_connector();
  void finalize();
  void initialize(uv_loop_t* loop);
  void purge_connector(WebrtcConnector* connector);
  void relay(const Packet& packet);

 private:
  /** Main loop of libuv. */
  uv_loop_t* loop;
  /** Sub-thread instance of libuv. */
  uv_thread_t subthread;

  /** Event loop of webrtc on sub-thread. */
  rtc::Thread* thread;
  /** WebRTC socket server instance. */
  rtc::PhysicalSocketServer socket_server;

  rtc::scoped_refptr<webrtc::PeerConnectionFactoryInterface> peer_connection_factory;
  webrtc::PeerConnectionInterface::RTCConfiguration pc_config;
  webrtc::DataChannelInit dc_config;

  std::map<WebrtcConnector*, std::unique_ptr<WebrtcConnector>> connectors;

  WebrtcBundle();
  WebrtcBundle(const WebrtcBundle&);
  WebrtcBundle& operator=(const WebrtcBundle&);
  virtual ~WebrtcBundle();

  void webrtc_connector_on_change_stateus(WebrtcConnector& connector, bool is_connect) override;
  void webrtc_connector_on_update_ice(WebrtcConnector& connector,
                                      const std::string ice) override;

  static void subthread_entry(void* arg);
};
}  // namespace processwarp
