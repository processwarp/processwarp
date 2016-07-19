
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
                    const NodeID& leader_nid_, const std::set<NodeID>& learner_nids_) :
    type(type_),
    flg_update(flg_update_),
    value(new uint8_t[value_str.size()]),
    size(value_str.size()),
    leader_nid(leader_nid_),
    learner_nids(learner_nids_),
    master_count(0),
    referral_count(0) {
  std::memcpy(value.get(), value_str.data(), size);
}

/**
 * Constructor with empty value.
 */
VMemory::Page::Page(VMemoryPageType::Type type_, bool flg_update_,
                    const NodeID& leader_nid_, const std::set<NodeID>& learner_nids_) :
    type(type_),
    flg_update(flg_update_),
    size(0),
    leader_nid(leader_nid_),
    learner_nids(learner_nids_),
    master_count(0),
    referral_count(0) {
}

/**
 * Constructor with memory space.
 * @param vmemory_ Virtual memory.
 */
VMemory::Accessor::Accessor(VMemory& vmemory_) :
    vmemory(vmemory_) {
}

VMemory::Accessor::~Accessor() {
  if (alloc_info) {
    alloc_info->is_cancel = true;
  }
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
  assert(page.master_count == 0 && raw_writable.find(addr) == raw_writable.end());
  vmemory.send_command_free(addr);
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
    vmemory.send_command_candidacy(addr, page);
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

      vmemory.send_command_write(NodeID::NONE, page, addr);
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
    vmemory.send_command_candidacy(addr, page);
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
 * if addr is VADDR_NULL then assign automatic by alloc_addr.
 * if addr is not null then return address is equal to addr.
 * @param data Meta data.
 * @param addr Assigned address.
 */
vaddr_t VMemory::Accessor::set_meta_area(const std::string& data, vaddr_t addr) {
  if (addr == VADDR_NULL) {
    addr = vmemory.alloc_addr(*this, AddressRegion::META);
    Page& page = vmemory.pages.at(addr);
    page.value.reset(new uint8_t[data.size()]);
    page.size = data.size();
    memcpy(page.value.get(), data.data(), page.size);

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
    vmemory.send_command_write(NodeID::NONE, page, addr);

  } else {
    vmemory.send_command_write_require(page, addr,
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
    vmemory.send_command_write(NodeID::NONE, dst_page, get_upper_addr(dst));

  } else {
    vmemory.send_command_write_require(dst_page, dst,
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
    vmemory.send_command_write(NodeID::NONE, dst_page, get_upper_addr(dst));

  } else {
    vmemory.send_command_write_require(dst_page, dst,
                                       reinterpret_cast<const uint8_t*>(src), size);
  }
}

void VMemory::Accessor::write_fill(vaddr_t dst, uint8_t c, uint64_t size) {
  Page& page = get_page(get_upper_addr(dst), false);

  assert(~page.type & VMemoryPageType::PROGRAM);
  if (page.type & VMemoryPageType::LEADER) {
    std::memset(page.value.get() + get_lower_addr(dst), c, size);
    vmemory.send_command_write(NodeID::NONE, page, get_upper_addr(dst));

  } else {
    std::unique_ptr<char[]> buffer(new char[size]);
    std::memset(buffer.get(), c, size);
    vmemory.send_command_write_require(page, dst,
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
      vmemory.send_command_write(NodeID::NONE, page, it->first);

    } else {
      vmemory.send_command_write_require(page, it->first,
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
  auto it_page = vmemory.pages.find(addr);

  if (it_page == vmemory.pages.end()) {
    vmemory.send_command_require(addr, VMemoryReadMode::CONTINUE, false);
    throw InterruptMemoryRequire(addr);
  }

  Page& page = it_page->second;
  if (readable && page.flg_update == false) {
    assert(~page.type & VMemoryPageType::LEADER);
    vmemory.send_command_require(addr, VMemoryReadMode::CONTINUE, false);
    throw InterruptMemoryRequire(addr);
  }
  assert(page.type & VMemoryPageType::LEADER || page.master_count == 0);
  assert(page.type & VMemoryPageType::ACCEPTOR || page.acceptor_nids.size() == 0);
  page.referral_count = 0;
  return page;
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
 * Switch memory's loading mode.
 * @param flg True if enable loading mode.
 */
void VMemory::set_loading(bool flg) {
  is_loading = flg;
}

VMemory::PacketAlloc::PacketAlloc(VMemory& vmemory_, std::shared_ptr<AllocInfo> alloc_info_) :
    vmemory(vmemory_),
    alloc_info(alloc_info_) {
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
  alloc_info->acceptor_nid.push_back(packet.src_nid);
  alloc_info->is_cancel = true;
  update_status();
}

void VMemory::PacketAlloc::on_packet_error(PacketError::Type code) {
  alloc_info->acceptor_nid.push_back(NodeID::NONE);
  alloc_info->is_cancel = true;
  update_status();
}

void VMemory::PacketAlloc::on_reply(const Packet& packet) {
  alloc_info->acceptor_nid.push_back(packet.src_nid);
  update_status();
}

void VMemory::PacketAlloc::update_status() {
  if (alloc_info->acceptor_nid.size() != 4) {
    return;
  }

  if (!alloc_info->is_cancel) {
    auto page = vmemory.pages.find(alloc_info->addr);
    if (page == vmemory.pages.end()) {
      vmemory.pages.insert(std::make_pair(alloc_info->addr,
                                          Page(VMemoryPageType::LEADER, true,
                                               vmemory.my_nid, std::set<NodeID>())));
    } else {
      page->second.type |= VMemoryPageType::LEADER;
      page->second.flg_update = true;
    }

    alloc_info->acceptor_nid.clear();
    alloc_info->is_finish = true;

  } else {
    vmemory.send_command_alloc_cancel(alloc_info);

    alloc_info->addr = get_upper_addr(alloc_info->type |
                                      (~AddressRegion::MASK & vmemory.rnd()));
    while ((alloc_info->type == AddressRegion::META && alloc_info->addr <= 0xFF) ||
           vmemory.pages.find(alloc_info->addr) != vmemory.pages.end()) {
      alloc_info->addr = get_upper_addr(alloc_info->type |
                                        (~AddressRegion::MASK & vmemory.rnd()));
    }

    alloc_info->is_cancel = false;
    vmemory.send_command_alloc(alloc_info);
  }
}

VMemory::PacketCandidacy::PacketCandidacy(VMemory& vmemory_, vaddr_t addr_) :
    vmemory(vmemory_),
    addr(addr_) {
}

const PacketController::Define& VMemory::PacketCandidacy::get_define() {
  static const PacketController::Define DEFINE = {
    "candidacy",
    0,
    0,
    Module::MEMORY
  };

  return DEFINE;
}

void VMemory::PacketCandidacy::on_error(const Packet& packet) {
  // Do nothing, may be retry after.
}

/**
 * When receive reply for candidacy command, set LEADER flag to target page.
 * @param packet A reply packet containing nothing.
 */
void VMemory::PacketCandidacy::on_reply(const Packet& packet) {
  auto page_it = vmemory.pages.find(addr);
  if (page_it == vmemory.pages.end()) {
    // Do nothing, may be retry after or will claim back right of leader by root acceptor.
    return;
  }

  Page& page = page_it->second;
  page.type |= VMemoryPageType::LEADER;
  page.flg_update = true;
}

void VMemory::PacketCandidacy::on_packet_error(PacketError::Type code) {
  /// @todo error
  assert(false);
}

VMemory::PacketClaimBack::PacketClaimBack(VMemory& vmemory_, vaddr_t addr_) :
    vmemory(vmemory_),
    addr(addr_) {
}

const PacketController::Define& VMemory::PacketClaimBack::get_define() {
  static const PacketController::Define DEFINE = {
    "claim_back",
    PacketMode::EXPLICIT,
    0,
    Module::MEMORY
  };

  return DEFINE;
}

void VMemory::PacketClaimBack::on_error(const Packet& packet) {
  auto page_it = vmemory.pages.find(addr);
  if (page_it == vmemory.pages.end()) {
    // Do nothing, maybe page is deleted or acceptor node is changed.
    return;
  }

  Page& page = page_it->second;
  assert(packet.src_nid != page.leader_nid);
}

/**
 * When receive reply for claim_back command, set LEADER flag to target page.
 * @param packet A reply packet containing nothing.
 */
void VMemory::PacketClaimBack::on_reply(const Packet& packet) {
  auto page_it = vmemory.pages.find(addr);
  if (page_it == vmemory.pages.end()) {
    // Do nothing, maybe page is deleted or acceptor node is changed.
    return;
  }

  Page& page = page_it->second;
  if (packet.src_nid == page.leader_nid) {
    page.type |= VMemoryPageType::LEADER;
    page.flg_update = true;
    page.leader_nid = vmemory.my_nid;
    vmemory.send_command_publish(NodeID::NONE, page, addr);
  }
}

void VMemory::PacketClaimBack::on_packet_error(PacketError::Type code) {
}

VMemory::PacketDelegate::PacketDelegate(VMemory& vmemory_) :
    vmemory(vmemory_) {
}

const PacketController::Define& VMemory::PacketDelegate::get_define() {
  static const PacketController::Define DEFINE = {
    "delegate",
    0,
    0,
    Module::MEMORY
  };

  return DEFINE;
}

/**
 * When receive reply for delegate command, unset delegate flag for a target page.
 * @param packet A reply packet containing a address of target.
 */
void VMemory::PacketDelegate::on_reply(const Packet& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));

  auto it = vmemory.pages.find(addr);
  if (it == vmemory.pages.end()) {
    return;
  }

  Page& page = it->second;
  page.type &= ~VMemoryPageType::ACCEPTOR;
}

void VMemory::PacketDelegate::on_packet_error(PacketError::Type code) {
  /// @todo error
  assert(false);
}

VMemory::PacketPublish::PacketPublish(VMemory& vmemory_, const NodeID& dst_nid_,
                                      vaddr_t addr_, uint64_t write_id_) :
    vmemory(vmemory_),
    dst_nid(dst_nid_),
    addr(addr_),
    write_id(write_id_) {
}

const PacketController::Define& VMemory::PacketPublish::get_define() {
  static const PacketController::Define DEFINE = {
    "publish",
    PacketMode::EXPLICIT,
    0,
    Module::MEMORY
  };

  return DEFINE;
}

/**
 * When receive error reply, it remove a source node from learners.
 * @param packet A packet not used.
 */
void VMemory::PacketPublish::on_error(const Packet& packet) {
  auto it_page = vmemory.pages.find(addr);

  if (it_page != vmemory.pages.end()) {
    Page& page = it_page->second;

    page.publish_history.erase(packet.src_nid);
    page.learner_nids.erase(packet.src_nid);
  }
}

/**
 * After receive reply packet, re-send publish command if needed (write_id has changed).
 * @param packet A packet not used.
 */
void VMemory::PacketPublish::on_reply(const Packet& packet) {
  auto it_page = vmemory.pages.find(addr);

  if (it_page == vmemory.pages.end()) {
    /// @todo publish freeing page
    assert(false);
    return;
  }

  Page& page = it_page->second;
  page.publish_history.erase(packet.src_nid);
  if (write_id != page.write_id &&
      page.learner_nids.find(packet.src_nid) != page.learner_nids.end()) {
    vmemory.send_command_publish(packet.src_nid, page, addr);
  }
}

/**
 * When packet error has happen, retry it.
 * @param packet A packet not used.
 */
void VMemory::PacketPublish::on_packet_error(PacketError::Type code) {
  auto it_page = vmemory.pages.find(addr);

  if (it_page == vmemory.pages.end()) {
    /// @todo publish freeing page
    assert(false);
    return;
  }

  Page& page = it_page->second;
  page.publish_history.erase(dst_nid);
  if (page.learner_nids.find(dst_nid) != page.learner_nids.end()) {
    vmemory.send_command_publish(dst_nid, page, addr);
  }
}

VMemory::PacketWrite::PacketWrite(VMemory& vmemory_, const NodeID& dst_nid_,
                                  vaddr_t addr_, uint64_t write_id_) :
    vmemory(vmemory_),
    dst_nid(dst_nid_),
    addr(addr_),
    write_id(write_id_) {
}

const PacketController::Define& VMemory::PacketWrite::get_define() {
  static const PacketController::Define DEFINE = {
    "write",
    0,
    0,
    Module::MEMORY
  };

  return DEFINE;
}

/**
 * When packet error has happen, retry it.
 * @param packet A packet not used.
 */
void VMemory::PacketWrite::on_error(const Packet& packet) {
  on_packet_error(PacketError::CALL_BY_ERROR);
}

/**
 * After receive reply packet, re-send write command if needed (write_id has changed).
 * @param packet A packet not used.
 */
void VMemory::PacketWrite::on_reply(const Packet& packet) {
  auto it_page = vmemory.pages.find(addr);

  if (it_page != vmemory.pages.end()) {
    Page& page = it_page->second;
    page.write_history.erase(packet.src_nid);
    if (write_id != page.write_id &&
        page.type & VMemoryPageType::LEADER) {
      vmemory.send_command_write(packet.src_nid, page, addr);
    }
  }
}

/**
 * When packet error has happen, retry it.
 * @param packet A packet not used.
 */
void VMemory::PacketWrite::on_packet_error(PacketError::Type code) {
  auto it_page = vmemory.pages.find(addr);

  if (it_page != vmemory.pages.end()) {
    Page& page = it_page->second;
    page.write_history.erase(dst_nid);
    if (page.type & VMemoryPageType::LEADER) {
      vmemory.send_command_write(dst_nid, page, addr);
    }
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
           pages.find(new_addr) != pages.end()) {
      new_addr = get_upper_addr(type | (~AddressRegion::MASK & rnd()));
    }
    pages.insert(std::make_pair(new_addr, Page(VMemoryPageType::LEADER, true,
                                               my_nid, std::set<NodeID>())));
    return new_addr;
  }

  if (accessor.alloc_info) {
    if (accessor.alloc_info->is_finish) {
      vaddr_t new_addr = accessor.alloc_info->addr;
      accessor.alloc_info.reset();
      return new_addr;

    } else {
      throw InterruptMemoryRequire(VADDR_NULL);
    }

  } else {
    accessor.alloc_info.reset(new AllocInfo());

    accessor.alloc_info->addr = get_upper_addr(type | (~AddressRegion::MASK & rnd()));
    while ((type == AddressRegion::META && accessor.alloc_info->addr <= 0xFF) ||
           pages.find(accessor.alloc_info->addr) != pages.end()) {
      accessor.alloc_info->addr = get_upper_addr(type | (~AddressRegion::MASK & rnd()));
    }
    accessor.alloc_info->type = type;
    accessor.alloc_info->is_cancel = false;
    accessor.alloc_info->is_finish = false;
    send_command_alloc(accessor.alloc_info);

    throw InterruptMemoryRequire(VADDR_NULL);
  }
}

/**
 * Check address ,if is it in acceptor range.
 * @param addr A target address.
 * @return True if the address is in acceptor range.
 */
bool VMemory::check_acceptor_range(vaddr_t addr) {
  NodeID hash = get_hash_id(addr);
  if (range_min_nid == NodeID::NONE) {
    return true;
  }

  for (int i = 0; i < 4; i++) {
    if (hash.is_between(range_min_nid, range_max_nid)) {
      return true;
    }
    hash = hash + NodeID::QUARTER;
  }
  return false;
}

/**
 * Check address, if is it in root acceptor range.
 * @param addr A target address.
 * @return True if the address is in root acceptor range.
 */
bool VMemory::check_root_acceptor(vaddr_t addr) {
  NodeID hash = get_hash_id(addr);
  if (range_min_nid == NodeID::NONE) {
    return true;
  }

  if (hash.is_between(range_min_nid, range_max_nid)) {
    return true;

  } else {
    return false;
  }
}

/**
 * Calculate node-id that is hash of process-id and address.
 * @param addr A address.
 * @return A node-id that is supporting address.
 */
NodeID VMemory::get_hash_id(vaddr_t addr) {
  std::string key = my_pid + Convert::vaddr2str(addr);
  return NodeID::from_str(Util::calc_md5(key));
}

/**
 * Calculate most near acceptor node-id for address.
 * @param addr A target address.
 * @return A node-id that is most near acceptor node-id from this node-id
 */
NodeID VMemory::get_near_acceptor(vaddr_t addr) {
  NodeID acceptor_nid = get_hash_id(addr);
  NodeID near_nid = acceptor_nid;
  NodeID min_distance = my_nid.distance_from(near_nid);

  for (int i = 0; i < 3; i++) {
    acceptor_nid = acceptor_nid + NodeID::QUARTER;
    NodeID d = my_nid.distance_from(acceptor_nid);
    if (min_distance < d) {
      min_distance = d;
      near_nid = acceptor_nid;
    }
  }

  return near_nid;
}

/**
 * After support node-id range has changed, check all page addresses and
 * delegate page if a page is out of support node-id range.
 */
void VMemory::rebalance() {
  for (auto& page_it : pages) {
    vaddr_t addr = page_it.first;
    Page& page = page_it.second;

    if (page.type & VMemoryPageType::ACCEPTOR &&
        !check_acceptor_range(addr)) {
      send_command_delegate(addr, page.value.get(), page.size, page.leader_nid,
                            page.acceptor_nids, page.learner_nids);
    }
  }
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

  } else if (packet.command == "balance") {
    recv_command_balance(packet);

  } else if (packet.command == "candidacy") {
    recv_command_candidacy(packet);

  } else if (packet.command == "claim_back") {
    recv_command_claim_back(packet);

  } else if (packet.command == "delegate") {
    recv_command_delegate(packet);

  } else if (packet.command == "free") {
    recv_command_free(packet);

  } else if (packet.command == "free_acceptor") {
    recv_command_free_acceptor(packet);

  } else if (packet.command == "publish") {
    recv_command_publish(packet);

  } else if (packet.command == "require") {
    recv_command_require(packet);

  } else if (packet.command == "routing") {
    recv_command_routing(packet);

  } else if (packet.command == "write") {
    recv_command_write(packet);

  } else if (packet.command == "write_require") {
    recv_command_write_require(packet);

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
 * When receive balance command, run rebalance.
 * Send require if page is need and has not exist
 * Send delegate if page has exist and that address has not acceptor range.
 * @param packet A packet containing addr, acceptor_nids.
 */
void VMemory::recv_command_balance(const Packet& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  std::set<NodeID> acceptor_nids = NodeID::from_json_array(packet.content.at("acceptor_nids"));

  auto it_page = pages.find(addr);
  if (it_page == pages.end()) {
    if (check_acceptor_range(addr)) {
      send_command_require(addr, VMemoryReadMode::ONCE, true);
    }

  } else {
    Page& page = it_page->second;
    if (!check_acceptor_range(addr) &&
        page.type & VMemoryPageType::ACCEPTOR) {
      send_command_delegate(addr, page.value.get(), page.size, page.leader_nid,
                            page.acceptor_nids, page.learner_nids);
    }
  }
}

/**
 * When receive candidacy command, if another node havend right of leader, send reply.
 * But another node having right of leader, send error.
 * This command can receive only root acceptor.
 * @param packet Command packet containing addr.
 */
void VMemory::recv_command_candidacy(const Packet& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  assert(addr == get_upper_addr(addr));

  if (!check_root_acceptor(addr)) {
    packet_controller.send_error(packet, picojson::object());
    return;
  }

  auto it_page = pages.find(addr);
  if (it_page == pages.end()) {
    packet_controller.send_error(packet, picojson::object());
    /// @todo get data for address from another acceptor.
    assert(false);
    return;
  }

  Page& page = it_page->second;
  /// Maybe changing acceptor status.
  if (~page.type & VMemoryPageType::ACCEPTOR) {
    packet_controller.send_error(packet, picojson::object());
    return;
  }

  if (page.leader_nid == packet.src_nid) {
    // The leader of the page is the same to candidacy node yet.
    packet_controller.send_reply(packet, picojson::object());

  } else if (page.leader_nid == NodeID::NONE ||
      (page.type & VMemoryPageType::LEADER && page.master_count == 0)) {
    // The leader is root acceptor and page's reference count is 0.
    assert(page.flg_update == true);
    packet_controller.send_reply(packet, picojson::object());

    page.type &= ~VMemoryPageType::LEADER;
    page.leader_nid = packet.src_nid;
    if (packet.src_nid != my_nid) {
      page.learner_nids.insert(packet.src_nid);
    }
    send_command_publish(NodeID::NONE, page, addr);

  } else {
    // The leader is nether candidacy node or root acceptor.
    if (page.leader_nid != my_nid) {
      send_command_claim_back(page.leader_nid, addr);
    }
    packet_controller.send_error(packet, picojson::object());
  }
}

/**
 * When receive claim_back command, send reply if my node is leader and count is 0.
 * Send error if page's master_count is not 0.
 * @param packet Command packet contaning addr.
 */
void VMemory::recv_command_claim_back(const Packet& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  assert(addr == get_upper_addr(addr));

  auto it_page = pages.find(addr);
  if (it_page == pages.end()) {
    packet_controller.send_reply(packet, picojson::object());
    return;
  }

  Page& page = it_page->second;
  if (~page.type & VMemoryPageType::LEADER) {
    packet_controller.send_reply(packet, picojson::object());
    return;
  }

  if (page.master_count == 0) {
    page.type &= ~VMemoryPageType::LEADER;
    packet_controller.send_reply(packet, picojson::object());
    return;
  }

  packet_controller.send_error(packet, picojson::object());
}

/**
 * When receive delegate command, Set acceptor flag to a target page.
 * After receive it, send reply command and/or balance command if needed.
 * @param packet Command packet containing a set of page informations.
 */
void VMemory::recv_command_delegate(const Packet& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  const std::string& value = Convert::json2bin(packet.content.at("value"));
  NodeID leader_nid = NodeID::from_json(packet.content.at("leader_nid"));
  std::set<NodeID> acceptor_nids = NodeID::from_json_array(packet.content.at("acceptor_nids"));
  std::set<NodeID> learner_nids  = NodeID::from_json_array(packet.content.at("learner_nids"));

  assert(check_acceptor_range(addr));
  assert(acceptor_nids.size() == 0 ||
         acceptor_nids.find(packet.src_nid) != acceptor_nids.end());
  acceptor_nids.erase(packet.src_nid);
  assert(acceptor_nids.size() <= 3);

  if (pages.find(addr) == pages.end()) {
    pages.insert(std::make_pair(addr,
                                Page(VMemoryPageType::ACCEPTOR, true, value,
                                     leader_nid, learner_nids)));
    Page& page = pages.at(addr);
    page.acceptor_nids = acceptor_nids;

  } else {
    Page& page = pages.at(addr);
    page.type |= VMemoryPageType::ACCEPTOR;
    if (page.size != value.size()) {
      page.value.reset(new uint8_t[value.size()]);
      page.size = value.size();
    }
    memcpy(page.value.get(), value.data(), value.size());
    page.leader_nid = leader_nid;
    page.acceptor_nids = acceptor_nids;
    for (auto& learner_nid : learner_nids) {
      if (learner_nid != my_nid) {
        page.learner_nids.insert(learner_nid);
      }
    }
  }

  // If leader page is not fixed and this node is root acceptor, set this node-id for leader.
  Page& page = pages.at(addr);
  if (page.leader_nid == NodeID::NONE &&
      check_root_acceptor(addr)) {
    page.type |= VMemoryPageType::LEADER;
    page.leader_nid = my_nid;
  }

  if (packet.src_nid != NodeID::SERVER) {
    packet_controller.send_reply(packet, picojson::object());
  }

  if (range_min_nid != NodeID::NONE) {
    acceptor_nids.insert(my_nid);
    send_command_balance(addr, acceptor_nids);
  }

  delegate.vmemory_recv_update(*this, addr);
}

/**
 * When receive free command, remove page and send free_acceptor command to each acceptors.
 * @param packet Command packet containing taret address.
 */
void VMemory::recv_command_free(const Packet& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  assert(addr == get_upper_addr(addr));

  if (!check_acceptor_range(addr)) {
    send_command_free(addr);
  }

  auto it_page = pages.find(addr);
  if (it_page == pages.end()) {
    NodeID acceptor_nid = get_near_acceptor(addr) + NodeID::QUARTER;
    std::set<NodeID> acceptor_nids;
    for (int i = 0; i < 3; i++) {
      acceptor_nids.insert(acceptor_nid);
      acceptor_nid = acceptor_nid + NodeID::QUARTER;
    }
    send_command_free_acceptor(addr, acceptor_nids);

  } else {
    Page& page = it_page->second;
    if (~page.type & VMemoryPageType::ACCEPTOR) {
      NodeID acceptor_nid = get_near_acceptor(addr);
      std::set<NodeID> acceptor_nids;
      for (int i = 0; i < 4; i++) {
        acceptor_nids.insert(acceptor_nid);
        acceptor_nid = acceptor_nid + NodeID::QUARTER;
      }
      send_command_free_acceptor(addr, acceptor_nids);

    } else {
      assert(~page.type & VMemoryPageType::PROGRAM);
      std::set<NodeID> acceptor_nids = page.acceptor_nids;
      NodeID acceptor_nid = get_near_acceptor(addr);
      for (int i = 0; i < 4; i++) {
        acceptor_nids.insert(acceptor_nid);
        acceptor_nid = acceptor_nid + NodeID::QUARTER;
      }
      send_command_free_acceptor(addr, acceptor_nids);
      pages.erase(it_page);
    }
  }
}

/**
 * When receive free_acceptor command, remove page and re-send free_acceptor command each acceptors.
 * @param packet Command packet containing target address, acceptors to check, target acceptor node-id.
 */
void VMemory::recv_command_free_acceptor(const Packet& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  std::set<NodeID> acceptor_nids = NodeID::from_json_array(packet.content.at("acceptor_nids"));
  NodeID target_nid = NodeID::from_json(packet.content.at("target_nid"));

  auto it_page = pages.find(addr);
  if (it_page == pages.end()) {
    acceptor_nids.erase(target_nid);
    send_command_free_acceptor(addr, acceptor_nids);

  } else {
    Page& page = it_page->second;
    for (auto& acceptor_nid : page.acceptor_nids) {
      acceptor_nids.insert(acceptor_nid);
    }
    acceptor_nids.erase(target_nid);
    send_command_free_acceptor(addr, acceptor_nids);
    page.value.reset();
    page.size = 0;
    send_command_publish(NodeID::NONE, page, addr);
    pages.erase(addr);
  }
}

/**
 * When receive require command, broad cast or relay to another node if value is not exist in this node.
 * Reply copy command if value is stored in this node.
 * @param packet Command packet containing target address and node-id that node required a value.
 */
void VMemory::recv_command_require(const Packet& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  VMemoryReadMode::Type mode = Convert::json2int<VMemoryReadMode::Type>(packet.content.at("mode"));

  assert(addr == get_upper_addr(addr));

  if (packet.src_nid == my_nid) {
    return;
  }

  if (!check_acceptor_range(addr)) {
    return;
  }

  auto it_page = pages.find(addr);
  if (it_page == pages.end()) {
    if (check_acceptor_range(addr)) {
      send_command_require(addr, VMemoryReadMode::ONCE, true);
    }
    return;
  }

  Page& page = it_page->second;
  switch (mode) {
    case VMemoryReadMode::STOP: {
      page.learner_nids.erase(packet.src_nid);
    } break;

    case VMemoryReadMode::ONCE: {
      send_command_publish(packet.src_nid, page, addr);
    } break;

    case VMemoryReadMode::CONTINUE: {
      send_command_publish(packet.src_nid, page, addr);
      if (packet.src_nid != my_nid) {
        page.learner_nids.insert(packet.src_nid);
      }
    } break;

    default: {
      assert(false);
    }
  }
}

/**
 * When receive publish command, update local value (if needed) and send reply.
 * @param pacekt A packet containing addr, value, and leader_nid.
 */
void VMemory::recv_command_publish(const Packet& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  const std::string& value = Convert::json2bin(packet.content.at("value"));
  NodeID leader_nid = NodeID::from_json(packet.content.at("leader_nid"));

  if (get_upper_addr(addr) != addr) {
    /// @todo error
    assert(false);
  }

  auto it_page = pages.find(addr);
  if (it_page == pages.end()) {
    if (value.size() == 0) return;

    auto it_ri = requiring.find(addr);
    if (it_ri != requiring.end()) {
      pages.insert(std::make_pair
                   (addr, Page(is_program(addr) ? VMemoryPageType::PROGRAM : VMemoryPageType::NONE,
                               true, value, leader_nid, std::set<NodeID>())));
      requiring.erase(it_ri);
      packet_controller.send_reply(packet, picojson::object());

      if (check_acceptor_range(addr)) {
        Page& page = pages.at(addr);
        page.type |= VMemoryPageType::ACCEPTOR;
        if (range_min_nid != NodeID::NONE) {
          std::set<NodeID> acceptor_nids;
          acceptor_nids.insert(my_nid);
          send_command_balance(addr, acceptor_nids);
        }
      }

    } else {
      packet_controller.send_error(packet, picojson::object());
    }

  } else {
    Page& page = it_page->second;

    if (page.type & VMemoryPageType::LEADER) {
      packet_controller.send_reply(packet, picojson::object());
      delegate.vmemory_recv_update(*this, addr);
      return;

    } else if (page.type & VMemoryPageType::ACCEPTOR &&
               requiring.find(addr) == requiring.end()) {
      packet_controller.send_error(packet, picojson::object());
      delegate.vmemory_recv_update(*this, addr);
      return;

    } else if (~page.type & VMemoryPageType::ACCEPTOR &&
               page.referral_count >= MEMORY_REFERRAL_LIMIT &&
               requiring.find(addr) == requiring.end()) {
      packet_controller.send_error(packet, picojson::object());
      pages.erase(addr);

    } else if (value.size() != 0) {
      if (page.size != value.size()) {
        page.size = value.size();
        page.value.reset(new uint8_t[page.size]);
      }
      std::memcpy(page.value.get(), value.data(), page.size);
      page.flg_update = true;
      page.referral_count++;
      packet_controller.send_reply(packet, picojson::object());

    } else {
      // free
      assert(~page.type & VMemoryPageType::ACCEPTOR);
      pages.erase(addr);
      packet_controller.send_error(packet, picojson::object());
    }

    auto it_ri = requiring.find(addr);
    if (it_ri != requiring.end()) {
      requiring.erase(it_ri);
    }
  }

  delegate.vmemory_recv_update(*this, addr);
}

/**
 * When receive routing command (meaning acceptor range had change),
 * save range node-id and execute rebalance algorithm.
 * @param packet Command packet containing a range of supporting node-id.
 */
void VMemory::recv_command_routing(const Packet& packet) {
  range_min_nid = NodeID::from_json(packet.content.at("range_min_nid"));
  range_max_nid = NodeID::from_json(packet.content.at("range_max_nid"));

  rebalance();
}

/**
 * When receive write command, update local value (if needed) and send publish command, and reply.
 * @param pacekt A packet containing addr, value.
 */
void VMemory::recv_command_write(const Packet& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  const std::string& value = Convert::json2bin(packet.content.at("value"));

  auto it_page = pages.find(get_upper_addr(addr));
  if (it_page == pages.end()) {
    if (check_acceptor_range(addr)) {
      send_command_require(addr, VMemoryReadMode::ONCE, true);
    }
    packet_controller.send_error(packet, picojson::object());
    return;
  }

  Page& page = it_page->second;
  if (~page.type & VMemoryPageType::ACCEPTOR) {
    packet_controller.send_error(packet, picojson::object());
    return;
  }

  if (packet.src_nid != page.leader_nid) {
    packet_controller.send_error(packet, picojson::object());
    return;
  }

  if (~page.type & VMemoryPageType::LEADER) {
    if (page.size != value.size()) {
      page.value.reset(new uint8_t[value.size()]);
      page.size = value.size();
    }
    std::memcpy(page.value.get(), value.data(), value.size());
  }
  send_command_publish(NodeID::NONE, page, addr);
  packet_controller.send_reply(packet, picojson::object());
}

/**
 * When receive write_require command, updte local value and send write command.
 * @param packet A packet containing address and value.
 */
void VMemory::recv_command_write_require(const Packet& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  const std::string& value = Convert::json2bin(packet.content.at("value"));

  auto it_page = pages.find(get_upper_addr(addr));
  if (it_page == pages.end()) {
    /// @todo error
    assert(false);
  }

  Page& page = it_page->second;
  if (~page.type & VMemoryPageType::LEADER) {
    /// @todo error
    assert(false);
  }

  if (page.size < get_lower_addr(addr) + value.size()) {
    /// @todo error
    assert(false);
  }

  std::memcpy(page.value.get() + get_lower_addr(addr), value.data(), value.size());
  send_command_write(NodeID::NONE, page, get_upper_addr(addr));
}

/**
 * Send alloc command with target address and my node-id.
 * @param alloc_info A alloc-information to alloc.
 */
void VMemory::send_command_alloc(std::shared_ptr<AllocInfo> alloc_info) {
  picojson::object param;
  param.insert(std::make_pair("addr", Convert::vaddr2json(alloc_info->addr)));
  param.insert(std::make_pair("nid", my_nid.to_json()));

  alloc_info->acceptor_nid.clear();
  NodeID acceptor_nid = get_hash_id(alloc_info->addr);
  for (int i = 0; i < 4; i ++) {
    packet_controller.send(std::unique_ptr<PacketController::Behavior>
                           (new PacketAlloc(*this, alloc_info)), my_pid, acceptor_nid, param);
    acceptor_nid = acceptor_nid + NodeID::QUARTER;
  }
}

/**
 * Send alloc_cancel command to cancel allocation process.
 * @param alloc_info A alloc-information to used to alloc.
 */
void VMemory::send_command_alloc_cancel(std::shared_ptr<AllocInfo> alloc_info) {
  picojson::object param;
  param.insert(std::make_pair("addr", Convert::vaddr2json(alloc_info->addr)));
  param.insert(std::make_pair("nid", my_nid.to_json()));

  for (NodeID& acceptor_nid : alloc_info->acceptor_nid) {
    packet_controller.send("alloc_cancel", Module::MEMORY, true,
                           my_pid, acceptor_nid, param);
  }
}

/**
 * Send balance command with acceptor node-id that this node recognized.
 * @param addr A target address.
 * @param acceptor_nids A set of acceptor node-id that this node recognized.
 */
void VMemory::send_command_balance(vaddr_t addr, const std::set<NodeID>& acceptor_nids) {
  picojson::object param;
  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  param.insert(std::make_pair("acceptor_nids", NodeID::to_json_array(acceptor_nids)));

  NodeID hash = get_hash_id(addr);
  for (auto& nid : acceptor_nids) {
    if (nid != my_nid) {
      packet_controller.send("balance", Module::MEMORY, true,
                             my_pid, nid, param);
    }
  }
  for (int i = 0; i < 4; i++) {
    if (!hash.is_between(range_min_nid, range_max_nid)) {
      packet_controller.send("balance", Module::MEMORY, false,
                             my_pid, hash, param);
    }
    hash = hash + NodeID::QUARTER;
  }
}

/**
 * Send candidacy command to root acceptor node.
 * @param addr Target address for candidacy.
 * @param page Target page.
 */
void VMemory::send_command_candidacy(vaddr_t addr, Page& page) {
  assert(addr == get_upper_addr(addr));
  assert(~page.type & VMemoryPageType::LEADER);

  picojson::object param;
  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));

  std::unique_ptr<PacketController::Behavior> behavior(new PacketCandidacy(*this, addr));
  packet_controller.send(std::move(behavior),
                         my_pid, get_hash_id(addr), param);
}

/**
 * Send claim_back command to leader node.
 * @param leader_nid Node-id of leader.
 * @param addr Target address for claim back.
 */
void VMemory::send_command_claim_back(const NodeID& leader_nid, vaddr_t addr) {
  assert(addr == get_upper_addr(addr));
  assert(pages.at(addr).leader_nid == leader_nid);
  assert(pages.at(addr).type & VMemoryPageType::ACCEPTOR);

  picojson::object param;
  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));

  std::unique_ptr<PacketController::Behavior> behavior(new PacketClaimBack(*this, addr));
  packet_controller.send(std::move(behavior),
                         my_pid, leader_nid, param);
}

/**
 * Send delegate command with a set of page information.
 * Destination node-id of this packet is a most close node-id from ideal acceptor node-id.
 * @param addr A target address.
 * @param value Array of page data.
 * @param size A data size of page.
 * @param leader_nid The leader node-id of page.
 * @param acceptor_nids A set of acceptor node-id that this node recognized.
 * @param learner_nids A set of learner node-id.
 */
void VMemory::send_command_delegate(vaddr_t addr,
                                    const uint8_t* value, uint64_t size,
                                    const NodeID& leader_nid,
                                    const std::set<NodeID>& acceptor_nids,
                                    const std::set<NodeID>& learner_nids) {
  picojson::object param;
  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  param.insert(std::make_pair("value", Convert::bin2json(value, size)));
  param.insert(std::make_pair("leader_nid", leader_nid.to_json()));
  param.insert(std::make_pair("acceptor_nids", NodeID::to_json_array(acceptor_nids)));
  param.insert(std::make_pair("learner_nids", NodeID::to_json_array(learner_nids)));

  std::unique_ptr<PacketController::Behavior> behavior(new PacketDelegate(*this));
  packet_controller.send(std::move(behavior),
                         my_pid, get_near_acceptor(addr), param);
}

/**
 * Send free command.
 * @param addr Target address to free.
 */
void VMemory::send_command_free(vaddr_t addr) {
  picojson::object param;
  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));

  NodeID acceptor_nid = get_hash_id(addr);
  for (int i = 0; i < 4; i++) {
    packet_controller.send("free", Module::MEMORY, false,
                           my_pid, acceptor_nid, param);
    acceptor_nid = acceptor_nid + NodeID::QUARTER;
  }
}

/**
 * Send free_acceptor command.
 * @param addr Target address to free.
 * @param acceptor_nids
 */
void VMemory::send_command_free_acceptor(vaddr_t addr, const std::set<NodeID>& acceptor_nids) {
  picojson::object param;
  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  param.insert(std::make_pair("acceptor_nids", NodeID::to_json_array(acceptor_nids)));

  for (auto& target_nid : acceptor_nids) {
    param["target_nid"] = target_nid.to_json();
    packet_controller.send("free_acceptor", Module::MEMORY, false,
                           my_pid, target_nid, param);
  }
}

/**
 * Send publish command, to tell value from acceptor to learner nodes.
 * If dst_nid is NONE, send it to all of page's learner_nids nodes.
 * @param dst_nid Destination node-id or NONE to send to all of page's learner nodes..
 * @param page The target page to publish.
 * @param addr The address of the page.
 */
void VMemory::send_command_publish(const NodeID& dst_nid, Page& page, vaddr_t addr) {
  assert(page.type & VMemoryPageType::ACCEPTOR);
  assert(dst_nid != my_nid || page.type & VMemoryPageType::LEADER);
  assert(get_upper_addr(addr) == addr);

  if (dst_nid == NodeID::NONE) {
    page.write_id = rnd();
    for (const auto& learner_nid : page.learner_nids) {
      send_command_publish(learner_nid, page, addr);
    }
    return;
  }

  auto history = page.publish_history.find(dst_nid);

  if (history == page.publish_history.end()) {
    picojson::object param;
    param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
    param.insert(std::make_pair("value", Convert::bin2json(page.value.get(), page.size)));
    param.insert(std::make_pair("leader_nid", page.leader_nid.to_json()));

    std::unique_ptr<PacketController::Behavior> behavior(
        new PacketPublish(*this, dst_nid, addr, page.write_id));
    packet_controller.send(std::move(behavior), my_pid, dst_nid, param);

    page.publish_history.insert(dst_nid);
  }
}

/**
 * Send require command for requireing value in target address.
 * @param dst_nid Destination node-id.
 * @param addr Target address to get value.
 */
void VMemory::send_command_require(vaddr_t addr, VMemoryReadMode::Type mode, bool to_all) {
  assert(get_upper_addr(addr) == addr);

  if (requiring.find(addr) != requiring.end()) {
    return;
  }

  requiring.insert(addr);
  picojson::object param;

  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  param.insert(std::make_pair("mode", Convert::int2json(mode)));

  if (to_all) {
    NodeID acceptor_nid = get_hash_id(addr);
    for (int i = 0; i < 4; i++) {
      packet_controller.send("require", Module::MEMORY, false,
                             my_pid, acceptor_nid, param);
      acceptor_nid = acceptor_nid + NodeID::QUARTER;
    }
  } else {
    packet_controller.send("require", Module::MEMORY, false,
                           my_pid, get_near_acceptor(addr), param);
  }
}

/**
 * Send require_routing command to NETWORK module on this node.
 */
void VMemory::send_command_require_routing() {
  packet_controller.send("require_routing", Module::NETWORK, true,
                         my_pid, NodeID::THIS, picojson::object());
}

/**
 * Send write command to tell value from leader node to acceptor node.
 * If it set NONE to dst_nid, tell to all of acceptor node for the page.
 * @param dst_nid Destination nid or NONE.
 * @param page The target page to write.
 * @param addr The target address of the page.
 */
void VMemory::send_command_write(const NodeID& dst_nid, Page& page, vaddr_t addr) {
  assert(addr == get_upper_addr(addr));
  assert(page.type & VMemoryPageType::LEADER);
  assert(page.flg_update == true);

  if (is_loading) {
    return;

  } else if (dst_nid == NodeID::NONE) {
    page.write_id = rnd();
    NodeID acceptor_nid = get_hash_id(get_upper_addr(addr));
    for (int i = 0; i < 4; i++) {
      send_command_write(acceptor_nid, page, addr);
      acceptor_nid = acceptor_nid + NodeID::QUARTER;
    }
    return;
  }

  if (page.write_history.find(dst_nid) == page.write_history.end()) {
    picojson::object param;
    param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
    param.insert(std::make_pair("value", Convert::bin2json(page.value.get(), page.size)));

    std::unique_ptr<PacketController::Behavior> behavior(
        new PacketWrite(*this, dst_nid, addr, page.write_id));
    packet_controller.send(std::move(behavior), my_pid, dst_nid, param);
    page.write_history.insert(dst_nid);
  }
}

/**
 * Send write_require command to tell value from a node without leader to the leader node.
 * @param page The target page to write.
 * @param addr The address to write, it don't have to be the head address of page.
 * @param data Raw data to write.
 * @param size Size of data.
 */
void VMemory::send_command_write_require(Page& page, vaddr_t addr,
                                         const uint8_t* data, uint64_t size) {
  assert(~page.type & VMemoryPageType::LEADER);
  page.flg_update = false;

  picojson::object param;
  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  param.insert(std::make_pair("value", Convert::bin2json(data, size)));

  packet_controller.send("write_require", Module::MEMORY, true,
                         my_pid, page.leader_nid, param);
}
}  // namespace processwarp
