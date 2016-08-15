
#include <cassert>
#include <string>

#include "convert.hpp"
#include "packet.hpp"

namespace processwarp {
/**
 * Simple destructor for vtable.
 */
PacketControllerDelegate::~PacketControllerDelegate() {
}

/**
 * Simple destructor for vtable.
 */
PacketController::Behavior::~Behavior() {
}

/**
 * It will be called when an error packet has arrived for the send packet.
 * @param packet Received error packet.
 */
void PacketController::Behavior::on_error(const Packet& packet) {
  assert(false);
}

/**
 * It will be called when a reply packet has arrived for the send packet.
 * @param packet Received reply packet.
 */
void PacketController::Behavior::on_reply(const Packet& packet) {
  assert(false);
}

/**
 * It will be called when a system error has raised.
 * @param packet System error code.
 */
void PacketController::Behavior::on_packet_error(PacketError::Type code) {
  assert(false);
}

/**
 * Constructor with a module that parent module of this instance.
 * @param module Moule type.
 */
PacketController::PacketController(Module::Type module) :
    rnd(std::random_device()()),
    delegate(nullptr),
    src_module(module) {
}

void PacketController::initialize(PacketControllerDelegate* delegate_) {
  delegate  = delegate_;
}

/**
 * Receive packet and call capable reply or error method.
 * If pacekt is another type, call delegate method for general process.
 */
void PacketController::recv(const Packet& packet) {
  if (packet.command == "reply") {
    auto container = containers.find(packet.packet_id);
    if (container != containers.end()) {
      container->second.behavior->on_reply(packet);
      containers.erase(container);
    }

  } else if (packet.command == "error") {
    auto container = containers.find(packet.packet_id);
    if (container != containers.end()) {
      container->second.behavior->on_error(packet);
      containers.erase(container);
    }

  } else if (packet.command == "packet_error") {
    auto container = containers.find(packet.packet_id);
    if (container != containers.end()) {
      PacketError::Type code = Convert::json2int<PacketError::Type>(packet.content.at("code"));
      container->second.behavior->on_packet_error(code);
      containers.erase(container);
    }

  } else {
    delegate->packet_controller_on_recv(packet);
  }
}

/**
 * Send a pacet that having reply and/or error process.
 * @param behavior Packet definition, reply and/or error process.
 * @param pid Target process-id.
 * @param dst_nid Destination node-id.
 * @param content Packet content.
 */
void PacketController::send(std::unique_ptr<Behavior> behavior, const vpid_t& pid,
                            const NodeID& dst_nid, const picojson::object& content) {
  uint32_t packet_id = get_rnd();
  while (containers.find(packet_id) != containers.end()) {
    packet_id = get_rnd();
  }

  const Define& define = behavior->get_define();

  assert(define.mode & PacketMode::ONE_WAY ||
         dst_nid != NodeID::NEXT);

  Packet packet = {
    packet_id,
    define.command,
    define.mode,
    define.dst_module,
    src_module,
    pid,
    dst_nid,
    my_nid,
    content
  };

  containers.insert(
      std::make_pair(packet_id, Container({packet_id, std::time(nullptr), std::move(behavior)})));

  delegate->packet_controller_send(packet);
}

/**
 * Send a simple one-way packet.
 * @param command Packet command.
 * @param dst_module Destination module.
 * @param is_explicit True if set explicit flag to packet.
 * @param pid Target process-id.
 * @param dst_nid Destination node-id.
 * @param content Packet content.
 */
void PacketController::send(const std::string& command, Module::Type dst_module, bool is_explicit,
                            const vpid_t& pid, const NodeID& dst_nid,
                            const picojson::object& content) {
  uint32_t packet_id = get_rnd();
  while (containers.find(packet_id) != containers.end()) {
    packet_id = get_rnd();
  }

  Packet packet = {
    packet_id,
    command,
    PacketMode::ONE_WAY,
    dst_module,
    src_module,
    pid,
    dst_nid,
    my_nid,
    content
  };

  delegate->packet_controller_send(packet);
}

/**
 * Send a reply packet for the received packet.
 * @param reply_for Received packet.
 * @param content Packet content.
 */
void PacketController::send_reply(const Packet& reply_for, const picojson::object& content) {
  Packet packet = {
    reply_for.packet_id,
    "reply",
    PacketMode::ONE_WAY,
    reply_for.src_module,
    src_module,
    reply_for.pid,
    reply_for.src_nid,
    my_nid,
    content
  };

  delegate->packet_controller_send(packet);
}

/**
 * Send a error packet for the received packet.
 * @param error_for Received packet.
 * @param content Packet content.
 */
void PacketController::send_error(const Packet& error_for, const picojson::object& content) {
  Packet packet = {
    error_for.packet_id,
    "error",
    PacketMode::ONE_WAY,
    error_for.src_module,
    src_module,
    error_for.pid,
    error_for.src_nid,
    my_nid,
    content
  };

  delegate->packet_controller_send(packet);
}

uint32_t PacketController::get_rnd() {
  Lock::Guard guard(mutex_rnd);
  return rnd();
}
}  // namespace processwarp
