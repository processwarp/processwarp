
#include <picojson.h>

#include <string>

#include "convert.hpp"
#include "webrtc_connector.hpp"

namespace processwarp {
/**
 * Simple destructor for vtable.
 */
WebrtcConnectorDelegate::~WebrtcConnectorDelegate() {
}

/**
 * If delegate method is not defined, received data is stored to retainsion pool.
 * @param connector WebRTC connector.
 * @param data Received data string.
 */
void WebrtcConnectorDelegate::webrtc_connector_on_recv(WebrtcConnector& connector,
                                                       const std::string& data) {
  connector.retention_data.push_back(data);
}

WebrtcConnector::CSDO::CSDO(WebrtcConnector& parent_) :
    parent(parent_) {
}

void WebrtcConnector::CSDO::OnSuccess(webrtc::SessionDescriptionInterface* desc) {
  parent.on_csd_success(desc);
}

void WebrtcConnector::CSDO::OnFailure(const std::string& error) {
  parent.on_csd_failure(error);
}

int WebrtcConnector::CSDO::AddRef() const {
  return 0;
}

int WebrtcConnector::CSDO::Release() const {
  return 0;
}

WebrtcConnector::DCO::DCO(WebrtcConnector& parent_) :
    parent(parent_) {
}

void WebrtcConnector::DCO::OnStateChange() {
  parent.on_state_change(parent.data_channel->state());
}

void WebrtcConnector::DCO::OnMessage(const webrtc::DataBuffer& buffer) {
  parent.on_message(buffer);
}

void WebrtcConnector::DCO::OnBufferedAmountChange(uint64_t previous_amount) {
}

WebrtcConnector::PCO::PCO(WebrtcConnector& parent_) :
    parent(parent_) {
}

void WebrtcConnector::PCO::OnAddStream(webrtc::MediaStreamInterface* stream) {
}

void WebrtcConnector::PCO::OnDataChannel(webrtc::DataChannelInterface* data_channel) {
  parent.data_channel = data_channel;
  data_channel->RegisterObserver(&parent.dco);
}

void WebrtcConnector::PCO::OnIceCandidate(const webrtc::IceCandidateInterface* candidate) {
  parent.on_ice_candidate(candidate);
}

void WebrtcConnector::PCO::OnIceConnectionChange(
    webrtc::PeerConnectionInterface::IceConnectionState new_state) {
  parent.on_pco_connection_change(new_state);
}

void WebrtcConnector::PCO::OnIceGatheringChange(
    webrtc::PeerConnectionInterface::IceGatheringState new_state) {
}

void WebrtcConnector::PCO::OnRemoveStream(webrtc::MediaStreamInterface* stream) {
}

void WebrtcConnector::PCO::OnRenegotiationNeeded() {
}

void WebrtcConnector::PCO::OnSignalingChange(
    webrtc::PeerConnectionInterface::SignalingState new_state) {
}

WebrtcConnector::SSDO::SSDO(WebrtcConnector& parent_) :
    parent(parent_) {
}

void WebrtcConnector::SSDO::OnSuccess() {
}

void WebrtcConnector::SSDO::OnFailure(const std::string& error) {
  parent.on_ssd_failure(error);
}

int WebrtcConnector::SSDO::AddRef() const {
  return 0;
}

int WebrtcConnector::SSDO::Release() const {
  return 0;
}

WebrtcConnector::WebrtcConnector(
    rtc::scoped_refptr<webrtc::PeerConnectionFactoryInterface> peer_connection_factory,
    webrtc::PeerConnectionInterface::RTCConfiguration pc_config,
    webrtc::DataChannelInit dc_config) :
    is_connected(false),
    delegate(nullptr),
    csdo(*this),
    dco(*this),
    pco(*this),
    ssdo(*this),
    is_remote_sdp_set(false) {
  peer_connection =
    peer_connection_factory->CreatePeerConnection(pc_config, nullptr, nullptr, &pco);
  if (peer_connection.get() == nullptr) {
    /// @todo error
    assert(false);
  }

  data_channel = peer_connection->CreateDataChannel("data_channel", &dc_config);
  if (data_channel.get() == nullptr) {
    /// @todo error
    assert(false);
  }

  data_channel->RegisterObserver(&dco);
}

/**
 * Destractor, close peer connection and release.
 */
WebrtcConnector::~WebrtcConnector() {
  peer_connection->Close();
  peer_connection = nullptr;
  data_channel = nullptr;
}

/**
 * Get new SDP of peer.
 * @todo Relase SDP string?
 */
const std::string& WebrtcConnector::get_local_sdp() {
  assert(local_sdp.empty());

  if (is_remote_sdp_set) {
    peer_connection->CreateAnswer(&csdo, nullptr);
  } else {
    peer_connection->CreateOffer(&csdo, nullptr);
  }

  {
    std::lock_guard<std::mutex> guard(mutex);
    while (local_sdp.empty()) {
      cond.wait(mutex);
    }
  }

  return local_sdp;
}

/**
 * Send packet by WebRTC data channel.
 * @param packet Packet to send.
 */
void WebrtcConnector::send(const std::string& packet) {
  assert(is_connected);

  webrtc::DataBuffer buffer(rtc::CopyOnWriteBuffer(packet.c_str(), packet.size()), true);
  data_channel->Send(buffer);
}

/**
 * Set remote peer's SDP.
 * @param sdp String of sdp.
 */
void WebrtcConnector::set_remote_sdp(const std::string& sdp) {
  webrtc::SdpParseError error;
  webrtc::SessionDescriptionInterface* session_description(
      webrtc::CreateSessionDescription((local_sdp.empty() ? "offer" : "answer"), sdp, &error));

  if (session_description == nullptr) {
    /// @todo error
    std::cout << error.line << std::endl;
    std::cout << error.description << std::endl;
    assert(false);
  }

  peer_connection->SetRemoteDescription(&ssdo, session_description);
  is_remote_sdp_set = true;
}

/**
 * Update ICE data.
 * @param ice String of ice.
 */
void WebrtcConnector::update_ice(const std::string& ice) {
  picojson::value v;
  std::string err = picojson::parse(v, ice);
  if (!err.empty()) {
    /// @todo error
  }

  webrtc::SdpParseError err_sdp;
  picojson::object& ice_json = v.get<picojson::object>();
  webrtc::IceCandidateInterface* ice_ptr =
    CreateIceCandidate(ice_json.at("sdp_mid").get<std::string>(),
                       std::stoi(ice_json.at("sdp_mline_index").get<std::string>()),
                       ice_json.at("sdp").get<std::string>(),
                       &err_sdp);
  if (!err_sdp.line.empty() && !err_sdp.description.empty()) {
    /// @todo error
    std::cout << "Error on CreateIceCandidate" << std::endl
              << err_sdp.line << std::endl
              << err_sdp.description << std::endl;
    assert(false);
  }

  peer_connection->AddIceCandidate(ice_ptr);
}

/**
 * Get SDP string and store.
 */
void WebrtcConnector::on_csd_success(webrtc::SessionDescriptionInterface* desc) {
  peer_connection->SetLocalDescription(&ssdo, desc);

  std::lock_guard<std::mutex> guard(mutex);
  cond.notify_all();
  desc->ToString(&local_sdp);
}

void WebrtcConnector::on_csd_failure(const std::string& error) {
  /// @todo error
  assert(false);
}

/**
 * Get ICE string and raise event.
 */
void WebrtcConnector::on_ice_candidate(const webrtc::IceCandidateInterface* candidate) {
  if (delegate == nullptr) {
    return;
  }

  picojson::object ice;
  std::string sdp;
  candidate->ToString(&sdp);
  ice.insert(std::make_pair("sdp", picojson::value(sdp)));
  ice.insert(std::make_pair("sdp_mid", picojson::value(candidate->sdp_mid())));
  ice.insert(std::make_pair("sdp_mline_index",
                            picojson::value(std::to_string(candidate->sdp_mline_index()))));

  delegate->webrtc_connector_on_update_ice(*this, picojson::value(ice).serialize());
}

/**
 * Raise status change event by peer connection status.
 * @param status Peer connection status.
 */
void WebrtcConnector::on_pco_connection_change(
    webrtc::PeerConnectionInterface::IceConnectionState status) {
  if (delegate == nullptr) {
    return;

  } else {
    is_connected = status == webrtc::PeerConnectionInterface::kIceConnectionCompleted;
    delegate->webrtc_connector_on_change_stateus(*this, is_connected);
  }
}

void WebrtcConnector::on_ssd_failure(const std::string& error) {
  /// @todo error
  std::cout << error << std::endl;
  assert(false);
}

/**
 * Raise status chagne event by data channel status.
 * @param status Data channel status.
 */
void WebrtcConnector::on_state_change(webrtc::DataChannelInterface::DataState status) {
  if (delegate == nullptr) {
    return;

  } else {
    is_connected = status == webrtc::DataChannelInterface::kOpen;
    delegate->webrtc_connector_on_change_stateus(*this, is_connected);
  }
}

/**
 * When receive message, raise event for delegate or store data if delegate has not set.
 * @param buffer Received data buffer.
 */
void WebrtcConnector::on_message(const webrtc::DataBuffer& buffer) {
  std::string data(buffer.data.data<char>(), buffer.size());

  if (delegate == nullptr) {
    retention_data.push_back(data);

  } else {
    delegate->webrtc_connector_on_recv(*this, data);
  }
}
}  // namespace processwarp
