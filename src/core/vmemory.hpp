#pragma once

#include <picojson.h>

#include <cassert>
#include <deque>
#include <functional>
#include <map>
#include <memory>
#include <random>
#include <set>
#include <string>

#include "constant.hpp"
#include "constant_vm.hpp"
#include "convert.hpp"
#include "interrupt_memory_require.hpp"
#include "packet.hpp"
#include "type.hpp"
#include "util.hpp"

namespace processwarp {
class VMemory;

/**
 * Delegate interface of VMemory for controller.
 */
class VMemoryDelegate {
 public:
  virtual ~VMemoryDelegate();

  virtual void vmemory_recv_update(VMemory& memory, vaddr_t addr) = 0;
  virtual void vmemory_send_packet(VMemory& memory, const Packet& packet) = 0;
};

/**
 * Bundle all of memory spaces using this node.
 */
class VMemory : public PacketControllerDelegate {
 public:
  /** History of copy command for some page. */
  struct SendCopyHistory {
    uint64_t key;
    std::time_t time;
  };

  /** */
  struct Page {
    /** */
    VMemoryPageType::Type type;
    /** True if can read. */
    bool flg_update;
    /** */
    std::unique_ptr<uint8_t[]> value;
    /** */
    uint64_t size;
    /** */
    std::set<NodeID> hint;
    /** Reference count to use to master. */
    int master_count;
    /** Access count for change owner or occasion to copy. */
    int referral_count;
    /** History of copy command for some node. */
    std::map<NodeID, SendCopyHistory> send_copy_history;

    Page(VMemoryPageType::Type type, bool flg_update,
         const std::string& value_str, const std::set<NodeID>& hint);
    Page(VMemoryPageType::Type type, bool flg_update, const std::set<NodeID>& hint);
  };

  /**
   * Memory accessor.
   * Use per thread.
   */
  class Accessor {
   public:
    typedef std::unique_ptr<int, std::function<void(int*)>> MasterKey;

    explicit Accessor(VMemory& vmemory);

    vaddr_t alloc(uint64_t size);
    void free(vaddr_t addr);
    const NodeID& get_master(vaddr_t addr);
    std::string get_meta_area(vaddr_t addr);
    std::string get_program_area(vaddr_t addr);
    MasterKey keep_master(vaddr_t addr);
    void print_dump();
    const uint8_t* read_raw(vaddr_t src);
    uint8_t* read_writable(vaddr_t src);
    vaddr_t realloc(vaddr_t addr, uint64_t size);
    vaddr_t reserve_program_area();
    vaddr_t set_meta_area(const std::string& data, vaddr_t addr);
    vaddr_t set_meta_area(const std::string& data, vaddr_t addr, const NodeID& master);
    void set_program_area(vaddr_t addr, const std::string& data);
    void update_meta_area(vaddr_t addr, const std::string& data);
    void write_copy(vaddr_t dst, vaddr_t src, uint64_t size);
    void write_copy(vaddr_t dst, const uint8_t *src, uint64_t size);
    void write_fill(vaddr_t dst, uint8_t c, uint64_t size);
    void write_out();

    /**
     * Get value from memory on selected address.
     * @param src Target address.
     * @return Saved value.
     */
    template <typename T> T read(vaddr_t src) {
      Page& page = get_page(get_upper_addr(src), true);
      assert(page.size >= get_lower_addr(src) + sizeof(T));
      return *reinterpret_cast<const T*>(page.value.get() + get_lower_addr(src));
    }

    /**
     * Set value for memory on selected address to val.
     * @param dst Target address.
     * @param val Value to be set.
     */
    template <typename T> void write(vaddr_t dst, T val) {
      Page& page = get_page(get_upper_addr(dst), false);
      switch (page.type) {
        case VMemoryPageType::MASTER: {
          assert(page.size >= get_lower_addr(dst) + sizeof(T));
          std::memcpy(page.value.get() + get_lower_addr(dst), &val, sizeof(T));
          for (auto& it_hint : page.hint) {
            vmemory.send_command_copy(it_hint, page, get_upper_addr(dst));
          }
        } break;

        case VMemoryPageType::COPY: {
          assert(page.hint.size() == 1);
          page.flg_update = false;
          vmemory.send_command_update(*page.hint.begin(), dst,
                                      reinterpret_cast<const uint8_t*>(&val), sizeof(T));
        } break;

        default: {
          /// @todo error
          assert(false);
        } break;
      }
    }

   private:
    /** Virtual memory controller. */
    VMemory& vmemory;
    /** Map of upper address and copy of raw writable area.  */
    std::map<vaddr_t, std::unique_ptr<uint8_t[]>> raw_writable;

    /** Block copy operator. */
    Accessor& operator=(const Accessor&);
    /** Block copy constructor. */
    Accessor(const Accessor&);

    Page& get_page(vaddr_t addr, bool readable);
  };

  static const vaddr_t UPPER_MASKS[];
  /** Map of page name and page space having on this node. */
  std::map<vaddr_t, Page> pages;

  VMemory(VMemoryDelegate& delegate, const NodeID& nid);

  static vaddr_t get_lower_addr(vaddr_t addr);
  static vaddr_t get_upper_addr(vaddr_t addr);
  static bool is_program(vaddr_t addr);

  std::unique_ptr<VMemory::Accessor> get_accessor();
  void initialize(const vpid_t& pid);
  void recv_packet(const Packet& packet);
  void release_addr(vaddr_t addr);
  void set_loading(bool flg);

 private:
  class PacketReserve : public PacketController::Behavior {
   public:
    const PacketController::Define& get_define() override;
    void on_error(const Packet& packet) override;
    void on_packet_error(PacketError::Type code) override;
    void on_reply(const Packet& packet) override;
  };

  /** This memory space's pid. */
  vpid_t my_pid;
  /** This node's node-id. */
  NodeID my_nid;

  /** Delegate for controller. */
  VMemoryDelegate& delegate;
  PacketController packet_controller;
  /** Random value generator to use for generating address. */
  std::mt19937_64 rnd;
  std::set<vaddr_t> requiring;
  /** Switch of loading mode. */
  bool is_loading;
  /**
   * Reserved addresses.
   * A higher priority address placed front of the deque.
   * Address is grouped by vaddr_t of head 4bit.
   */
  std::deque<vaddr_t> reserved[16];

  /** Block copy constructor. */
  VMemory(const VMemory&);
  /** Block copy operator. */
  VMemory& operator=(const VMemory&);

  static AddressRegion::Type get_addr_type(uint64_t size);

  vaddr_t assign_addr(AddressRegion::Type type);
  void packet_controller_on_recv(const Packet& packet) override;
  void packet_controller_send(const Packet& packet) override;

  void recv_command_copy(const Packet& packet);
  void recv_command_copy_reply(const Packet& packet);
  void recv_command_free(const Packet& packet);
  void recv_command_give(const Packet& packet);
  void recv_command_require(const Packet& packet);
  void recv_command_reserve(const Packet& packet);
  void recv_command_stand(const Packet& packet);
  void recv_command_unwant(const Packet& packet);
  void recv_command_update(const Packet& packet);

  void send_command_copy(const NodeID& dst_nid, Page& page, vaddr_t addr);
  void send_command_copy_reply(const NodeID& dst_nid, vaddr_t addr, uint64_t key);
  void send_command_free(const NodeID& dst_nid, vaddr_t addr);
  void send_command_give(Page& page, vaddr_t addr, const NodeID& dst);
  void send_command_release(std::set<vaddr_t> addrs);
  void send_command_require(const NodeID& dst_nid, vaddr_t addr);
  void send_command_reserve(std::set<vaddr_t> addrs);
  void send_command_stand(Page& page, vaddr_t addr);
  void send_command_unwant(const NodeID& dst_nid, vaddr_t addr);
  void send_command_update(const NodeID& dst_nid, vaddr_t addr,
                           const uint8_t* data, uint64_t size);
};
}  // namespace processwarp
