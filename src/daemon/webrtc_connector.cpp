
#include <picojson.h>

#include <string>

#include "webrtc_connector.hpp"

namespace processwarp {
/**
 * Simple destructor for vtable.
 */
WebrtcConnectorDelegate::~WebrtcConnectorDelegate() {
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
}

void WebrtcConnector::PCO::OnIceCandidate(const webrtc::IceCandidateInterface* candidate) {
  parent.on_ice_candidate(candidate);
}

void WebrtcConnector::PCO::OnIceConnectionChange(
    webrtc::PeerConnectionInterface::IceConnectionState new_state) {
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
    delegate(nullptr),
    csdo(*this),
    dco(*this),
    pco(*this),
    ssdo(*this) {
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

  peer_connection->CreateOffer(&csdo, nullptr);
  {
    std::lock_guard<std::mutex> guard(mutex);
    while (local_sdp.empty()) {
      cond.wait(mutex);
    }
  }

  return local_sdp;
}

/**
 * Set remote peer's SDP.
 * @param sdp String of sdp.
 */
void WebrtcConnector::set_remote_sdp(const std::string& sdp) {
  webrtc::SdpParseError error;
  webrtc::SessionDescriptionInterface* session_description(
      webrtc::CreateSessionDescription("offer", sdp, &error));

  if (session_description == nullptr) {
    /// @todo error
    // error.line
    // error.description
    assert(false);
  }

  peer_connection->SetRemoteDescription(&ssdo, session_description);
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
  for (auto& ice_it : v.get<picojson::array>()) {
    picojson::object& ice_json = ice_it.get<picojson::object>();
    webrtc::IceCandidateInterface* ice =
      CreateIceCandidate(ice_json.at("sdp_mid").get<std::string>(),
                         std::stoi(ice_json.at("sdp_mline_index").get<std::string>()),
                         ice_json.at("sdp").get<std::string>(),
                         &err_sdp);
    if (!err_sdp.line.empty() && !err_sdp.description.empty()) {
      /// @todo error
      std::cout << "Error on CreateIceCandidate" << std::endl
                << err_sdp.line << std::endl
                << err_sdp.description << std::endl;
      return;
    }

    peer_connection->AddIceCandidate(ice);
  }
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

void WebrtcConnector::on_ssd_failure(const std::string& error) {
  /// @todo error
  assert(false);
}

/**
 * Rase status chagne event.
 */
void WebrtcConnector::on_state_change(webrtc::DataChannelInterface::DataState status) {
  if (delegate == nullptr) {
    return;

  } else {
    bool is_connect = status == webrtc::DataChannelInterface::kOpen;
    delegate->webrtc_connector_on_change_stateus(*this, is_connect);
  }
}

void WebrtcConnector::on_message(const webrtc::DataBuffer& buffer) {
  /// @todo
  assert(false);
}
}  // namespace processwarp
