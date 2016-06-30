
#include <cassert>
#include <deque>
#include <set>
#include <string>

#include "constant.hpp"
#include "constant_vm.hpp"
#include "convert.hpp"
#include "core_mid.hpp"
#include "error.hpp"
#include "finally.hpp"
#include "logger.hpp"
#include "util.hpp"
#include "vmemory.hpp"

namespace processwarp {

const vaddr_t VMemory::UPPER_MASKS[]  = {
  0xFFFFFFFFFFFFFFFF,  ///< Meta data
  0xFFFFFFFFFFFFFF00,
  0xFFFFFFFFFFFF0000,
  0xFFFFFFFFFF000000,
  0xFFFFFFFF00000000,
  0xFFFFFF0000000000,
  0xFFFF000000000000,
  0x0000000000000000,  // dummy
  0x0000000000000000,  // dummy
  0xFFFFFFFFFFFFFF00,
  0xFFFFFFFFFFFF0000,
  0xFFFFFFFFFF000000,
  0xFFFFFFFF00000000,
  0xFFFFFF0000000000,
  0xFFFF000000000000,
  0xFFFFFFFFFFFFFFFF,  // Function, Type
};

/**
 * Simple destructor for vtable.
 */
VMemoryDelegate::~VMemoryDelegate() {
}

/**
 * Constructor with value by string.
 */
VMemory::Page::Page(VMemoryPageType::Type type_, bool flg_update_,
                    const std::string& value_str,
                    const NodeID& leader_nid_, const std::set<NodeID>& hint_) :
    type(type_),
    flg_update(flg_update_),
    value(new uint8_t[value_str.size()]),
    size(value_str.size()),
    leader_nid(leader_nid_),
    hint(hint_),
    master_count(0),
    referral_count(0) {
  std::memcpy(value.get(), value_str.data(), size);
}

/**
 * Constructor with empty value.
 */
VMemory::Page::Page(VMemoryPageType::Type type_, bool flg_update_,
                    const NodeID& leader_nid_, const std::set<NodeID>& hint_) :
    type(type_),
    flg_update(flg_update_),
    size(0),
    leader_nid(leader_nid_),
    hint(hint_),
    master_count(0),
    referral_count(0) {
}

/**
 * Constructor with memory space.
 * @param vmemory_ Virtual memory.
 */
VMemory::Accessor::Accessor(VMemory& vmemory_) :
    alloc_addr(VADDR_NULL),
    is_alloc(false),
    vmemory(vmemory_) {
}

/**
 * Allocates selected byte of memory.
 * @param size Size to allocate.
 * @return A address to allocated memory.
 */
vaddr_t VMemory::Accessor::alloc(uint64_t size) {
  if (size == 0) size = 1;

  vaddr_t addr = vmemory.alloc_addr(*this, get_addr_type(size));

  Page& page = vmemory.pages.at(addr);
  page.size = size;
  page.value.reset(new uint8_t[size]);

  return addr;
}

/**
 * Frees allocations that were created via the preceding alloc or realloc.
 * Do noting by setting VADDR_NULL to addr.
 * @param addr Address that were allocated via the preceding alloc or realloc.
 */
void VMemory::Accessor::free(vaddr_t addr) {
  if (addr == VADDR_NULL) return;

  if (addr != get_upper_addr(addr)) {
    /// @todo error
    assert(false);
  }

  Page& page = get_page(addr, false);
  assert(~page.type & VMemoryPageType::PROGRAM);
  if (page.type & VMemoryPageType::LEADER) {
    assert(page.master_count == 0 && raw_writable.find(addr) == raw_writable.end());
    page.size = 0;
    page.value.reset();
    for (auto& dst_nid : page.hint) {
      vmemory.send_command_copy(dst_nid, page, addr);
    }
    vmemory.release_addr(addr);
    vmemory.pages.erase(addr);

  } else {
    assert(page.hint.size() == 1);
    vmemory.send_command_free(*page.hint.begin(), addr);
  }
}

/**
 * Get leader node-id for target address.
 * @param addr
 * @return
 */
const NodeID& VMemory::Accessor::get_leader(vaddr_t addr) {
  Page& page = get_page(addr, false);

  if (page.type & VMemoryPageType::PROGRAM) {
    // @todo return neighborhood acceptor node-id.
    assert(false);

  } else if (page.type & VMemoryPageType::LEADER) {
    return vmemory.my_nid;

  } else {
    assert(page.leader_nid != NodeID::NONE);
    return page.leader_nid;
  }
}

/**
 * Get meta data.
 * @param addr Target Address.
 * @return
 */
std::string VMemory::Accessor::get_meta_area(vaddr_t addr) {
  assert((AddressRegion::MASK & addr) == AddressRegion::META);
  Page& page = get_page(addr, true);

  return std::string(reinterpret_cast<char*>(page.value.get()), page.size);
}

/**
 * Get program data.
 * @param addr Target address.
 * @return
 */
std::string VMemory::Accessor::get_program_area(vaddr_t addr) {
  Page& page = get_page(addr, true);

  return std::string(reinterpret_cast<const char*>(page.value.get()), page.size);
}

VMemory::Accessor::MasterKey VMemory::Accessor::keep_master(vaddr_t addr) {
  if (addr == VADDR_NULL)  {
    return MasterKey();
  }

  addr = get_upper_addr(addr);
  Page& page = get_page(addr, true);

  assert(~page.type & VMemoryPageType::PROGRAM);
  if (page.type & VMemoryPageType::LEADER) {
    page.master_count++;
    return MasterKey(&page.master_count, [](int* master_count){
        (*master_count)--;
      });

  } else {
    vmemory.send_command_stand(page, addr);
    throw InterruptMemoryRequire(addr);
  }
}

/**
 * For debug, show all memory dump there are store in this node.
 * This method is usable when compiled by debug mode, otherwise, this method do nothing.
 */
void VMemory::Accessor::print_dump() {
#ifndef NDEBUG
  for (auto& it_page : vmemory.pages) {
    vaddr_t addr = it_page.first;
    Page& page = it_page.second;

    Logger::dbg_raw(CoreMid::L1007, "addr:%s", Convert::vaddr2str(addr).c_str());
    if ((addr & AddressRegion::MASK) == AddressRegion::META) {
      Logger::dbg_raw(CoreMid::L1007, "value:%s",
                      std::string(reinterpret_cast<const char*>(page.value.get()), page.size).
                      c_str());

    } else if ((addr & AddressRegion::MASK) == AddressRegion::PROGRAM) {
      picojson::value v;
      picojson::parse(v, std::string(reinterpret_cast<char*>(page.value.get()), page.size));
      Logger::dbg_raw(CoreMid::L1007, v.serialize(true));
      if (v.get<picojson::object>().at("program_type").get<std::string>() == "01") {
        Logger::dbg_raw(CoreMid::L1007, "code:");
        for (auto& code : v.get<picojson::object>().at("code").get<picojson::array>()) {
          Logger::dbg_raw(CoreMid::L1007, "  %s", Util::code2str(Convert::json2code(code)).c_str());
        }
      }
    } else {
      Logger::dbg_raw(CoreMid::L1007, "value(size=%" PRIu64 "):", page.size);
      std::string tmp;
      for (unsigned int i = 0; i < page.size; i ++) {
        if (i % 16 == 0) {
          if (i != 0) {
            Logger::dbg_raw(CoreMid::L1007, tmp);
          }
          tmp = Convert::vaddr2str(addr + i) + " : ";
        }
        tmp += Convert::int2str(0xFF & page.value[i]) + " ";
      }
      Logger::dbg_raw(CoreMid::L1007, tmp);
    }
  }
#endif
}

/**
 */
const uint8_t* VMemory::Accessor::read_raw(vaddr_t src) {
  Page& page = get_page(get_upper_addr(src), true);
  assert(page.size >= get_lower_addr(src));

  return reinterpret_cast<const uint8_t*>(page.value.get() + get_lower_addr(src));
}

/**
 */
uint8_t* VMemory::Accessor::read_writable(vaddr_t src) {
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
 * Change the size of allocation pointed to by addr to size.
 * The same behave to alloc if addr is VADDR_NULL.
 * @param addr Address that were allocated via the preceding alloc or realloc.
 * @param size Size to re-allocate.
 * @return A address to re-allocated memory.
 */
vaddr_t VMemory::Accessor::realloc(vaddr_t addr, uint64_t size) {
  if (addr == VADDR_NULL) return this->alloc(size);
  if (addr != get_upper_addr(addr)) {
    /// @todo error
    assert(false);
  }
  if (size == 0) size = 1;

  Page& page = get_page(addr, false);
  assert(~page.type & VMemoryPageType::PROGRAM);
  if (page.type & VMemoryPageType::LEADER) {
    AddressRegion::Type old_type = static_cast<AddressRegion::Type>(addr & AddressRegion::MASK);
    AddressRegion::Type new_type = get_addr_type(size);
    if (old_type == new_type) {
      std::unique_ptr<uint8_t[]> tmp(new uint8_t[size]);
      if (page.size < size) {
        std::memcpy(tmp.get(), page.value.get(), page.size);
        std::memset(tmp.get() + page.size, 0, size - page.size);

      } else {
        std::memcpy(tmp.get(), page.value.get(), size);
      }
      page.size = size;
      page.value.swap(tmp);

      for (auto& to : page.hint) {
        vmemory.send_command_copy(to, page, addr);
      }
      return addr;

    } else {
      vaddr_t new_addr = vmemory.alloc_addr(*this, get_addr_type(size));

      Page& new_page = vmemory.pages.at(new_addr);
      new_page.value.reset(new uint8_t[size]);
      if (page.size < size) {
        std::memcpy(new_page.value.get(), page.value.get(), page.size);
        std::memset(new_page.value.get() + page.size, 0, size - page.size);

      } else {
        std::memcpy(new_page.value.get(), page.value.get(), size);
      }
      new_page.size = size;

      this->free(addr);

      return new_addr;
    }

  } else {
    assert(page.hint.size() == 1);
    vmemory.send_command_stand(page, addr);
    throw InterruptMemoryRequire(addr);
  }
}

/**
 * Reserve address in program area.
 * This method must use when loading program only.
 * Each address is avoied collision (Only this node but enough when load).
 * @return A reserved address.
 */
vaddr_t VMemory::Accessor::reserve_program_area() {
  vaddr_t new_addr;

  do {
    new_addr = AddressRegion::PROGRAM | (~AddressRegion::MASK & vmemory.rnd());
  } while (vmemory.pages.find(new_addr) != vmemory.pages.end());

  vmemory.pages.insert(std::make_pair(new_addr, Page(VMemoryPageType::PROGRAM, true,
                                                     NodeID::NONE, std::set<NodeID>())));

  return new_addr;
}

/**
 * Set meta data.
 * if addr is VADDR_NULL then assign automatic by assign_addr.
 * if addr is not null then return address is equal to addr.
 * @param data Meta data.
 * @param addr Assigned address.
 */
vaddr_t VMemory::Accessor::set_meta_area(const std::string& data, vaddr_t addr) {
  if (addr == VADDR_NULL) {
    addr = vmemory.alloc_addr(*this, AddressRegion::META);

  } else {
    assert(vmemory.is_loading);
    assert(vmemory.pages.find(addr) == vmemory.pages.end());
    vmemory.pages.insert(std::make_pair(addr, Page(VMemoryPageType::LEADER, true, data,
                                                   vmemory.my_nid, std::set<NodeID>())));
  }

  return addr;
}

vaddr_t VMemory::Accessor::set_meta_area(const std::string& data, vaddr_t addr,
                                         const NodeID& leader_nid) {
  assert(addr != VADDR_NULL);
  assert(vmemory.pages.find(addr) == vmemory.pages.end());
  vmemory.pages.insert(std::make_pair(addr, Page(VMemoryPageType::NONE, true, data,
                                                 leader_nid, std::set<NodeID>())));

  return addr;
}

/**
 * Set program data to be selected address.
 * Raise assert when selected address is set yet.
 * @param addr Target address.
 * @param data Program data.
 */
void VMemory::Accessor::set_program_area(vaddr_t addr, const std::string& data) {
  assert((AddressRegion::MASK & addr) == AddressRegion::PROGRAM);
  auto it_page = vmemory.pages.find(addr);
  if (it_page == vmemory.pages.end()) {
    vmemory.pages.insert(std::make_pair(addr, Page(VMemoryPageType::PROGRAM, true, data,
                                                   NodeID::NONE, std::set<NodeID>())));

  } else {
    Page& page = it_page->second;
    assert(page.size == 0);
    page.size = data.size();
    page.value.reset(new uint8_t[page.size]);
    std::memcpy(page.value.get(), data.data(), page.size);
  }
}

/**
 * Change meta data.
 * @param addr Target address.
 * @param data Meta data.
 */
void VMemory::Accessor::update_meta_area(vaddr_t addr, const std::string& data) {
  assert((AddressRegion::MASK & addr) == AddressRegion::META);
  Page& page = get_page(addr, true);

  if (page.size == data.size() &&
      std::memcmp(page.value.get(), data.data(), page.size) == 0) return;

  assert(~page.type & VMemoryPageType::PROGRAM);
  if (page.type & VMemoryPageType::LEADER) {
    if (page.size != data.size()) {
      page.size = data.size();
      page.value.reset(new uint8_t[page.size]);
    }
    std::memcpy(page.value.get(), data.data(), page.size);
    for (auto& it_hint : page.hint) {
      vmemory.send_command_copy(it_hint, page, addr);
    }

  } else {
    assert(page.hint.size() == 1);
    page.flg_update = false;
    vmemory.send_command_update(*page.hint.begin(), addr,
                                reinterpret_cast<const uint8_t*>(data.data()), data.size());
  }
}

/**
 */
void VMemory::Accessor::write_copy(vaddr_t dst, vaddr_t src, uint64_t size) {
  Page& src_page = get_page(get_upper_addr(src), true);
  Page& dst_page = get_page(get_upper_addr(dst), false);

  assert(~dst_page.type & VMemoryPageType::PROGRAM);
  if (dst_page.type & VMemoryPageType::LEADER) {
    assert(dst_page.size >= get_lower_addr(dst) + size);
    std::memmove(dst_page.value.get() + get_lower_addr(dst),
                 src_page.value.get() + get_lower_addr(src), size);

  } else {
    assert(dst_page.hint.size() == 1);
    dst_page.flg_update = false;
    vmemory.send_command_update(*dst_page.hint.begin(), dst,
                                reinterpret_cast<const uint8_t*>(src_page.value.get() +
                                                                 get_lower_addr(src)), size);
  }
}

void VMemory::Accessor::write_copy(vaddr_t dst, const uint8_t *src, uint64_t size) {
  Page& dst_page = get_page(get_upper_addr(dst), false);

  assert(~dst_page.type & VMemoryPageType::PROGRAM);
  if (dst_page.type & VMemoryPageType::LEADER) {
    assert(dst_page.size >= get_lower_addr(dst) + size);
    std::memmove(dst_page.value.get() + get_lower_addr(dst), src, size);

  } else {
    assert(dst_page.hint.size() == 1);
    dst_page.flg_update = false;
    vmemory.send_command_update(*dst_page.hint.begin(), dst,
                                reinterpret_cast<const uint8_t*>(src), size);
  }
}

void VMemory::Accessor::write_fill(vaddr_t dst, uint8_t c, uint64_t size) {
  Page& page = get_page(get_upper_addr(dst), false);

  assert(~page.type & VMemoryPageType::PROGRAM);
  if (page.type & VMemoryPageType::LEADER) {
    std::memset(page.value.get() + get_lower_addr(dst), c, size);
    for (auto& it_hint : page.hint) {
      vmemory.send_command_copy(it_hint, page, get_upper_addr(dst));
    }

  } else {
    assert(page.hint.size() == 1);
    page.flg_update = false;
    std::unique_ptr<char[]> buffer(new char[size]);
    std::memset(buffer.get(), c, size);
    vmemory.send_command_update(*page.hint.begin(), dst,
                                reinterpret_cast<const uint8_t*>(buffer.get()), size);
  }
}

/**
 * Write out the data selected by get_raw_writable.
 */
void VMemory::Accessor::write_out() {
  auto it = raw_writable.begin();

  while (it != raw_writable.end()) {
    Page& page = get_page(it->first, false);
    assert(~page.type & VMemoryPageType::PROGRAM);
    if (page.type & VMemoryPageType::LEADER) {
      page.value.swap(it->second);
      for (auto& it_hint : page.hint) {
        vmemory.send_command_copy(it_hint, page, it->first);
      }
    } else {
      assert(page.hint.size() == 1);
      page.flg_update = false;
      vmemory.send_command_update(*page.hint.begin(), it->first,
                                  it->second.get(), page.size);
    }

    it = raw_writable.erase(it);
  }
}

/**
 * Get a memory page by a address.
 * Raise exception of require if data is old or don't exist in this node.
 * @param addr
 * @param readable
 * @return
 */
VMemory::Page& VMemory::Accessor::get_page(vaddr_t addr, bool readable) {
  assert(addr != VADDR_NULL);
  assert((addr & AddressRegion::MASK) == AddressRegion::META ||
         (addr & AddressRegion::MASK) == AddressRegion::PROGRAM ||
         addr == get_upper_addr(addr));
  auto page = vmemory.pages.find(addr);

  if (page == vmemory.pages.end()) {
    vmemory.send_command_require(NodeID::BROADCAST, addr);
    throw InterruptMemoryRequire(addr);

  } else if (readable && page->second.flg_update == false) {
    assert(~page->second.type & VMemoryPageType::LEADER && page->second.hint.size() == 1);
    vmemory.send_command_require(*(page->second.hint.begin()), addr);
    throw InterruptMemoryRequire(addr);
  }
  assert(page->second.type & VMemoryPageType::LEADER || page->second.master_count == 0);
  page->second.referral_count = 0;
  return page->second;
}

/**
 * Constructor with delegate.
 * @param delegate Delegate for controller.
 * @param nid Node-id of this node.
 */
VMemory::VMemory(VMemoryDelegate& delegate_, const NodeID& nid) :
    my_nid(nid),
    delegate(delegate_),
    packet_controller(Module::MEMORY),
    rnd(std::random_device()()) {
  packet_controller.initialize(this);
}

vaddr_t VMemory::get_lower_addr(vaddr_t addr) {
  return addr & (~UPPER_MASKS[addr >> 60]);
}

vaddr_t VMemory::get_upper_addr(vaddr_t addr) {
  return addr & UPPER_MASKS[addr >> 60];
}

bool VMemory::is_program(vaddr_t addr) {
  return (addr & AddressRegion::MASK) == AddressRegion::PROGRAM;
}

/**
 * Create a new accessor, accessor is make per thread.
 * @return
 */
std::unique_ptr<VMemory::Accessor> VMemory::get_accessor() {
  return std::unique_ptr<VMemory::Accessor>(new Accessor(*this));
}

/**
 * Initialize vmemory with process-id and node-id.
 * @param pid Process-id of this memory space.
 */
void VMemory::initialize(const vpid_t& pid) {
  my_pid = pid;
}

/**
 * When reveive packet, relay it to PacketController module.
 * @param packet A received packet.
 */
void VMemory::recv_packet(const Packet& packet) {
  packet_controller.recv(packet);
}

/**
 * Release a binded address for be used memory to be unused.
 * @param addr Address to release.
 */
void VMemory::release_addr(vaddr_t addr) {
  assert(false);
}

/**
 * Switch memory's loading mode.
 * @param flg True if enable loading mode.
 */
void VMemory::set_loading(bool flg) {
  is_loading = flg;
}

VMemory::PacketAlloc::PacketAlloc(VMemory& vmemory_, Accessor& accessor_) :
    vmemory(vmemory_),
    accessor(accessor_) {
}

const PacketController::Define& VMemory::PacketAlloc::get_define() {
  static const PacketController::Define DEFINE = {
    "alloc",
    0,
    0,
    Module::MEMORY
  };

  return DEFINE;
}

void VMemory::PacketAlloc::on_error(const Packet& packet) {
  accessor.acceptor_nid.push_back(packet.src_nid);
  accessor.is_alloc_cancel = true;
  update_status();
}

void VMemory::PacketAlloc::on_packet_error(PacketError::Type code) {
  accessor.acceptor_nid.push_back(NodeID::NONE);
  accessor.is_alloc_cancel = true;
  update_status();
}

void VMemory::PacketAlloc::on_reply(const Packet& packet) {
  accessor.acceptor_nid.push_back(packet.src_nid);
  update_status();
}

void VMemory::PacketAlloc::update_status() {
  if (accessor.acceptor_nid.size() != 4) {
    return;
  }

  if (!accessor.is_alloc_cancel) {
    accessor.is_alloc = false;

    auto page = vmemory.pages.find(accessor.alloc_addr);
    if (page == vmemory.pages.end()) {
      vmemory.pages.insert(std::make_pair(accessor.alloc_addr,
                                          Page(VMemoryPageType::LEADER, true,
                                               vmemory.my_nid, std::set<NodeID>())));
    } else {
      page->second.type |= VMemoryPageType::LEADER;
    }

  } else {
    vmemory.send_command_alloc_cancel(accessor, accessor.alloc_addr);

    accessor.alloc_addr = get_upper_addr(accessor.alloc_type |
                                         (~AddressRegion::MASK & vmemory.rnd()));
    while ((accessor.alloc_type == AddressRegion::META && accessor.alloc_addr <= 0xFF) ||
           vmemory.pages.find(accessor.alloc_addr) == vmemory.pages.end()) {
      accessor.alloc_addr = get_upper_addr(accessor.alloc_type |
                                           (~AddressRegion::MASK & vmemory.rnd()));
    }
    vmemory.send_command_alloc(accessor, accessor.alloc_addr);
  }
}

AddressRegion::Type VMemory::get_addr_type(uint64_t size) {
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

/**
 * Get a new address to allocate a new memory.
 * @param accessor Accessor context.
 * @param type Address-type of memory.
 */
vaddr_t VMemory::alloc_addr(Accessor& accessor, AddressRegion::Type type) {
  if (is_loading) {
    vaddr_t new_addr = get_upper_addr(type | (~AddressRegion::MASK & rnd()));
    while ((type == AddressRegion::META && new_addr <= 0xFF) ||
           pages.find(new_addr) == pages.end()) {
      new_addr = get_upper_addr(type | (~AddressRegion::MASK & rnd()));
    }
    return new_addr;
  }

  if (accessor.is_alloc == true) {
    throw InterruptMemoryRequire(VADDR_NULL);

  } else if (accessor.alloc_addr == VADDR_NULL) {
    accessor.alloc_type = type;
    accessor.is_alloc = true;
    accessor.alloc_addr = get_upper_addr(type | (~AddressRegion::MASK & rnd()));
    while ((type == AddressRegion::META && accessor.alloc_addr <= 0xFF) ||
           pages.find(accessor.alloc_addr) == pages.end()) {
      accessor.alloc_addr = get_upper_addr(type | (~AddressRegion::MASK & rnd()));
    }
    send_command_alloc(accessor, accessor.alloc_addr);

    throw InterruptMemoryRequire(VADDR_NULL);

  } else {
    vaddr_t new_addr = accessor.alloc_addr;
    accessor.alloc_addr = VADDR_NULL;
    return new_addr;
  }
}

NodeID VMemory::get_hash_id(vaddr_t addr) {
  std::string key = my_pid + Convert::vaddr2str(addr);
  return NodeID::from_str(Util::calc_md5(key));
}

/**
 * When receive general command, relay it to capable method.
 * @param packet A packet.
 */
void VMemory::packet_controller_on_recv(const Packet& packet) {
  if (packet.command == "alloc") {
    recv_command_alloc(packet);

  } else if (packet.command == "alloc_cancel") {
    recv_command_alloc_cancel(packet);

  } else {
    /// @todo error
    assert(false);
  }
}

/**
 * When send packet event has happen on PacketController, relay it to delegate.
 * @param packet A packet to relay.
 */
void VMemory::packet_controller_send(const Packet& packet) {
  delegate.vmemory_send_packet(*this, packet);
}

/**
 * When receive alloc command, check using address and send reply packet.
 * @param packet Command packet containing addr, nid.
 */
void VMemory::recv_command_alloc(const Packet& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  NodeID leader_nid = NodeID::from_json(packet.content.at("nid"));

  auto page = pages.find(addr);
  if (page == pages.end()) {
    pages.insert(std::make_pair(addr, Page(VMemoryPageType::ACCEPTOR, false,
                                           leader_nid, std::set<NodeID>())));
    packet_controller.send_reply(packet, picojson::object());

  } else if (page->second.leader_nid == leader_nid) {
    assert(page->second.type & VMemoryPageType::ACCEPTOR);
    packet_controller.send_reply(packet, picojson::object());

  } else {
    packet_controller.send_error(packet, picojson::object());
  }
}

/**
 * When receive alloc_cancel command, remove assigned page by alloc command.
 * @param packet Command packet containing addr, nid.
 */
void VMemory::recv_command_alloc_cancel(const Packet& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  NodeID leader_nid = NodeID::from_json(packet.content.at("nid"));

  auto page = pages.find(addr);
  if (page != pages.end() && page->second.leader_nid == leader_nid) {
    assert(page->second.type & VMemoryPageType::ACCEPTOR);
    pages.erase(page);
  }
}

/**
 * When receive copy command, check and copy value on target address.
 * At last, pass update event to VM throught a delegate.
 * @param packet Command packet containing target address and value.
 */
void VMemory::recv_command_copy(const Packet& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  const std::string& value = Convert::json2bin(packet.content.at("value"));
  uint64_t key = Convert::json2int<uint64_t>(packet.content.at("key"));
  NodeID leader_nid = NodeID::from_json(packet.content.at("leader"));

  if (get_upper_addr(addr) != addr) {
    /// @todo error
    assert(false);
  }

  auto it_page = pages.find(addr);
  if (it_page == pages.end()) {
    if (value.size() == 0) return;

    auto it_ri = requiring.find(addr);
    if (it_ri != requiring.end()) {
      std::set<NodeID> hint;
      hint.insert(packet.src_nid);
      pages.insert(std::make_pair
                   (addr, Page(is_program(addr) ? VMemoryPageType::PROGRAM : VMemoryPageType::NONE,
                               true, value, leader_nid, hint)));
      requiring.erase(it_ri);
      send_command_copy_reply(packet.src_nid, addr, key);

    } else {
      send_command_unwant(packet.src_nid, addr);
    }

  } else {
    Page& page = it_page->second;
    assert(page.hint.size() == 1);
    assert(*page.hint.begin() == packet.src_nid);

    if (page.type & VMemoryPageType::LEADER) {
      return;

    } else if (page.referral_count >= MEMORY_REFERRAL_LIMIT &&
               requiring.find(addr) == requiring.end()) {
      send_command_unwant(packet.src_nid, addr);
      pages.erase(addr);

    } else if (value.size() != 0) {
      if (page.size != value.size()) {
        page.size = value.size();
        page.value.reset(new uint8_t[page.size]);
      }
      std::memcpy(page.value.get(), value.data(), page.size);
      page.flg_update = true;
      page.referral_count++;
      send_command_copy_reply(packet.src_nid, addr, key);

    } else {
      pages.erase(addr);
    }

    auto it_ri = requiring.find(addr);
    if (it_ri != requiring.end()) {
      requiring.erase(it_ri);
    }
  }

  delegate.vmemory_recv_update(*this, addr);
}

/**
 * When receive copy reply command, check history and send new packet if a page was updated.
 * @param packet Packet command containing target address and key code that was send by a copy command.
 */
void VMemory::recv_command_copy_reply(const Packet& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  uint64_t key = Convert::json2int<uint64_t>(packet.content.at("key"));
  assert(addr == get_upper_addr(addr));

  auto it_page = pages.find(addr);
  if (it_page == pages.end()) return;

  Page& page = it_page->second;
  auto it_history = page.send_copy_history.find(packet.src_nid);
  if (it_history == page.send_copy_history.end()) return;

  if (it_history->second.key == key) {
    page.send_copy_history.erase(it_history);

  } else {
    page.send_copy_history.erase(it_history);
    send_command_copy(packet.src_nid, page, addr);
  }
}

/**
 * When receive free command, update page to 0-size if this node is master of target address,
 * or delegate command to master node if this node isn't master of target address.
 * @param packet Command packet containing target address.
 */
void VMemory::recv_command_free(const Packet& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  assert(addr == get_upper_addr(addr));

  auto it_page = pages.find(addr);
  if (it_page == pages.end()) {
    /// @todo Relay bload cast when packet was not bload cast.
  }

  Page& page = it_page->second;
  assert(~page.type & VMemoryPageType::PROGRAM);
  if (page.type & VMemoryPageType::LEADER) {
    if (page.master_count != 0) {
      /// @todo error
      assert(false);
    }
    page.size = 0;
    page.value.reset();
    for (auto& dst_nid : page.hint) {
      send_command_copy(dst_nid, page, addr);
    }
    release_addr(addr);
    pages.erase(addr);

  } else {
    assert(page.hint.size() == 1);
    send_command_free(*page.hint.begin(), addr);
  }
}

/**
 * When receive give command to pass master flag, change flag and save value if target node is this node.
 * Only update hint if target node isn't this node.
 * @param packet Command packet containing target address, value, destination node-id, and hint node-id.
 */
void VMemory::recv_command_give(const Packet& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  const std::string& value = Convert::json2bin(packet.content.at("value"));
  const NodeID& dst_nid = NodeID::from_json(packet.content.at("dst_nid"));
  picojson::array js_hint = packet.content.at("hint_nid").get<picojson::array>();

  assert(addr == get_upper_addr(addr));

  auto it_page = pages.find(addr);
  if (dst_nid == my_nid) {
    std::set<NodeID> hint;
    for (auto& js_h : js_hint) {
      const NodeID& hint_node = NodeID::from_json(js_h);
      if (hint_node != my_nid) {
        hint.insert(hint_node);
      }
    }
    if (packet.src_nid != NodeID::SERVER) {
      hint.insert(packet.src_nid);
    }

    if (it_page == pages.end()) {
      pages.insert(std::make_pair(addr, Page(VMemoryPageType::LEADER, true, value, my_nid, hint)));

    } else {
      Page& page = it_page->second;
      assert(~page.type & VMemoryPageType::LEADER || page.type & VMemoryPageType::PROGRAM);
      // Skip if page type is program and I have it yet.
      if (page.type == VMemoryPageType::PROGRAM) return;

      page.type |= VMemoryPageType::LEADER;
      page.flg_update = true;
      if (page.size != value.size()) {
        page.size = value.size();
        page.value.reset(new uint8_t[page.size]);
      }
      std::memcpy(page.value.get(), value.data(), page.size);
      page.hint = hint;
      page.referral_count = 0;
    }

    auto it_ri = requiring.find(addr);
    if (it_ri != requiring.end()) {
      requiring.erase(it_ri);
    }

    delegate.vmemory_recv_update(*this, addr);

  } else {
    if (it_page == pages.end()) {
      send_command_unwant(dst_nid, addr);

    } else {
      Page& page = it_page->second;
      assert(~page.type & VMemoryPageType::LEADER);

      page.hint.clear();
      page.hint.insert(dst_nid);
    }
  }
}

/**
 * When receive require command, broad cast or relay to another node if value is not exist in this node.
 * Reply copy command if value is stored in this node.
 * @param packet Command packet containing target address and node-id that node required a value.
 */
void VMemory::recv_command_require(const Packet& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  NodeID src_nid = NodeID::from_json(packet.content.at("src_nid"));

  assert(addr == get_upper_addr(addr));
  if (src_nid == my_nid) return;

  auto it_page = pages.find(addr);
  if (it_page == pages.end()) {
    if (src_nid != NodeID::BROADCAST && src_nid != my_nid) {
      picojson::object param;

      param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
      param.insert(std::make_pair("src_nid", src_nid.to_json()));

      packet_controller.send("require", Module::MEMORY, true,
                             packet.pid, NodeID::BROADCAST, param);
    }
    return;
  }

  Page& page = it_page->second;
  if (page.type & VMemoryPageType::LEADER) {
    page.hint.insert(src_nid);

    send_command_copy(src_nid, page, addr);

  } else if (~page.type & VMemoryPageType::PROGRAM) {
    picojson::object param;

    param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
    param.insert(std::make_pair("src_nid", src_nid.to_json()));

    packet_controller.send("require", Module::MEMORY, true,
                           packet.pid, *page.hint.begin(), param);
  }
}

/**
 * When receive stand command, send give command to pass master flag if it can.
 * To pass master flag, this node have master flag for taget address and not locked for master by runing thread.
 * @param packet Command packet containing target address.
 */
void VMemory::recv_command_stand(const Packet& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));

  assert(addr == get_upper_addr(addr));
  assert(packet.src_nid != my_nid);

  auto it_page = pages.find(addr);
  if (it_page == pages.end()) {
    return;
  }

  Page& page = it_page->second;
  if (page.type & VMemoryPageType::LEADER && page.master_count == 0) {
    assert(page.flg_update == true);
    send_command_give(page, addr, packet.src_nid);

    page.type = VMemoryPageType::NONE;
    page.hint.clear();
    page.hint.insert(packet.src_nid);
  }

  requiring.erase(addr);
}

/**
 * When receive unwant command, remove source node from a set of hint(copy target) and history.
 * @param packet Command packet containing target address.
 */
void VMemory::recv_command_unwant(const Packet& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));

  auto it_page = pages.find(get_upper_addr(addr));
  if (it_page == pages.end()) return;

  Page& page = it_page->second;
  auto it_hint = page.hint.find(packet.src_nid);
  if (it_hint != page.hint.end()) {
    page.hint.erase(it_hint);
  }
  auto it_copy = page.send_copy_history.find(packet.src_nid);
  if (it_copy != page.send_copy_history.end()) {
    page.send_copy_history.erase(it_copy);
  }
}

/**
 * When receive update command, check and update master value on target address.
 * Relay update command to master node if this node isn't master.
 * Send give command if this node is master of the page and referal count is more than threshold.
 * @param packet Command packet containing target address and value to update.
 */
void VMemory::recv_command_update(const Packet& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  const std::string& value = Convert::json2bin(packet.content.at("value"));

  auto it_page = pages.find(get_upper_addr(addr));
  if (it_page == pages.end()) {
    /// @todo relay
    assert(false);
    return;
  }

  Page& page = it_page->second;
  if (page.type & VMemoryPageType::LEADER) {
    if (page.size < get_lower_addr(addr) + value.size()) {
      /// @todo error
      assert(false);
      return;
    }
    std::memcpy(page.value.get() + get_lower_addr(addr), value.data(), value.size());

    page.referral_count++;
    if (page.referral_count >= MEMORY_REFERRAL_LIMIT && page.master_count == 0) {
      assert(page.flg_update == true);
      send_command_give(page, get_upper_addr(addr), packet.src_nid);

      page.type = VMemoryPageType::NONE;
      page.hint.clear();
      page.hint.insert(packet.src_nid);
    }

    delegate.vmemory_recv_update(*this, get_upper_addr(addr));

  } else if (~page.type & VMemoryPageType::LEADER) {
    send_command_update(*page.hint.begin(), addr,
                        reinterpret_cast<const uint8_t*>(value.data()), value.size());

  } else {
    /// @todo error
    assert(false);
  }
}

void VMemory::send_command_alloc(Accessor& accessor, vaddr_t addr) {
  picojson::object param;
  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  param.insert(std::make_pair("nid", my_nid.to_json()));

  accessor.acceptor_nid.clear();
  accessor.is_alloc_cancel = false;
  NodeID acceptor_nid = get_hash_id(addr);
  for (int i = 0 ; i < 4; i ++) {
    packet_controller.send(std::unique_ptr<PacketController::Behavior>
                           (new PacketAlloc(*this, accessor)), my_pid, acceptor_nid, param);
    acceptor_nid = acceptor_nid + NodeID::QUARTER;
  }
}

void VMemory::send_command_alloc_cancel(Accessor& accessor, vaddr_t addr) {
  picojson::object param;
  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  param.insert(std::make_pair("nid", my_nid.to_json()));

  for (NodeID& acceptor_nid : accessor.acceptor_nid) {
    packet_controller.send("alloc_cancel", Module::MEMORY, true,
                           my_pid, acceptor_nid, param);
  }
}

/**
 * Send copy command for update page value in another copy node.
 * This command is used to copy value from master to copy node.
 * Inhibit command if responce (for previous copy command) was not received and
 * didn't spend interval time yet.
 * Update key code and timestamp if command was send.
 * @param dst_nid Destination node-id.
 * @param page Target page having value.
 * @param addr Target address to copy.
 */
void VMemory::send_command_copy(const NodeID& dst_nid, Page& page, vaddr_t addr) {
  assert(~page.type & VMemoryPageType::LEADER);
  assert(dst_nid != my_nid);
  assert(get_upper_addr(addr) == addr);
  std::time_t now = time(nullptr);
  uint64_t key = rnd();
  auto history = page.send_copy_history.find(dst_nid);

  if (history == page.send_copy_history.end() ||
      history->second.time + MEMORY_REQUIRE_INTERVAL < now) {
    picojson::object param;
    param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
    param.insert(std::make_pair("value", Convert::bin2json(page.value.get(), page.size)));
    param.insert(std::make_pair("key", Convert::int2json(key)));
    packet_controller.send("copy", Module::MEMORY, true, my_pid, dst_nid, param);

    if (history != page.send_copy_history.end()) {
      history->second.time = now;
    }
  }

  if (history == page.send_copy_history.end()) {
    SendCopyHistory new_history;
    new_history.key  = key;
    new_history.time = now;
    page.send_copy_history.insert(std::make_pair(dst_nid, new_history));

  } else {
    history->second.key = key;
  }
}

void VMemory::send_command_copy_reply(const NodeID& dst_nid, vaddr_t addr, uint64_t key) {
  assert(dst_nid != my_nid);
  assert(get_upper_addr(addr) == addr);

  picojson::object param;
  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  param.insert(std::make_pair("key", Convert::int2json(key)));

  packet_controller.send("copy_reply", Module::MEMORY, true, my_pid, dst_nid, param);
}

/**
 * Send free command.
 * @param dst_nid Destination node-id.
 * @param addr Target address to free.
 */
void VMemory::send_command_free(const NodeID& dst_nid, vaddr_t addr) {
  picojson::object param;

  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));

  packet_controller.send("free", Module::MEMORY, true, my_pid, dst_nid, param);
}

/**
 * Send give command for giving master flag of page.
 * @param page Target page having value.
 * @param addr Target address to give master flag.
 * @param dst_nid Node-id target of give master flag.
 */
void VMemory::send_command_give(Page& page, vaddr_t addr, const NodeID& dst_nid) {
  assert(page.type & VMemoryPageType::LEADER && page.master_count == 0);
  assert(addr == get_upper_addr(addr));
  picojson::object param;
  picojson::array hint;

  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  param.insert(std::make_pair("value", Convert::bin2json(page.value.get(), page.size)));
  param.insert(std::make_pair("dst_nid", dst_nid.to_json()));
  for (auto& h : page.hint) {
    hint.push_back(h.to_json());
  }
  param.insert(std::make_pair("hint_nid", picojson::value(hint)));

  packet_controller.send("give", Module::MEMORY, true, my_pid, NodeID::BROADCAST, param);
}

/**
 * Send release command for releaseing allocation of page.
 * @param addrs Some addresses to release.
 */
void VMemory::send_command_release(std::set<vaddr_t> addrs) {
  picojson::object param;
  picojson::array js_addrs;

  for (auto addr : addrs) {
    js_addrs.push_back(Convert::vaddr2json(addr));
  }
  param.insert(std::make_pair("addrs", picojson::value(js_addrs)));

  packet_controller.send("release", Module::MEMORY, true, my_pid, NodeID::BROADCAST, param);
}

/**
 * Send require command for requireing value in target address.
 * @param dst_nid Destination node-id.
 * @param addr Target address to get value.
 */
void VMemory::send_command_require(const NodeID& dst_nid, vaddr_t addr) {
  assert(get_upper_addr(addr) == addr);
  requiring.insert(addr);
  picojson::object param;

  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  param.insert(std::make_pair("src_nid", my_nid.to_json()));

  packet_controller.send("require", Module::MEMORY, true, my_pid, dst_nid, param);
}

/**
 * Send stand command for emmiting to stand for master of target page.
 * @param page Target page.
 * @param addr Target address for stainding.
 */
void VMemory::send_command_stand(Page& page, vaddr_t addr) {
  assert(~page.type & VMemoryPageType::LEADER);
  assert(page.hint.size() == 1);
  assert(addr == get_upper_addr(addr));
  picojson::object param;

  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));

  packet_controller.send("stand", Module::MEMORY, true, my_pid, *page.hint.begin(), param);
}

/**
 * Send unwant command for emiting to a value on target address is not need for this node.
 * @param dst_nid Destination node-id.
 * @param addr Target address.
 */
void VMemory::send_command_unwant(const NodeID& dst_nid, vaddr_t addr) {
  picojson::object param;
  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  packet_controller.send("unwant", Module::MEMORY, true, my_pid, dst_nid, param);
}

/**
 * Send update command for update page value in master node.
 * @param dst_nid Destination node-id.
 * @param addr Target address to update.
 * @param data Pointer of storeing value to update.
 * @param size Size of data to update.
 */
void VMemory::send_command_update(const NodeID& dst_nid, vaddr_t addr,
                                  const uint8_t* data, uint64_t size) {
  picojson::object param;
  param.insert(std::make_pair("value", Convert::bin2json(data, size)));
  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  packet_controller.send("update", Module::MEMORY, true, my_pid, dst_nid, param);
}
}  // namespace processwarp
