
#include "packet.hpp"

namespace processwarp {
PacketBehavior::~PacketBehavior() {
}

/**
 * This method will be called when the error packet has arrived.
 * @param packet The arrived packet.
 */
void PacketBehavior::on_error(const Packet& packet) {
}

/**
 * This method will be called when the reply packet has arrived.
 * @param packet The arrived packet.
 */
void PacketBehavior::on_reply(const Packet& packet) {
}

/**
 * This method will be called when a system has happened.
 */
void PacketBehavior::on_system_error(int code) {
}
}  // namespace processwarp
