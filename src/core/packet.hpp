#pragma once

#include <picojson.h>

#include <ctime>
#include <map>
#include <memory>
#include <random>
#include <string>

#include "constant.hpp"
#include "node_id.hpp"
#include "type.hpp"

namespace processwarp {
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

class PacketControllerDelegate {
 public:
  virtual ~PacketControllerDelegate();
  virtual void packet_controller_on_recv(const Packet& packet) = 0;
  virtual void packet_controller_send(const Packet& packet) = 0;
};

class PacketController {
 public:
  struct Define {
    std::string command;
    PacketMode::Type mode;
    int timeout;
    Module::Type dst_module;
  };

  class Behavior {
   public:
    virtual ~Behavior();

    virtual const Define& get_define() = 0;
    virtual void on_error(const Packet& packet);
    virtual void on_packet_error(PacketError::Type code) = 0;
    virtual void on_reply(const Packet& packet);
  };

  NodeID my_nid;

  explicit PacketController(Module::Type module);

  void execute();
  void initialize(PacketControllerDelegate* delegate_);
  void recv(const Packet& packet);
  void send(std::unique_ptr<Behavior> behavior, const vpid_t& pid,
            const NodeID& dst_nid, const picojson::object& content);
  void send(const std::string& command, Module::Type dst_module, bool is_explicit,
            const vpid_t& pid, const NodeID& dst_nid, const picojson::object& content);
  void send_reply(const Packet& reply_for, const picojson::object& content);
  void send_error(const Packet& error_for, const picojson::object& content);

 private:
  struct Container {
    uint32_t packet_id;
    std::time_t send_time;
    std::unique_ptr<Behavior> behavior;
  };

  std::mt19937 rnd;

  PacketControllerDelegate* delegate;

  const Module::Type src_module;

  std::map<uint32_t, Container> containers;
};
}  // namespace processwarp
