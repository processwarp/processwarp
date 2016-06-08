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
  /** Page type. */
  enum PageType {
    PT_MASTER,
    PT_COPY,
    PT_PROGRAM,
  };

  /** History of copy command for some page. */
  struct SendCopyHistory {
    uint64_t key;
    std::time_t time;
  };

  /** */
  struct Page {
    /** */
    PageType type;
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

    /**
     * Constructor with value by string.
     */
    Page(PageType type, bool flg_update,
         const std::string& value_str, const std::set<NodeID>& hint);

    /**
     * Constructor without initialize value.
     */
    Page(PageType type, bool flg_update, const std::set<NodeID>& hint);
  };

  static const vaddr_t UPPER_MASKS[];

  static vaddr_t get_upper_addr(vaddr_t addr) {
    return addr & UPPER_MASKS[addr >> 60];
  }

  static vaddr_t get_lower_addr(vaddr_t addr) {
    return addr & (~UPPER_MASKS[addr >> 60]);
  }

  static bool is_program(vaddr_t addr) {
    return (addr & AddressRegion::MASK) == AddressRegion::PROGRAM;
  }

  /** Bundle pages in memory space. */
  class Space {
   public:
    /** Space name. */
    const std::string name;
    /** Random value generator to use for generating address. */
    std::mt19937_64& rnd;
    /** Virtual memory controller. */
    VMemory& vmemory;
    /** Switch of loading mode. */
    bool is_loading;
    /** Map of page name and page space having on this node. */
    std::map<vaddr_t, Page> pages;
    std::set<vaddr_t> requiring;

    /**
     * Constructor with name and random.
     * @param name Space name.
     * @param rnd Random value generator to use for generating address.
     * @param vmemory
     */
    Space(const std::string& name, std::mt19937_64& rnd, VMemory& vmemory);

    /**
     * Get a new address to allocate a new memory.
     * @param type Address-type of memory.
     */
    vaddr_t assign_addr(AddressRegion::Type type);

    /**
     * Release a binded address for be used memory to be unused.
     * @param addr Address to release.
     */
    void release_addr(vaddr_t addr);

   private:
    /**
     * Reserved addresses.
     * A higher priority address placed front of the deque.
     * Address is grouped by vaddr_t of head 4bit.
     */
    std::deque<vaddr_t> reserved[16];

    /** Block copy operator. */
    Space& operator=(const Space&);

    /** Block copy constructor. */
    Space(const Space&);
  };

 private:
  /**
   *
   */
  static AddressRegion::Type get_addr_type(uint64_t size) {
    if (size <= 0x0000000000FF) return AddressRegion::VALUE_08;
    if (size <= 0x00000000FFFF) return AddressRegion::VALUE_16;
    if (size <= 0x000000FFFFFF) return AddressRegion::VALUE_24;
    if (size <= 0x0000FFFFFFFF) return AddressRegion::VALUE_32;
    if (size <= 0x00FFFFFFFFFF) return AddressRegion::VALUE_40;
    if (size <= 0xFFFFFFFFFFFF) return AddressRegion::VALUE_48;
    /// @todo error
    assert(false);
    return AddressRegion::VALUE_08;
  }

  void send_command_copy(const NodeID& dst_nid, Space& space, Page& page, vaddr_t addr);
  void send_command_copy_reply(const NodeID& dst_nid, Space& space, vaddr_t addr, uint64_t key);
  void send_command_free(const NodeID& dst_nid, Space& space, vaddr_t addr);
  void send_command_give(Space& space, Page& page, vaddr_t addr, const NodeID& dst);
  void send_command_release(Space& space, std::set<vaddr_t> addrs);
  void send_command_require(const NodeID& dst_nid, Space& space, vaddr_t addr);
  void send_command_reserve(Space& space, std::set<vaddr_t> addrs);
  void send_command_stand(Space& space, Page& page, vaddr_t addr);
  void send_command_unwant(const NodeID& dst_nid, const std::string name, vaddr_t addr);
  void send_command_update(const NodeID& dst_nid, Space& space, vaddr_t addr,
                           const uint8_t* data, uint64_t size);

 public:
  /** This node's node-id. */
  const NodeID my_nid;
  /** Random value generator to use for generating address. */
  std::mt19937_64 rnd;
  /** Memory spaces. Space name and Space map. */
  std::map<std::string, std::unique_ptr<Space>> spaces;

  /**
   * Memory accessor.
   * Use per thread.
   */
  class Accessor {
   private:
    /** Virtual memory controller. */
    VMemory& vmemory;
    /** Accessing memory space. */
    Space& space;

    /**
     * Get a memory page by a address.
     * Raise exception of require if data is old or don't exist in this node.
     * @param addr
     * @param readable
     * @return
     */
    Page& get_page(vaddr_t addr, bool readable) {
      assert(addr != VADDR_NULL);
      assert((addr & AddressRegion::MASK) == AddressRegion::META ||
             (addr & AddressRegion::MASK) == AddressRegion::PROGRAM ||
             addr == get_upper_addr(addr));
      auto page = space.pages.find(addr);

      if (page == space.pages.end()) {
        vmemory.send_command_require(NodeID::BROADCAST, space, addr);
        throw InterruptMemoryRequire(addr);

      } else if (readable && page->second.flg_update == false) {
        assert(page->second.type == PT_COPY && page->second.hint.size() == 1);
        vmemory.send_command_require(*(page->second.hint.begin()), space, addr);
        throw InterruptMemoryRequire(addr);
      }
      assert(page->second.type == PT_MASTER || page->second.master_count == 0);
      page->second.referral_count = 0;
      return page->second;
    }

   public:
    /**
     * Constructor with memory space.
     * @param controller Virtual memory.
     * @param space Accessing memory space.
     */
    Accessor(VMemory& vmemory, Space& space);

    /**
     * Get master node-id for target address.
     * @param addr
     * @return
     */
    const NodeID& get_master(vaddr_t addr);

    typedef std::unique_ptr<int, std::function<void(int*)>> MasterKey;
    MasterKey keep_master(vaddr_t addr);

    /**
     * Set meta data.
     * if addr is VADDR_NULL then assign automatic by assign_addr.
     * if addr is not null then return address is equal to addr.
     * @param data Meta data.
     * @param addr Assigned address.
     */
    vaddr_t set_meta_area(const std::string& data, vaddr_t addr);

    vaddr_t set_meta_area(const std::string& data, vaddr_t addr, const NodeID& master);

    /**
     * Get meta data.
     * @param addr Target Address.
     * @return
     */
    std::string get_meta_area(vaddr_t addr);

    /**
     * Change meta data.
     * @param addr Target address.
     * @param data Meta data.
     */
    void update_meta_area(vaddr_t addr, const std::string& data);

    /**
     * Reserve address in program area.
     * This method must use when loading program only.
     * Each address is avoied collision (Only this node but enough when load).
     * @return A reserved address.
     */
    vaddr_t reserve_program_area();

    /**
     * Set program data to be selected address.
     * Raise assert when selected address is set yet.
     * @param addr Target address.
     * @param data Program data.
     */
    void set_program_area(vaddr_t addr, const std::string& data);

    /**
     * Get program data.
     * @param addr Target address.
     * @return
     */
    std::string get_program_area(vaddr_t addr);

    /**
     * Allocates selected byte of memory.
     * @param size Size to allocate.
     * @return A address to allocated memory.
     */
    vaddr_t alloc(uint64_t size);

    /**
     * Frees allocations that were created via the preceding alloc or realloc.
     * Do noting by setting VADDR_NULL to addr.
     * @param addr Address that were allocated via the preceding alloc or realloc.
     */
    void free(vaddr_t addr);

    /**
     * Change the size of allocation pointed to by addr to size.
     * The same behave to alloc if addr is VADDR_NULL.
     * @param addr Address that were allocated via the preceding alloc or realloc.
     * @param size Size to re-allocate.
     * @return A address to re-allocated memory.
     */
    vaddr_t realloc(vaddr_t addr, uint64_t size);

    /**
     *
     */
    void write_fill(vaddr_t dst, uint8_t c, uint64_t size) {
      Page& page = get_page(get_upper_addr(dst), false);

      switch (page.type) {
        case PT_MASTER: {
          std::memset(page.value.get() + get_lower_addr(dst), c, size);
          for (auto& it_hint : page.hint) {
            vmemory.send_command_copy(it_hint, space, page, get_upper_addr(dst));
          }
        } break;

        case PT_COPY: {
          assert(page.hint.size() == 1);
          page.flg_update = false;
          std::unique_ptr<char[]> buffer(new char[size]);
          std::memset(buffer.get(), c, size);
          vmemory.send_command_update(*page.hint.begin(), space, dst,
                                      reinterpret_cast<const uint8_t*>(buffer.get()), size);
        } break;

        default: {
          /// @todo error
          assert(false);
        } break;
      }
    }

    /**
     * Set value for memory on selected address to val.
     * @param dst Target address.
     * @param val Value to be set.
     */
    template <typename T> void write(vaddr_t dst, T val) {
      Page& page = get_page(get_upper_addr(dst), false);
      switch (page.type) {
        case PT_MASTER: {
          assert(page.size >= get_lower_addr(dst) + sizeof(T));
          std::memcpy(page.value.get() + get_lower_addr(dst), &val, sizeof(T));
          for (auto& it_hint : page.hint) {
            vmemory.send_command_copy(it_hint, space, page, get_upper_addr(dst));
          }
        } break;

        case PT_COPY: {
          assert(page.hint.size() == 1);
          page.flg_update = false;
          vmemory.send_command_update(*page.hint.begin(), space, dst,
                                      reinterpret_cast<const uint8_t*>(&val), sizeof(T));
        } break;

        default: {
          /// @todo error
          assert(false);
        } break;
      }
    }

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
     */
    const uint8_t* read_raw(vaddr_t src) {
      Page& page = get_page(get_upper_addr(src), true);
      assert(page.size >= get_lower_addr(src));

      return reinterpret_cast<const uint8_t*>(page.value.get() + get_lower_addr(src));
    }

    /**
     */
    uint8_t* read_writable(vaddr_t src) {
      vaddr_t upper = get_upper_addr(src);
      vaddr_t lower = get_lower_addr(src);

      if (raw_writable.find(upper) == raw_writable.end()) {
        Page& page = get_page(upper, true);
        std::unique_ptr<uint8_t[]> tmp(new uint8_t[page.size]);
        std::memcpy(tmp.get(), page.value.get(), page.size);
        raw_writable.insert(std::make_pair(upper, std::move(tmp)));
      }

      return raw_writable.at(upper).get() + lower;
    }

    /**
     * Write out the data selected by get_raw_writable.
     */
    void write_out();

    /**
     */
    void write_copy(vaddr_t dst, vaddr_t src, uint64_t size) {
      Page& src_page = get_page(get_upper_addr(src), true);
      Page& dst_page = get_page(get_upper_addr(dst), false);

      switch (dst_page.type) {
        case PT_MASTER: {
          assert(dst_page.size >= get_lower_addr(dst) + size);
          std::memmove(dst_page.value.get() + get_lower_addr(dst),
                       src_page.value.get() + get_lower_addr(src), size);
        } break;

        case PT_COPY: {
          assert(dst_page.hint.size() == 1);
          dst_page.flg_update = false;
          vmemory.send_command_update(*dst_page.hint.begin(), space, dst,
                                      reinterpret_cast<const uint8_t*>(src_page.value.get() +
                                                                       get_lower_addr(src)), size);
        } break;

        default: {
          /// @todo error
          assert(false);
        } break;
      }
    }

    void write_copy(vaddr_t dst, const uint8_t *src, uint64_t size) {
      Page& dst_page = get_page(get_upper_addr(dst), false);

      switch (dst_page.type) {
        case PT_MASTER: {
          assert(dst_page.size >= get_lower_addr(dst) + size);
          std::memmove(dst_page.value.get() + get_lower_addr(dst), src, size);
        } break;

        case PT_COPY: {
          assert(dst_page.hint.size() == 1);
          dst_page.flg_update = false;
          vmemory.send_command_update(*dst_page.hint.begin(), space, dst,
                                      reinterpret_cast<const uint8_t*>(src), size);
        } break;

        default: {
          /// @todo error
          assert(false);
        } break;
      }
    }

    void print_dump();

   private:
    /** Map of upper address and copy of raw writable area.  */
    std::map<vaddr_t, std::unique_ptr<uint8_t[]>> raw_writable;

    /** Block copy operator. */
    Accessor& operator=(const Accessor&);

    /** Block copy constructor. */
    Accessor(const Accessor&);
  };

  /**
   * Constructor with node-id.
   * @param delegate Delegate for controller.
   * @param nid Using node-id.
   */
  VMemory(VMemoryDelegate& delegate, const NodeID& nid);

  void recv_packet(const Packet& packet);

  /**
   * @param name Space name.
   */
  std::unique_ptr<VMemory::Accessor> get_accessor(const std::string& name);

  /**
   * Get space by name.
   * Create new space if space is not exist yet.
   * @param name Space name.
   * @return Space.
   */
  Space& get_space(const std::string& name);

  /**
   * Switch memory's loading mode.
   * @param name Space name.
   * @param flg True if enable loading mode.
   */
  void set_loading(const std::string& name, bool flg);

 private:
  /** Delegate for controller. */
  VMemoryDelegate& delegate;
  PacketController packet_controller;

  /** Block copy constructor. */
  VMemory(const VMemory&);

  /** Block copy operator. */
  VMemory& operator=(const VMemory&);

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
};
}  // namespace processwarp
