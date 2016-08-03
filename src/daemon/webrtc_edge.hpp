#pragma once

#include <webrtc/api/peerconnectioninterface.h>

#include <deque>
#include <string>

#include "lock.hpp"
#include "node_id.hpp"

namespace processwarp {
class WebrtcEdge;

class WebrtcEdgeDelegate {
 public:
  virtual ~WebrtcEdgeDelegate();
  virtual void webrtc_edge_on_change_stateus(WebrtcEdge& edge, bool is_connect) = 0;
  virtual void webrtc_edge_on_update_ice(WebrtcEdge& edge,
                                              const std::string& ice) = 0;
  virtual void webrtc_edge_on_recv(WebrtcEdge& edge, const std::string& data);
};

class WebrtcEdge {
 public:
  /// Opposide peer's node-id.
  NodeID nid;
  /// Connecting status.
  bool is_connected;
  /// Event handler.
  WebrtcEdgeDelegate* delegate;
  /// Received data retention pool (data is stored when the delegate is not defined).
  std::deque<std::string> retention_data;

  WebrtcEdge(
      rtc::scoped_refptr<webrtc::PeerConnectionFactoryInterface> peer_connection_factory,
      webrtc::PeerConnectionInterface::RTCConfiguration pc_config,
      webrtc::DataChannelInit dc_config);
  virtual ~WebrtcEdge();

  const std::string& get_local_sdp();
  void send(const std::string& data);
  void set_remote_sdp(const std::string& sdp);
  void update_ice(const std::string& ice);

 private:
  class CSDO : public webrtc::CreateSessionDescriptionObserver {
   public:
    explicit CSDO(WebrtcEdge& parent_);

    void OnSuccess(webrtc::SessionDescriptionInterface* desc) override;
    void OnFailure(const std::string& error) override;
    int AddRef() const override;
    int Release() const override;

   private:
    WebrtcEdge& parent;
  };

  class DCO : public webrtc::DataChannelObserver {
   public:
    explicit DCO(WebrtcEdge& parent_);

    void OnStateChange() override;
    void OnMessage(const webrtc::DataBuffer& buffer) override;
    void OnBufferedAmountChange(uint64_t previous_amount) override;

   private:
    WebrtcEdge& parent;
  };

  class PCO : public webrtc::PeerConnectionObserver {
   public:
    explicit PCO(WebrtcEdge& parent_);

    void OnAddStream(webrtc::MediaStreamInterface* stream) override;
    void OnDataChannel(webrtc::DataChannelInterface* data_channel) override;
    void OnIceCandidate(const webrtc::IceCandidateInterface* candidate) override;
    void OnIceConnectionChange(
        webrtc::PeerConnectionInterface::IceConnectionState new_state) override;
    void OnIceGatheringChange(
        webrtc::PeerConnectionInterface::IceGatheringState new_state) override;
    void OnRemoveStream(webrtc::MediaStreamInterface* stream) override;
    void OnRenegotiationNeeded() override;
    void OnSignalingChange(webrtc::PeerConnectionInterface::SignalingState new_state) override;

   private:
    WebrtcEdge& parent;
  };

  class SSDO : public webrtc::SetSessionDescriptionObserver {
   public:
    explicit SSDO(WebrtcEdge& parent_);

    void OnSuccess() override;
    void OnFailure(const std::string& error) override;
    int AddRef() const override;
    int Release() const override;

   private:
    WebrtcEdge& parent;
  };

  CSDO csdo;
  DCO  dco;
  PCO  pco;
  SSDO ssdo;

  rtc::scoped_refptr<webrtc::PeerConnectionInterface> peer_connection;
  rtc::scoped_refptr<webrtc::DataChannelInterface> data_channel;

  Lock::Mutex mutex;
  Lock::Cond cond;
  bool is_remote_sdp_set;
  /// SDP of local peer.
  std::string local_sdp;

  void on_csd_success(webrtc::SessionDescriptionInterface* desc);
  void on_csd_failure(const std::string& error);
  void on_ice_candidate(const webrtc::IceCandidateInterface* candidate);
  void on_pco_connection_change(webrtc::PeerConnectionInterface::IceConnectionState status);
  void on_ssd_failure(const std::string& error);
  void on_state_change(webrtc::DataChannelInterface::DataState status);
  void on_message(const webrtc::DataBuffer& buffer);
};
}  // namespace processwarp
