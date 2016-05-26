#pragma once

#include "packet.hpp"

namespace processwarp {
class PacketInitWebrtcOffer : public PacketController::Behavior {
 public:
  const PacketController::Define& get_define() override;
  void on_error(const Packet& packet) override;
  void on_packet_error(PacketError::Type code) override;
  void on_reply(const Packet& packet) override;
};
}  // namespace processwarp
