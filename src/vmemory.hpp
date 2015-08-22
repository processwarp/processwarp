#pragma once

#include <cassert>
#include <deque>
#include <map>
#include <memory>
#include <random>
#include <set>

#include "lib/picojson.h"
#include "convert.hpp"
#include "definitions.hpp"
#include "util.hpp"

namespace processwarp {
  /**
   * Delegate interface of VMemory for controller.
   */
  class VMemoryDelegate {
  public:
    /**
     * Destructor for virtual.
     */
    virtual ~VMemoryDelegate() {};

    /**
     * Call when send memory data to other device.
     */
    virtual void send_memory_data(const std::string& name,
				  const dev_id_t& dev_id,
				  const std::string& data) = 0;
  };
  
  /**
   * Bundle all of memory spaces using this device.
   */
  class VMemory {
  public:
    /** Page type. */
    enum PageType {
      PT_MASTER,
      PT_COPY,
      PT_PROGRAM,
    };

    /** */
    struct Page {
      /** */
      PageType type;
      /** True if can read. */
      bool flg_update;
      /** */
      std::string value;
      /** */
      std::set<dev_id_t> hint;
      /** Reference count to use to master. */
      int master_count;

      /** Constructor with member value. */
      Page(PageType type, bool flg_update, const std::string& value,
	   const std::set<dev_id_t>& hint);
    };

    static const vaddr_t UPPER_MASKS[];

    static vaddr_t get_upper_addr(vaddr_t addr) {
      return addr & UPPER_MASKS[addr >> 60];
    }

    static vaddr_t get_lower_addr(vaddr_t addr) {
      return addr & (~UPPER_MASKS[addr >> 60]);
    }

    static bool is_program(vaddr_t addr) {
      return (addr & AD_MASK) == AD_PROGRAM;
    }

    class WaitingException {};

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
      /** Map of page name and page space having on this device. */
      std::map<vaddr_t, Page> pages;
      /** */
      struct RequireInfo {
	clock_t last_clock;
	int try_count;
      };
      std::map<vaddr_t, RequireInfo> requiring;

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
      vaddr_t assign_addr(AddrType type);

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
    static AddrType get_addr_type(uint64_t size) {
      if      (size <= 0x0000000000FF) return AD_VALUE_08;
      else if (size <= 0x00000000FFFF) return AD_VALUE_16;
      else if (size <= 0x000000FFFFFF) return AD_VALUE_24;
      else if (size <= 0x0000FFFFFFFF) return AD_VALUE_32;
      else if (size <= 0x00FFFFFFFFFF) return AD_VALUE_40;
      else if (size <= 0xFFFFFFFFFFFF) return AD_VALUE_48;
      else {
	/// TODO:error
	assert(false);
	return AD_VALUE_08;
      }
    }

    /**
     * This request means to broadcast some reserve address for this device.
     * If the same address was used yet, must reply collision request immediately.
     * @param space
     * @param addrs
     */
    void send_reserve(Space& space, std::set<vaddr_t> addrs);

    /**
     * This request means to broadcast some unused and re-use-able address.
     * @param space
     * @param addrs
     */
    void send_release(Space& space, std::set<vaddr_t> addrs);

    /**
     * This request means to need a data of copy.
     * If device having the data of copy, should send copy packet. 
     * @param spec
     * @param addr
     * @param dev-id Device-id having the master data or DEV_BROADCAST.
     */
    void send_require(Space& space, vaddr_t addr, const dev_id_t& dev_id);

    /**
     * This request means to update memory for copy data.
     * @param space
     * @param page
     */
    void send_copy(const dev_id_t& dev_id, Space& space, Page& page, vaddr_t addr);

    /**
     * This request means tell unwant copy packet to sender.
     * @param name
     * @param dev_id
     * @param addr
     */
    void send_unwant(const std::string name, const dev_id_t& dev_id, vaddr_t addr);

    /**
     * This request means to stand as master.
     * @param spec
     * @param page
     */
    void send_stand(Space& space, Page& page, vaddr_t addr);

    /**
     * This request means to give right of master.
     * @param space
     * @param page
     * @param target
     */
    void send_give(Space& space, Page& page, vaddr_t addr, const dev_id_t& dst);

    /**
     * Send update packet.
     * @param space
     * @param addr
     * @param data
     * @param size
     * @param dev_id
     */
    void send_update(const dev_id_t& dev_id, Space& space, vaddr_t addr,
		     const uint8_t* data, uint64_t size);

    /**
     * This request means to selected memory isn't able to use.
     * The devices recv this devices are release page binded address.
     * The address is NOT released, The master device of address has right of owner.
     * @param dev_id
     * @param space
     * @param addr
     */
    void send_free(const dev_id_t& dev_id, Space& space, vaddr_t addr);

  public:
    /** This device's device-id. */
    const dev_id_t dev_id;
    /** Random value generator to use for generating address. */
    std::mt19937_64 rnd;

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
       * Raise exception of require if data is old or don't exist in this device.
       * @param addr
       * @param readable
       * @return
       */
      Page& get_page(vaddr_t addr, bool readable) {
	assert(addr != VADDR_NULL);
	assert((addr & AD_MASK) == AD_META ||
	       (addr & AD_MASK) == AD_PROGRAM ||
	       addr == get_upper_addr(addr));
	auto page = space.pages.find(addr);

	if (page == space.pages.end()) {
	  vmemory.send_require(space, addr, DEV_BROADCAST);
	  throw WaitingException();
	  
	} else if (readable && page->second.flg_update == false) {
	  assert(page->second.type == PT_COPY && page->second.hint.size() == 1);
	  vmemory.send_require(space, addr, *(page->second.hint.begin()));
	  throw WaitingException();
	}
	assert(page->second.type == PT_MASTER || page->second.master_count == 0);
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
       * Get master device-id for target address.
       * @param addr
       * @return
       */
      const dev_id_t& get_master(vaddr_t addr);
      
      typedef std::unique_ptr<int, std::function<void(int*)>> MasterKey;
      MasterKey keep_master(vaddr_t addr);
      
      /**
       * Set meta data.
       * if addr is VADDR_NULL then assign automatic by assign_addr.
       * if addr is not null then return address is equal to addr.
       * @param data Meta data.
       * @param addr
       * @param assigned address.
       */
      vaddr_t set_meta_area(const std::string& data, vaddr_t addr);
      
      vaddr_t set_meta_area(const std::string& data, vaddr_t addr, const dev_id_t& master);

      /**
       * Get meta data.
       * @param addr Target Address.
       * @return
       */
      const std::string& get_meta_area(vaddr_t addr);

      /**
       * Change meta data.
       * @param addr Target address.
       * @param data Meta data.
       */
      void update_meta_area(vaddr_t addr, const std::string& data);

      /**
       * Reserve address in program area.
       * This method must use when loading program only.
       * Each address is avoied collision (Only this device but enough when load).
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
      const std::string& get_program_area(vaddr_t addr);

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
      void set_fill(vaddr_t dst, uint8_t c, uint64_t size) {
	Page& page = get_page(get_upper_addr(dst), false);

	std::unique_ptr<char[]> buffer(new char[size]);
	std::memset(buffer.get(), c, size);

	switch(page.type) {
	case PT_MASTER: {
	  page.value.replace(get_lower_addr(dst), size, buffer.get(), size);
	  for (auto& it_hint : page.hint) {
	    vmemory.send_copy(it_hint, space, page, get_upper_addr(dst));
	  }
	} break;

	case PT_COPY: {
	  assert(page.hint.size() == 1);
	  page.flg_update = false;
	  vmemory.send_update(*page.hint.begin(), space, dst,
			      reinterpret_cast<const uint8_t*>(buffer.get()), size);
	} break;

	default: {
	  /// TODO:error
	  assert(false);
	} break;
	}
      }

      /**
       * Set value for memory on selected address to val.
       * @param dst Target address.
       * @param val Value to be set.
       */
      template <typename T> void set(vaddr_t dst, T val) {
	Page& page = get_page(get_upper_addr(dst), false);
	switch(page.type) {
	case PT_MASTER: {
	  assert(page.value.size() >= get_lower_addr(dst) + sizeof(T));
	  page.value.replace(get_lower_addr(dst), sizeof(T),
			     reinterpret_cast<const char*>(&val), sizeof(T));
	  for(auto& it_hint : page.hint) {
	    vmemory.send_copy(it_hint, space, page, get_upper_addr(dst));
	  }
	} break;
	  
	case PT_COPY: {
	  assert(page.hint.size() == 1);
	  page.flg_update = false;
	  vmemory.send_update(*page.hint.begin(), space, dst,
			      reinterpret_cast<const uint8_t*>(&val), sizeof(T));
	} break;
	  
	default: {
	  /// TODO:error
	  assert(false);
	} break;
	}
      }
    
      /**
       * Get value from memory on selected address.
       * @param src Target address.
       * @return Saved value.
       */
      template <typename T> T get(vaddr_t src) {
	Page& page = get_page(get_upper_addr(src), true);
	assert(page.value.size() >= get_lower_addr(src) + sizeof(T));
	return *reinterpret_cast<const T*>(page.value.data() + get_lower_addr(src));
      }

      /**
       */
      const uint8_t* get_raw(vaddr_t src) {
	Page& page = get_page(get_upper_addr(src), true);
	assert(page.value.size() >= get_lower_addr(src));

	return reinterpret_cast<const uint8_t*>(page.value.data() + get_lower_addr(src));
      }
      
      /**
       */
      uint8_t* get_raw_writable(vaddr_t src) {
	vaddr_t upper = get_upper_addr(src);
	vaddr_t lower = get_lower_addr(src);

	if (raw_writable.find(upper) == raw_writable.end()) {
	  Page& page = get_page(upper, true);
	  std::unique_ptr<uint8_t[]> tmp(new uint8_t[page.value.size()]);
	  memcpy(tmp.get(), page.value.data(), page.value.size());
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
      void set_copy(vaddr_t dst, vaddr_t src, uint64_t size) {
	Page& src_page = get_page(get_upper_addr(src), true);
	Page& dst_page = get_page(get_upper_addr(dst), false);

	switch(dst_page.type) {
	case PT_MASTER: {
	  assert(dst_page.value.size() >= get_lower_addr(dst) + size);
	  dst_page.value.replace(get_lower_addr(dst), size,
				 src_page.value.data() + get_lower_addr(src), size);
	} break;

	case PT_COPY: {
	  assert(dst_page.hint.size() == 1);
	  dst_page.flg_update = false;
	  vmemory.send_update(*dst_page.hint.begin(), space, dst,
			      reinterpret_cast<const uint8_t*>(src_page.value.data() +
							       get_lower_addr(src)), size);
	} break;

	default: {
	  /// TODO:error
	  assert(false);
	} break;
	}
      }
      
      void set_copy(vaddr_t dst, const uint8_t* src, uint64_t size) {
	Page& dst_page = get_page(get_upper_addr(dst), false);

	switch(dst_page.type) {
	case PT_MASTER: {
	  assert(dst_page.value.size() >= get_lower_addr(dst) + size);
	  dst_page.value.replace(get_lower_addr(dst), size,
				 reinterpret_cast<const char*>(src), size);
	} break;

	case PT_COPY: {
	  assert(dst_page.hint.size() == 1);
	  dst_page.flg_update = false;
	  vmemory.send_update(*dst_page.hint.begin(), space, dst,
			      reinterpret_cast<const uint8_t*>(src), size);
	} break;

	default: {
	  /// TODO:error
	  assert(false);
	} break;
	}
      }

      void lock_master(vaddr_t addr);
      void release_master(vaddr_t addr);

    private:
      /** Map of upper address and copy of raw writable area.  */
      std::map<vaddr_t, std::unique_ptr<uint8_t[]>> raw_writable;

      /** Block copy operator. */
      Accessor& operator=(const Accessor&);

      /** Block copy constructor. */
      Accessor(const Accessor&);
    };
    
    /**
     * Constructor with device-id.
     * @param delegate Delegate for controller.
     * @param dev_id Using device-id.
     */
    VMemory(VMemoryDelegate& delegate, const dev_id_t& dev_id);

    /**
     * Recv and decode data from other device.
     * @param name
     * @param data
     */
    void recv_memory_data(const std::string& name, const std::string& data);

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
    /** Memory spaces. Space name and Space map. */
    std::map<std::string, std::unique_ptr<Space>> spaces;

    /** Block copy constructor. */
    VMemory(const VMemory&);
    
    /** Block copy operator. */
    VMemory& operator=(const VMemory&);

    /**
     * Send packet.
     * @param name Memory space name.
     * @param dev_id Target device-id.
     * @param cmd Command name.
     * @param data Load data.
     */
    void send_packet(const std::string& name, const dev_id_t& dev_id,
		     const std::string& cmd, picojson::object& data);


    void recv_copy(const std::string& name, picojson::object& json);
    
    void recv_require(const std::string& name, picojson::object& json);

    void recv_reserve(const std::string& name, picojson::object& json);

    void recv_stand(const std::string& name, picojson::object& json);
    
    void recv_update(const std::string& name, picojson::object& json);

    void recv_give(const std::string& name, picojson::object& json);
  };
}
