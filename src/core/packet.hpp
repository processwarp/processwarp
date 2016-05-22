#pragma once

#include <memory>
#include <string>

#include "constant.hpp"
#include "node_id.hpp"
#include "type.hpp"

namespace processwarp {
struct Packet;

class PacketBehavior {
 public:
  const std::string command;
  const PacketMode::Type mode;
  const int timeout;
  const Module::Type dst_module;  ///< Target (destination) module.
  const Module::Type src_module;

  PacketBehavior(const std::string& command_, PacketMode::Type mode_,
                 int timeout_, Module::Type dst_module_, Module::Type src_module_);
  virtual ~PacketBehavior();

  virtual void on_error(const Packet& packet);
  virtual void on_reply(const Packet& packet);
  virtual void on_system_error(int code);
};

/** Packet for transport command. */
struct PacketContent {
  vpid_t pid;
  NodeID dst_nid;
  NodeID src_nid;
  picojson::object content;  ///< Content format is depend on each module and command.
};

struct PacketContainer {
  const uint32_t packet_id;
  const int send_time;
  std::unique_ptr<PacketBehavior> behavior;
  std::unique_ptr<PacketContent> content;
};

struct Packet {
  const uint32_t packet_id;
  const std::string& command;
  const PacketMode::Type mode;
  const Module::Type dst_module;  ///< Target (destination) module.
  const Module::Type src_module;
  const vpid_t& pid;
  const NodeID& dst_nid;
  const NodeID& src_nid;
  const picojson::object& content;  ///< Content format is depend on each module and command.
};

/*
void send_command(std::unique_ptr<PacketBehavior> behavior, std::unique_ptr<PacketContent> content);
void recv_command_hoge(const Packet& packet);
void send_reply(const Packet& reply_for, const picojson::object& content);
void send_error(const Packet& error_for, const picojson::object& content);
*/
}  // namespace processwarp
