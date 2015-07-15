#pragma once

#include <deque>
#include <map>
#include <random>

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
      PT_HINT,
    };

    /** */
    struct Page {
      /** */
      PageType type;
      /** */
      bool flg_update;
      /** */
      std::string value;

      /** Constructor with member value. */
      Page(PageType type, bool flg_update);
    };

    /** Bundle pages in memory space. */
    struct Space {
      /** Random value generator to use for generating address. */
      std::mt19937_64& rnd;
      /** Space name. */
      const std::string name;

      /**
       * Reserved addresses.
       * A higher priority address placed front of the deque.
       * Address is grouped by vaddr_t of head 4bit.
       */
      std::deque<vaddr_t> reserved[16];

      /** Map of page name and page space having on this device. */
      std::map<vaddr_t, Page> pages;
    };

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
      /** Accessing memory space. */
      Space& space;

    public:
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
       * @param src Set data address.
       * @param size Size of data.
       */
      void set_program_area(vaddr_t addr, const uint8_t* src, uint64_t size);
      
      vaddr_t alloc(unsigned int size);
      
      void free(vaddr_t addr);

      /**
       * The same function if addr is VADDR_NULL.
       */
      vaddr_t realloc(vaddr_t addr, uint64_t size);

      void set_fill(vaddr_t dst, uint8_t c, uint64_t size);

      template <typename T> void set(vaddr_t dst, T val);
    
      template <typename T> T get(vaddr_t src);

      const uint8_t* get_raw(vaddr_t src);

      uint8_t* get_raw_writable(vaddr_t src);
      
      void set_copy(vaddr_t dst, vaddr_t src, uint64_t size);
      void set_copy(vaddr_t dst, const uint8_t* src, uint64_t size);

      void lock_master(vaddr_t addr);

    private:
      /**
       * Constructor with memory space.
       * @param space Accessing memory space.
       */
      Accessor(Space& space);
    
      /** Block copy operator. */
      Accessor& operator=(const Accessor&);
    };
    
    /**
     * Constructor with device-id.
     * @param delegate Delegate for controller.
     * @param dev_id Using device-id.
     */
    VMemory(VMemoryDelegate& delegate, dev_id_t dev_id);

    /**
     * Create a vmemory space in this device.
     * @param name Space name of vmemory space.
     */
    void create_space(const std::string& name);

    /**
     * 
     */
    void recv_packet(const std::string& packet);

    /**
     * 
     */
    Accessor get_accessor(const std::string& name);
    
  private:      
    /** Delegate for controller. */
    VMemoryDelegate& delegate;
    /** Memory spaces. Space name and Space map. */
    std::map<std::string, Space> spaces;

    /** Block copy constructor. */
    VMemory(const VMemory&);
    
    /** Block copy operator. */
    VMemory& operator=(const VMemory&);
  };
}
