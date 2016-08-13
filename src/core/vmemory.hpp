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
#include <tuple>
#include <vector>

#include "constant.hpp"
#include "constant_vm.hpp"
#include "convert.hpp"
#include "lock.hpp"
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

  virtual void vmemory_send_packet(VMemory& memory, const Packet& packet) = 0;
};

/**
 * Bundle all of memory spaces using this node.
 */
class VMemory : public PacketControllerDelegate {
 public:
  /** Page of memory. */
  struct Page {
    /** Page type. */
    std::atomic<VMemoryPageType::Type> type;
    /** True if can read. */
    std::atomic<bool> flg_update;
    /** Page value. */
    std::unique_ptr<uint8_t[]> value;
    /** Page size. */
    uint64_t size;
    /** Leader node-id for this page. */
    NodeID leader_nid;
    /** Acceptor node-id for this page. */
    std::set<NodeID> acceptor_nids;
    /** Learner node-id for this page. */
    std::set<NodeID> learner_nids;
    /** Reference count to use to master. */
    int master_count;
    /** Access count for change owner or occasion to copy. */
    int referral_count;
    /** Time that this node become the leader of this page. */
    time_t leader_time;
    /** Set of node-ids that emitting publish command for some nodes. */
    std::set<NodeID> publish_history;
    /** Set of node-ids that  emitting write command for acceptor nodes. */
    std::set<NodeID> write_history;
    /** Randome id, this value rewritten when the value is rewritten. */
    uint64_t write_id;

    Page(VMemoryPageType::Type type_, bool flg_update_,
         const std::string& value_str,
         const NodeID& leader_nid_, const std::set<NodeID>& learner_nids_);
    Page(VMemoryPageType::Type type_, bool flg_update_,
         const NodeID& leader_nid_, const std::set<NodeID>& learner_nids_);
  };

  /**
   * Memory accessor.
   * Use per thread.
   */
  class Accessor {
   public:
    typedef std::unique_ptr<int, std::function<void(int*)>> LeaderKey;

    explicit Accessor(VMemory& vmemory);
    virtual ~Accessor();

    vaddr_t alloc(uint64_t size);
    void free(vaddr_t addr);
    NodeID get_leader(vaddr_t addr);
    std::string get_meta_area(vaddr_t addr);
    std::string get_program_area(vaddr_t addr);
    LeaderKey keep_leader(vaddr_t addr);
    void print_dump();
    std::tuple<std::shared_ptr<Page>, const uint8_t*> read_raw(vaddr_t src);
    uint8_t* read_writable(vaddr_t src);
    vaddr_t realloc(vaddr_t addr, uint64_t size);
    vaddr_t reserve_program_area();
    vaddr_t set_meta_area(const std::string& data, vaddr_t addr);
    vaddr_t set_meta_area(const std::string& data, vaddr_t addr, const NodeID& leader_nid);
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
      std::shared_ptr<Page> page = get_page(get_upper_addr(src), true);
      assert(page->size >= get_lower_addr(src) + sizeof(T));
      return *reinterpret_cast<const T*>(page->value.get() + get_lower_addr(src));
    }

    /**
     * Set value for memory on selected address to val.
     * @param dst Target address.
     * @param val Value to be set.
     */
    template <typename T> void write(vaddr_t dst, T val) {
      std::shared_ptr<Page> page = get_page(get_upper_addr(dst), false);
      if (page->type & VMemoryPageType::LEADER) {
        assert(page->size >= get_lower_addr(dst) + sizeof(T));
        std::memcpy(page->value.get() + get_lower_addr(dst), &val, sizeof(T));
        vmemory.send_command_write(NodeID::NONE, *page, get_upper_addr(dst));

      } else {
        vmemory.send_command_write_require(*page, dst,
                                           reinterpret_cast<const uint8_t*>(&val), sizeof(T));
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

    std::shared_ptr<Page> get_page(vaddr_t addr, bool readable);
  };

  static const vaddr_t UPPER_MASKS[];
  /** Map of page name and page space having on this node. */
  std::map<vaddr_t, std::shared_ptr<Page>> pages;
  Lock::Mutex mutex_pages;
  Lock::Cond cond_pages;

  VMemory(VMemoryDelegate& delegate, const NodeID& nid);

  static vaddr_t get_lower_addr(vaddr_t addr);
  static vaddr_t get_upper_addr(vaddr_t addr);
  static bool is_program(vaddr_t addr);

  std::unique_ptr<VMemory::Accessor> get_accessor();
  void initialize(const vpid_t& pid);
  void recv_packet(const Packet& packet);
  void set_loading(bool flg);

 private:
  struct AllocInfo {
    /** Allocating address. */
    vaddr_t addr;
    /** Allocating address type. */
    AddressRegion::Type type;
    /** Node-id, it reply acceptr or error packet. */
    std::vector<NodeID> acceptor_nid;
    /** True if received error packet from at least 1 acceptor. */
    bool is_cancel;
    /** True if accepting process is finished. */
    bool is_finish;
    Lock::Mutex mutex;
    Lock::Cond cond;
    std::shared_ptr<Page> page;
  };

  class PacketAlloc : public PacketController::Behavior {
   public:
    PacketAlloc(VMemory& vmemory_, std::shared_ptr<AllocInfo> alloc_info_);

    const PacketController::Define& get_define() override;
    void on_error(const Packet& packet) override;
    void on_packet_error(PacketError::Type code) override;
    void on_reply(const Packet& packet) override;

   private:
    VMemory& vmemory;
    std::shared_ptr<AllocInfo> alloc_info;

    void update_status();
  };

  class PacketCandidacy : public PacketController::Behavior {
   public:
    explicit PacketCandidacy(VMemory& vmemory_, vaddr_t addr_);

    const PacketController::Define& get_define() override;
    void on_error(const Packet& packet) override;
    void on_reply(const Packet& packet) override;
    void on_packet_error(PacketError::Type code) override;

   private:
    VMemory& vmemory;
    vaddr_t addr;
  };

  class PacketClaimBack : public PacketController::Behavior {
   public:
    explicit PacketClaimBack(VMemory& vmemory_, vaddr_t addr_);

    const PacketController::Define& get_define() override;
    void on_error(const Packet& packet) override;
    void on_reply(const Packet& packet) override;
    void on_packet_error(PacketError::Type code) override;

   private:
    VMemory& vmemory;
    vaddr_t addr;
  };

  class PacketDelegate : public PacketController::Behavior {
   public:
    explicit PacketDelegate(VMemory& vmemory_);

    const PacketController::Define& get_define() override;
    void on_reply(const Packet& packet) override;
    void on_packet_error(PacketError::Type code) override;

   private:
    VMemory& vmemory;
  };

  class PacketPublish : public PacketController::Behavior {
   public:
    explicit PacketPublish(VMemory& vmemory_, const NodeID& dst_nid_,
                           vaddr_t addr_, uint64_t write_id_);

    const PacketController::Define& get_define() override;
    void on_error(const Packet& packet) override;
    void on_reply(const Packet& packet) override;
    void on_packet_error(PacketError::Type code) override;

   private:
    VMemory& vmemory;
    const NodeID dst_nid;
    const vaddr_t addr;
    const uint64_t write_id;
  };

  class PacketWrite : public PacketController::Behavior {
   public:
    explicit PacketWrite(VMemory& vmemory_, const NodeID& dst_nid_,
                         vaddr_t addr_, uint64_t write_id_);

    const PacketController::Define& get_define() override;
    void on_error(const Packet& packet) override;
    void on_reply(const Packet& packet) override;
    void on_packet_error(PacketError::Type code) override;

   private:
    VMemory& vmemory;
    const NodeID dst_nid;
    const vaddr_t addr;
    const uint64_t write_id;
  };

  class PacketWriteRequire : public PacketController::Behavior {
   public:
    PacketWriteRequire(VMemory& vmemory_, vaddr_t addr_);

    const PacketController::Define& get_define() override;
    void on_error(const Packet& packet) override;
    void on_reply(const Packet& packet) override;
    void on_packet_error(PacketError::Type code) override;

   private:
    VMemory& vmemory;
    const vaddr_t addr;
  };

  /** This memory space's pid. */
  vpid_t my_pid;
  /** This node's node-id. */
  NodeID my_nid;
  /** Node-id range of supported by this node. */
  NodeID range_min_nid;
  NodeID range_max_nid;

  /** Delegate for controller. */
  VMemoryDelegate& delegate;
  PacketController packet_controller;
  /** Random value generator to use for generating address. */
  std::mt19937_64 rnd;
  Lock::Mutex mutex_rnd;
  std::map<vaddr_t, time_t> requiring;
  /** Switch of loading mode. */
  bool is_loading;

  /** Block copy constructor. */
  VMemory(const VMemory&);
  /** Block copy operator. */
  VMemory& operator=(const VMemory&);

  static AddressRegion::Type get_addr_type(uint64_t size);

  void packet_controller_on_recv(const Packet& packet) override;
  void packet_controller_send(const Packet& packet) override;

  std::tuple<vaddr_t, std::shared_ptr<Page>> alloc_addr(Accessor& accessor,
                                                        AddressRegion::Type type);
  bool check_acceptor_range(vaddr_t addr);
  bool check_root_acceptor(vaddr_t addr);
  NodeID get_hash_id(vaddr_t addr);
  NodeID get_near_acceptor(vaddr_t addr);
  std::shared_ptr<Page> get_page(vaddr_t addr);
  uint64_t get_rnd();
  void rebalance();

  void recv_command_alloc(const Packet& packet);
  void recv_command_alloc_cancel(const Packet& packet);
  void recv_command_balance(const Packet& packet);
  void recv_command_candidacy(const Packet& packet);
  void recv_command_claim_back(const Packet& packet);
  void recv_command_delegate(const Packet& packet);
  void recv_command_free(const Packet& packet);
  void recv_command_free_acceptor(const Packet& packet);
  void recv_command_publish(const Packet& packet);
  void recv_command_require(const Packet& packet);
  void recv_command_routing(const Packet& packet);
  void recv_command_write(const Packet& packet);
  void recv_command_write_require(const Packet& packet);

  void send_command_alloc(std::shared_ptr<AllocInfo> alloc_info);
  void send_command_alloc_cancel(std::shared_ptr<AllocInfo> alloc_info);
  void send_command_balance(vaddr_t addr, const std::set<NodeID>& acceptor_nids);
  void send_command_candidacy(vaddr_t addr, Page& page);
  void send_command_claim_back(const NodeID& leader_nid, vaddr_t addr);
  void send_command_delegate(vaddr_t addr, const uint8_t* value, uint64_t size,
                             const NodeID& leader_nid,
                             const std::set<NodeID>& acceptor_nids,
                             const std::set<NodeID>& learner_nids);
  void send_command_free(vaddr_t addr);
  void send_command_free_acceptor(vaddr_t addr, const std::set<NodeID>& acceptor_nids);
  void send_command_publish(const NodeID& dst_nid, Page& page, vaddr_t addr);
  void send_command_require(vaddr_t addr, VMemoryReadMode::Type mode, bool to_all);
  void send_command_require_routing();
  void send_command_write(const NodeID& dst_nid, Page& page, vaddr_t addr);
  void send_command_write_require(Page& page, vaddr_t addr,
                                  const uint8_t* data, uint64_t size);
};
}  // namespace processwarp
