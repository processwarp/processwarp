
#include <cassert>
#include <deque>
#include <set>
#include <string>

#include "convert.hpp"
#include "error.hpp"
#include "finally.hpp"
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

// Constructor with node-id.
VMemory::VMemory(VMemoryDelegate& delegate_, const nid_t& nid_) :
    my_nid(nid_),
    rnd(std::random_device()()),
    delegate(delegate_) {
}

/**
 * When reveive command from another module or node, pass it to capable method by command string.
 * @param packet Command packet.
 */
void VMemory::recv_command(const CommandPacket& packet) {
  if (packet.src_nid == my_nid) return;
  const std::string& command = packet.content.at("command").get<std::string>();

  if (command == "copy") {
    recv_command_copy(packet);

  } else if (command == "copy_reply") {
    recv_command_copy_reply(packet);

  } else if (command == "require") {
    recv_command_require(packet);

  } else if (command == "update") {
    recv_command_update(packet);

  } else if (command == "reserve") {
    recv_command_reserve(packet);

  } else if (command == "free") {
    recv_command_free(packet);

    /*
      } else if (command == "release") {
    */
  } else if (command == "stand") {
    recv_command_stand(packet);

  } else if (command == "give") {
    recv_command_give(packet);

  } else if (command == "unwant") {
    recv_command_unwant(packet);

  } else {
    /// @todo error
    assert(false);
  }
}

/**
 * When receive copy command, check and copy value on target address.
 * At last, pass update event to VM throught a delegate.
 * @param packet Command packet containing target address and value.
 */
void VMemory::recv_command_copy(const CommandPacket& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  const std::string& value = Convert::json2bin(packet.content.at("value"));
  uint64_t key = Convert::json2int<uint64_t>(packet.content.at("key"));

  if (get_upper_addr(addr) != addr) {
    /// @todo error
    assert(false);
  }

  auto it_space = spaces.find(packet.pid);
  if (it_space == spaces.end()) {
    send_command_unwant(packet.src_nid, packet.pid, addr);
    return;
  }

  Space& space = *it_space->second;
  auto it_page = space.pages.find(addr);
  if (it_page == space.pages.end()) {
    if (value.size() == 0) return;

    auto it_ri = space.requiring.find(addr);
    if (it_ri != space.requiring.end()) {
      std::set<nid_t> hint;
      hint.insert(packet.src_nid);
      space.pages.insert(std::make_pair
                         (addr, Page(is_program(addr) ? PT_PROGRAM : PT_COPY,
                                     true, value, hint)));
      space.requiring.erase(it_ri);
      send_command_copy_reply(packet.src_nid, space, addr, key);

    } else {
      send_command_unwant(packet.src_nid, packet.pid, addr);
    }

  } else {
    Page& page = it_page->second;
    assert(page.hint.size() == 1);
    assert(*page.hint.begin() == packet.src_nid);

    if (page.type != PT_COPY) {
      return;

    } else if (page.referral_count >= MEMORY_REFERRAL_LIMIT &&
               space.requiring.find(addr) == space.requiring.end()) {
      send_command_unwant(packet.src_nid, packet.pid, addr);
      space.pages.erase(addr);

    } else if (value.size() != 0) {
      if (page.size != value.size()) {
        page.size = value.size();
        page.value.reset(new uint8_t[page.size]);
      }
      std::memcpy(page.value.get(), value.data(), page.size);
      page.flg_update = true;
      page.referral_count++;
      send_command_copy_reply(packet.src_nid, space, addr, key);

    } else {
      space.pages.erase(addr);
    }

    auto it_ri = space.requiring.find(addr);
    if (it_ri != space.requiring.end()) {
      space.requiring.erase(it_ri);
    }
  }

  delegate.vmemory_recv_update(*this, addr);
}

/**
 * When receive copy reply command, check history and send new packet if a page was updated.
 * @param packet Packet command containing target address and key code that was send by a copy command.
 */
void VMemory::recv_command_copy_reply(const CommandPacket& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  uint64_t key = Convert::json2int<uint64_t>(packet.content.at("key"));
  assert(addr == get_upper_addr(addr));

  auto it_space = spaces.find(packet.pid);
  if (it_space == spaces.end()) return;

  Space& space = *it_space->second;
  auto it_page = space.pages.find(addr);
  if (it_page == space.pages.end()) return;

  Page& page = it_page->second;
  auto it_history = page.send_copy_history.find(packet.src_nid);
  if (it_history == page.send_copy_history.end()) return;

  if (it_history->second.key == key) {
    page.send_copy_history.erase(it_history);

  } else {
    page.send_copy_history.erase(it_history);
    send_command_copy(packet.src_nid, space, page, addr);
  }
}

/**
 * When receive free command, update page to 0-size if this node is master of target address,
 * or delegate command to master node if this node isn't master of target address.
 * @param packet Command packet containing target address.
 */
void VMemory::recv_command_free(const CommandPacket& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  assert(addr == get_upper_addr(addr));

  auto it_space = spaces.find(packet.pid);
  if (it_space == spaces.end()) {
    /// @todo I'm not in this space.
    assert(false);
  }

  Space& space = *it_space->second;
  auto it_page = space.pages.find(addr);
  if (it_page == space.pages.end()) {
    /// @todo Relay bload cast when packet was not bload cast.
  }

  Page& page = it_page->second;
  switch (page.type) {
    case PT_MASTER: {
      if (page.master_count != 0) {
        /// @todo error
        assert(false);
      }
      page.size = 0;
      page.value.reset();
      for (auto& dst_nid : page.hint) {
        send_command_copy(dst_nid, space, page, addr);
      }
      space.release_addr(addr);
      space.pages.erase(addr);
    } break;

    case PT_COPY: {
      assert(page.hint.size() == 1);
      send_command_free(*page.hint.begin(), space, addr);
    } break;

    default: {
      /// @todo error
      assert(false);
    } break;
  }
}

/**
 * When receive give command to pass master flag, change flag and save value if target node is this node.
 * Only update hint if target node isn't this node.
 * @param packet Command packet containing target address, value, destination node-id, and hint node-id.
 */
void VMemory::recv_command_give(const CommandPacket& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  const std::string& value = Convert::json2bin(packet.content.at("value"));
  const nid_t& dst_nid = Convert::json2nid(packet.content.at("dst_nid"));
  picojson::array js_hint = packet.content.at("hint_nid").get<picojson::array>();

  assert(addr == get_upper_addr(addr));

  auto it_space = spaces.find(packet.pid);
  if (it_space == spaces.end()) {
    if (dst_nid == my_nid) {
      /// @todo Give master to this node but this node is't binded selected name space.
      assert(false);

    } else {
      send_command_unwant(dst_nid, packet.pid, addr);
      /// @todo send_unwant and relay packet to dst.
      assert(false);
      return;
    }
  }

  Space& space = *it_space->second;
  auto it_page = space.pages.find(addr);
  if (dst_nid == my_nid) {
    std::set<nid_t> hint;
    for (auto& js_h : js_hint) {
      const nid_t& hint_node = Convert::json2nid(js_h);
      if (hint_node != my_nid) {
        hint.insert(hint_node);
      }
    }
    if (packet.src_nid != SpecialNID::SERVER) {
      hint.insert(packet.src_nid);
    }

    if (it_page == space.pages.end()) {
      space.pages.insert(std::make_pair(addr, Page(PT_MASTER, true, value, hint)));

    } else {
      Page& page = it_page->second;
      assert(page.type == PT_COPY || page.type == PT_PROGRAM);
      // Skip if page type is program and I have it yet.
      if (page.type == PT_PROGRAM) return;

      page.type = PT_MASTER;
      page.flg_update = true;
      if (page.size != value.size()) {
        page.size = value.size();
        page.value.reset(new uint8_t[page.size]);
      }
      std::memcpy(page.value.get(), value.data(), page.size);
      page.hint = hint;
      page.referral_count = 0;
    }

    auto it_ri = space.requiring.find(addr);
    if (it_ri != space.requiring.end()) {
      space.requiring.erase(it_ri);
    }

    delegate.vmemory_recv_update(*this, addr);

  } else {
    if (it_page == space.pages.end()) {
      send_command_unwant(dst_nid, packet.pid, addr);

    } else {
      Page& page = it_page->second;
      assert(page.type == PT_COPY);

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
void VMemory::recv_command_require(const CommandPacket& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  nid_t src_nid = Convert::json2nid(packet.content.at("src_nid"));

  assert(addr == get_upper_addr(addr));
  if (src_nid == my_nid) return;

  auto it_space = spaces.find(packet.pid);
  if (it_space == spaces.end()) {
    if (src_nid != SpecialNID::BROADCAST && src_nid != my_nid) {
      picojson::object param;

      param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
      param.insert(std::make_pair("src_nid", Convert::nid2json(src_nid)));

      send_memory_command(packet.pid, SpecialNID::BROADCAST, "require", param);
    }
    return;
  }

  Space& space = *it_space->second;
  auto it_page = space.pages.find(addr);
  if (it_page == space.pages.end()) {
    if (src_nid != SpecialNID::BROADCAST && src_nid != my_nid) {
      picojson::object param;

      param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
      param.insert(std::make_pair("src_nid", Convert::nid2json(src_nid)));

      send_memory_command(packet.pid, SpecialNID::BROADCAST, "require", param);
    }
    return;
  }

  Page& page = it_page->second;
  if (page.type == PT_MASTER) {
    page.hint.insert(src_nid);

    send_command_copy(src_nid, space, page, addr);

  } else if (page.type == PT_COPY) {
    picojson::object param;

    param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
    param.insert(std::make_pair("src_nid", Convert::nid2json(src_nid)));

    send_memory_command(packet.pid, *page.hint.begin(), "require", param);
  }
}

/**
 * When receive reserve command, check addresses to used or not for use those addresses in another node.
 * @param packet Command packet containing target addresses.
 */
void VMemory::recv_command_reserve(const CommandPacket& packet) {
  auto it_space = spaces.find(packet.pid);
  if (it_space == spaces.end()) {
    /// @todo send "I'm not in this space"
  }

  Space& space = *it_space->second;
  for (auto& js_addr : packet.content.at("addrs").get<picojson::array>()) {
    vaddr_t addr = Convert::json2vaddr(js_addr);

    if (space.pages.find(addr) != space.pages.end()) {
      /// @todo send "Address send was used yet!"
      assert(false);
    }
  }
}

/**
 * When receive stand command, send give command to pass master flag if it can.
 * To pass master flag, this node have master flag for taget address and not locked for master by runing thread.
 * @param packet Command packet containing target address.
 */
void VMemory::recv_command_stand(const CommandPacket& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));

  assert(addr == get_upper_addr(addr));
  assert(packet.src_nid != my_nid);

  auto it_space = spaces.find(packet.pid);
  if (it_space == spaces.end()) {
    return;
  }

  Space& space = *it_space->second;
  auto it_page = space.pages.find(addr);
  if (it_page == space.pages.end()) {
    return;
  }

  Page& page = it_page->second;
  if (page.type == PT_MASTER && page.master_count == 0) {
    assert(page.flg_update == true);
    send_command_give(space, page, addr, packet.src_nid);

    page.type = PT_COPY;
    page.hint.clear();
    page.hint.insert(packet.src_nid);
  }

  space.requiring.erase(addr);
}

/**
 * When receive unwant command, remove source node from a set of hint(copy target) and history.
 * @param packet Command packet containing target address.
 */
void VMemory::recv_command_unwant(const CommandPacket& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));

  auto it_space = spaces.find(packet.pid);
  if (it_space == spaces.end()) return;

  Space& space = *it_space->second;
  auto it_page = space.pages.find(get_upper_addr(addr));
  if (it_page == space.pages.end()) return;

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
void VMemory::recv_command_update(const CommandPacket& packet) {
  vaddr_t addr = Convert::json2vaddr(packet.content.at("addr"));
  const std::string& value = Convert::json2bin(packet.content.at("value"));

  auto it_space = spaces.find(packet.pid);
  if (it_space == spaces.end()) {
    /// @todo relay
    assert(false);
    return;
  }

  Space& space = *it_space->second;
  auto it_page = space.pages.find(get_upper_addr(addr));
  if (it_page == space.pages.end()) {
    /// @todo relay
    assert(false);
    return;
  }

  Page& page = it_page->second;
  if (page.type == PT_MASTER) {
    if (page.size < get_lower_addr(addr) + value.size()) {
      /// @todo error
      assert(false);
      return;
    }
    std::memcpy(page.value.get() + get_lower_addr(addr), value.data(), value.size());

    page.referral_count++;
    if (page.referral_count >= MEMORY_REFERRAL_LIMIT && page.master_count == 0) {
      assert(page.flg_update == true);
      send_command_give(space, page, get_upper_addr(addr), packet.src_nid);

      page.type = PT_COPY;
      page.hint.clear();
      page.hint.insert(packet.src_nid);
    }

    delegate.vmemory_recv_update(*this, get_upper_addr(addr));

  } else if (page.type == PT_COPY) {
    send_command_update(*page.hint.begin(), space, addr,
                        reinterpret_cast<const uint8_t*>(value.data()), value.size());

  } else {
    /// @todo error
    assert(false);
  }
}

std::unique_ptr<VMemory::Accessor> VMemory::get_accessor(const std::string& name) {
  Space& space = get_space(name);

  return std::unique_ptr<VMemory::Accessor>(new Accessor(*this, space));
}

// Get space by name.
VMemory::Space& VMemory::get_space(const std::string& name) {
  if (spaces.find(name) == spaces.end()) {
    spaces.insert(std::make_pair(name, std::unique_ptr<Space>
                                 (new Space(name, rnd, *this))));
  }

  return *spaces.at(name);
}

// Switch memory's loading mode.
void VMemory::set_loading(const std::string& name, bool flg) {
  Space& space = get_space(name);

  space.is_loading = flg;
}

/**
 * Send selected command to MEMORY module in another node.
 * @param name Not used.
 * @param dst_nid Destination node-id, BROADCAST, or NONE if not resolved yet.
 * @param command Command string.
 * @param param Parameter for command.
 */
void VMemory::send_memory_command(const std::string& name, const nid_t& dst_nid,
                                  const std::string& command, picojson::object& param) {
  assert(dst_nid != my_nid);

  delegate.vmemory_send_command(*this, dst_nid, Module::MEMORY, command, param);
}

/**
 * Send copy command for update page value in another copy node.
 * This command is used to copy value from master to copy node.
 * Inhibit command if responce (for previous copy command) was not received and
 * didn't spend interval time yet.
 * Update key code and timestamp if command was send.
 * @param dst_nid Destination node-id.
 * @param space Target memory space.
 * @param page Target page having value.
 * @param addr Target address to copy.
 */
void VMemory::send_command_copy(const nid_t& dst_nid, Space& space, Page& page, vaddr_t addr) {
  assert(page.type != PT_COPY);
  assert(dst_nid != my_nid);
  assert(get_upper_addr(addr) == addr);
  std::time_t now = time(nullptr);
  uint64_t key = space.rnd();
  auto history = page.send_copy_history.find(dst_nid);

  if (history == page.send_copy_history.end() ||
      history->second.time + MEMORY_REQUIRE_INTERVAL < now) {
    picojson::object param;
    param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
    param.insert(std::make_pair("value", Convert::bin2json(page.value.get(), page.size)));
    param.insert(std::make_pair("key", Convert::int2json(key)));
    send_memory_command(space.name, dst_nid, "copy", param);

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

void VMemory::send_command_copy_reply(const nid_t& dst_nid, Space& space,
                                      vaddr_t addr, uint64_t key) {
  assert(dst_nid != my_nid);
  assert(get_upper_addr(addr) == addr);

  picojson::object param;
  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  param.insert(std::make_pair("key", Convert::int2json(key)));

  send_memory_command(space.name, dst_nid, "copy_reply", param);
}

/**
 * Send free command.
 * @param dst_nid Destination node-id.
 * @param space Target memory space.
 * @param addr Target address to free.
 */
void VMemory::send_command_free(const nid_t& dst_nid, Space& space, vaddr_t addr) {
  picojson::object param;

  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));

  send_memory_command(space.name, dst_nid, "free", param);
}

/**
 * Send give command for giving master flag of page.
 * @param space Target memory space.
 * @param page Target page having value.
 * @param addr Target address to give master flag.
 * @param dst_nid Node-id target of give master flag.
 */
void VMemory::send_command_give(Space& space, Page& page, vaddr_t addr, const nid_t& dst_nid) {
  assert(page.type == PT_MASTER && page.master_count == 0);
  assert(addr == get_upper_addr(addr));
  picojson::object param;
  picojson::array hint;

  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  param.insert(std::make_pair("value", Convert::bin2json(page.value.get(), page.size)));
  param.insert(std::make_pair("dst_nid", Convert::nid2json(dst_nid)));
  for (auto& h : page.hint) {
    hint.push_back(Convert::nid2json(h));
  }
  param.insert(std::make_pair("hint_nid", picojson::value(hint)));

  send_memory_command(space.name, SpecialNID::BROADCAST, "give", param);
}

/**
 * Send release command for releaseing allocation of page.
 * @param space Target memory space.
 * @param addrs Some addresses to release.
 */
void VMemory::send_command_release(Space& space, std::set<vaddr_t> addrs) {
  picojson::object param;
  picojson::array js_addrs;

  for (auto addr : addrs) {
    js_addrs.push_back(Convert::vaddr2json(addr));
  }
  param.insert(std::make_pair("addrs", picojson::value(js_addrs)));

  send_memory_command(space.name, SpecialNID::BROADCAST, "release", param);
}

/**
 * Send require command for requireing value in target address.
 * @param dst_nid Destination node-id.
 * @param space Target memory space.
 * @param addr Target address to get value.
 */
void VMemory::send_command_require(const nid_t& dst_nid, Space& space, vaddr_t addr) {
  assert(get_upper_addr(addr) == addr);
  space.requiring.insert(addr);
  picojson::object param;

  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  param.insert(std::make_pair("src_nid", Convert::nid2json(my_nid)));

  send_memory_command(space.name, dst_nid, "require", param);
}

/**
 * Send reserve command for reserving address to allocate memory in this node.
 * @param space Target memory space.
 * @param addrs Target addresses for reserving.
 */
void VMemory::send_command_reserve(Space& space, std::set<vaddr_t> addrs) {
  picojson::object param;
  picojson::array js_addrs;

  for (auto addr : addrs) {
    js_addrs.push_back(Convert::vaddr2json(addr));
  }
  param.insert(std::make_pair("addrs", picojson::value(js_addrs)));

  send_memory_command(space.name, SpecialNID::BROADCAST, "reserve", param);
}

/**
 * Send stand command for emmiting to stand for master of target page.
 * @param space Target memory space.
 * @param page Target page.
 * @param addr Target address for stainding.
 */
void VMemory::send_command_stand(Space& space, Page& page, vaddr_t addr) {
  assert(page.type == PT_COPY);
  assert(page.hint.size() == 1);
  assert(addr == get_upper_addr(addr));
  picojson::object param;

  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));

  send_memory_command(space.name, *page.hint.begin(), "stand", param);
}

/**
 * Send unwant command for emiting to a value on target address is not need for this node.
 * @param dst_nid Destination node-id.
 * @param name Target memory name.
 * @param addr Target address.
 */
void VMemory::send_command_unwant(const nid_t& dst_nid, const std::string name, vaddr_t addr) {
  picojson::object param;
  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  send_memory_command(name, dst_nid, "unwant", param);
}

/**
 * Send update command for update page value in master node.
 * @param dst_nid Destination node-id.
 * @param space Target memory space.
 * @param addr Target address to update.
 * @param data Pointer of storeing value to update.
 * @param size Size of data to update.
 */
void VMemory::send_command_update(const nid_t& dst_nid, Space& space, vaddr_t addr,
                                  const uint8_t* data, uint64_t size) {
  picojson::object param;
  param.insert(std::make_pair("value", Convert::bin2json(data, size)));
  param.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  send_memory_command(space.name, dst_nid, "update", param);
}

// Constructor with memory space.
VMemory::Accessor::Accessor(VMemory& vmemory_, Space& space_) :
    vmemory(vmemory_),
    space(space_) {
}

// Get master node-id for target address.
const nid_t& VMemory::Accessor::get_master(vaddr_t addr) {
  Page& page = get_page(addr, false);

  switch (page.type) {
    case PT_MASTER: {
      return vmemory.my_nid;
    } break;

    case PT_COPY: {
      assert(page.hint.size() == 1);
      return *page.hint.begin();
    } break;

    default: {
      /// @todo error
      assert(false);
      return SpecialNID::BROADCAST;
    } break;
  }
}

VMemory::Accessor::MasterKey VMemory::Accessor::keep_master(vaddr_t addr) {
  if (addr == VADDR_NULL)  {
    return MasterKey();
  }

  addr = get_upper_addr(addr);
  Page& page = get_page(addr, true);

  switch (page.type) {
    case PT_MASTER: {
      page.master_count++;
      return MasterKey(&page.master_count, [](int* master_count){
          (*master_count)--;
        });
    } break;

    case PT_COPY: {
      vmemory.send_command_stand(space, page, addr);
      throw InterruptMemoryRequire(addr);
    } break;

    default: {
      /// @todo error
      assert(false);
      return MasterKey(nullptr);
    } break;
  }
}

// Set meta data.
vaddr_t VMemory::Accessor::set_meta_area(const std::string& data, vaddr_t addr) {
  if (addr == VADDR_NULL) {
    addr = space.assign_addr(AddrType::META);
  }
  assert(space.pages.find(addr) == space.pages.end());
  space.pages.insert(std::make_pair(addr, Page(PT_MASTER, true, data,
                                               std::set<nid_t>())));

  return addr;
}

vaddr_t VMemory::Accessor::set_meta_area(const std::string& data, vaddr_t addr,
                                         const nid_t& master) {
  assert(addr != VADDR_NULL);
  assert(space.pages.find(addr) == space.pages.end());
  std::set<nid_t> hint;
  hint.insert(master);
  space.pages.insert(std::make_pair(addr, Page(PT_COPY, true, data, hint)));

  return addr;
}

// Get meta data.
std::string VMemory::Accessor::get_meta_area(vaddr_t addr) {
  assert((AddrType::MASK & addr) == AddrType::META);
  Page& page = get_page(addr, true);

  return std::string(reinterpret_cast<char*>(page.value.get()), page.size);
}

// Change meta data.
void VMemory::Accessor::update_meta_area(vaddr_t addr, const std::string& data) {
  assert((AddrType::MASK & addr) == AddrType::META);
  Page& page = get_page(addr, true);

  if (page.size == data.size() &&
      std::memcmp(page.value.get(), data.data(), page.size) == 0) return;

  switch (page.type) {
    case PT_MASTER: {
      if (page.size != data.size()) {
        page.size = data.size();
        page.value.reset(new uint8_t[page.size]);
      }
      std::memcpy(page.value.get(), data.data(), page.size);
      for (auto& it_hint : page.hint) {
        vmemory.send_command_copy(it_hint, space, page, addr);
      }
    } break;

    case PT_COPY: {
      assert(page.hint.size() == 1);
      page.flg_update = false;
      vmemory.send_command_update(*page.hint.begin(), space, addr,
                                  reinterpret_cast<const uint8_t*>(data.data()), data.size());
    } break;

    default: {
      /// @todo:error
      assert(false);
    } break;
  }
}

// Allocates selected byte of memory.
vaddr_t VMemory::Accessor::alloc(uint64_t size) {
  if (size == 0) size = 1;

  vaddr_t addr = space.assign_addr(get_addr_type(size));

  Page& page = space.pages.insert
               (std::make_pair(addr, Page(PT_MASTER, true, std::set<nid_t>()))).first->second;
  page.size = size;
  page.value.reset(new uint8_t[size]);

  return addr;
}

// Frees allocations that were created via the preceding alloc or realloc.
void VMemory::Accessor::free(vaddr_t addr) {
  if (addr == VADDR_NULL) return;

  if (addr != get_upper_addr(addr)) {
    /// @todo error
    assert(false);
  }

  Page& page = get_page(addr, false);
  switch (page.type) {
    case PT_MASTER: {
      assert(page.master_count == 0 && raw_writable.find(addr) == raw_writable.end());
      page.size = 0;
      page.value.reset();
      for (auto& dst_nid : page.hint) {
        vmemory.send_command_copy(dst_nid, space, page, addr);
      }
      space.release_addr(addr);
      space.pages.erase(addr);
    } break;

    case PT_COPY: {
      assert(page.hint.size() == 1);
      vmemory.send_command_free(*page.hint.begin(), space, addr);
    } break;

    default: {
      /// @todo error
      assert(false);
    } break;
  }
}

// Change the size of allocation pointed to by addr to size.
vaddr_t VMemory::Accessor::realloc(vaddr_t addr, uint64_t size) {
  if (addr == VADDR_NULL) return this->alloc(size);
  if (addr != get_upper_addr(addr)) {
    /// @todo error
    assert(false);
  }
  if (size == 0) size = 1;

  Page& page = get_page(addr, false);
  switch (page.type) {
    case PT_MASTER: {
      AddrType::Type old_type = static_cast<AddrType::Type>(addr & AddrType::MASK);
      AddrType::Type new_type = get_addr_type(size);
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
          vmemory.send_command_copy(to, space, page, addr);
        }
        return addr;

      } else {
        vaddr_t new_addr = space.assign_addr(get_addr_type(size));

        Page& new_page =
            space.pages.insert(std::make_pair(new_addr, Page(PT_MASTER, true, page.hint))).
            first->second;
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
    } break;

    case PT_COPY: {
      assert(page.hint.size() == 1);
      vmemory.send_command_stand(space, page, addr);
      throw InterruptMemoryRequire(addr);
    } break;

    default: {
      /// @todo error
      assert(false);
      return VADDR_NULL;
    } break;
  }
}

// Reserve address in program area.
vaddr_t VMemory::Accessor::reserve_program_area() {
  vaddr_t new_addr;

  do {
    new_addr = AddrType::PROGRAM | (~AddrType::MASK & space.rnd());
  } while (space.pages.find(new_addr) != space.pages.end());

  space.pages.insert(std::make_pair(new_addr, Page(PT_PROGRAM, true, std::set<nid_t>())));

  return new_addr;
}

// Set program data to be selected address.
void VMemory::Accessor::set_program_area(vaddr_t addr, const std::string& data) {
  assert((AddrType::MASK & addr) == AddrType::PROGRAM);
  auto it_page = space.pages.find(addr);
  if (it_page == space.pages.end()) {
    space.pages.insert(std::make_pair(addr, Page(PT_PROGRAM, true, data,
                                                 std::set<nid_t>())));

  } else {
    Page& page = it_page->second;
    assert(page.size == 0);
    page.size = data.size();
    page.value.reset(new uint8_t[page.size]);
    std::memcpy(page.value.get(), data.data(), page.size);
  }
}

// Get program data.
std::string VMemory::Accessor::get_program_area(vaddr_t addr) {
  Page& page = get_page(addr, true);

  return std::string(reinterpret_cast<const char*>(page.value.get()), page.size);
}

// Write out the data selected by get_raw_writable.
void VMemory::Accessor::write_out() {
  auto it = raw_writable.begin();

  while (it != raw_writable.end()) {
    Page& page = get_page(it->first, false);
    switch (page.type) {
      case PT_MASTER: {
        page.value.swap(it->second);
        for (auto& it_hint : page.hint) {
          vmemory.send_command_copy(it_hint, space, page, it->first);
        }
      } break;

      case PT_COPY: {
        assert(page.hint.size() == 1);
        page.flg_update = false;
        vmemory.send_command_update(*page.hint.begin(), space, it->first,
                                    it->second.get(), page.size);
      } break;

      default: {
        /// @todo error
        assert(false);
      } break;
    }

    it = raw_writable.erase(it);
  }
}

/**
 * For debug, show all memory dump there are store in this node.
 * This method is usable when compiled by debug mode, otherwise, this method do nothing.
 */
void VMemory::Accessor::print_dump() {
#ifndef NDEBUG
  for (auto& it_page : space.pages) {
    vaddr_t addr = it_page.first;
    Page& page = it_page.second;
    print_debug("addr:%s\n", Convert::vaddr2str(addr).c_str());
    if ((addr & AddrType::MASK) == AddrType::META) {
      print_debug("value:%s\n",
                  std::string(reinterpret_cast<const char*>(page.value.get()), page.size).
                  c_str());

    } else if ((addr & AddrType::MASK) == AddrType::PROGRAM) {
      picojson::value v;
      picojson::parse(v, std::string(reinterpret_cast<char*>(page.value.get()), page.size));
      std::cerr << v.serialize(true) << std::endl;;
      if (v.get<picojson::object>().at("program_type").get<std::string>() == "01") {
        std::cerr << "code:" << std::endl;
        for (auto& code : v.get<picojson::object>().at("code").get<picojson::array>()) {
          std::cerr << "  " << Util::code2str(Convert::json2code(code)) << std::endl;;
        }
      }
    } else {
      print_debug("value(size=%" PRIu64 "):", page.size);
      for (unsigned int i = 0; i < page.size; i ++) {
        if (i % 16 == 0) fprintf(stderr, "\n%016" PRIx64 " : ", addr + i);
        fprintf(stderr, "%02x ", 0xFF & page.value[i]);
      }
      fprintf(stderr, "\n");
    }
  }
#endif
}

// Constructor with value by string.
VMemory::Page::Page(PageType type_, bool flg_update_,
                    const std::string& value_str, const std::set<nid_t>& hint_) :
    type(type_),
    flg_update(flg_update_),
    value(new uint8_t[value_str.size()]),
    size(value_str.size()),
    hint(hint_),
    master_count(0),
    referral_count(0) {
  std::memcpy(value.get(), value_str.data(), size);
}

// Constructor without initialize value.
VMemory::Page::Page(PageType type_, bool flg_update_, const std::set<nid_t>& hint_) :
    type(type_),
    flg_update(flg_update_),
    size(0),
    hint(hint_),
    master_count(0),
    referral_count(0) {
}

// Constructor with name and random.
VMemory::Space::Space(const std::string& name_, std::mt19937_64& rnd_, VMemory& vmemory_) :
    name(name_),
    rnd(rnd_),
    vmemory(vmemory_),
    is_loading(false) {
}

// Get a new address to allocate a new memory.
vaddr_t VMemory::Space::assign_addr(AddrType::Type type) {
  std::deque<vaddr_t>& reserved_que = reserved[type >> 60];
  std::set<vaddr_t> new_reserve;
  Finally finally;

  if (reserved_que.size() < VMEMORY_RESERVE_MIN) {
    std::set<vaddr_t> reserved_set;
    for (auto& it : reserved_que) {
      reserved_set.insert(it);
    }

    for (unsigned int retry = 0;
         reserved_que.size() + new_reserve.size() < VMEMORY_RESERVE_BASE &&
                              retry < VMEMORY_RESERVE_BASE * 2; retry ++) {
      vaddr_t new_addr = get_upper_addr(type | (~AddrType::MASK & rnd()));

      if (type == AddrType::META && new_addr <= 0xFF) {
        continue;
      }

      if (pages.find(new_addr) == pages.end() &&
          new_reserve.find(new_addr) == new_reserve.end() &&
          reserved_set.find(new_addr) == reserved_set.end()) {
        new_reserve.insert(new_addr);
      }
    }

    if (is_loading) {
      for (auto& it : new_reserve) {
        reserved_que.push_back(it);
      }

    } else {
      vmemory.send_command_reserve(*this, new_reserve);
      finally.add([&]() {
          for (auto& it : new_reserve) {
            reserved_que.push_back(it);
          }
        });
    }
  }

  if (reserved_que.size() == 0) {
    throw InterruptMemoryRequire(VADDR_NULL);
  }

  vaddr_t r = reserved_que.front();
  reserved_que.pop_front();
  return r;
}

// Release a binded address for be used memory to be unused.
void VMemory::Space::release_addr(vaddr_t addr) {
  std::deque<vaddr_t>& reserved_que = reserved[addr >> 60];
  reserved_que.push_front(addr);

  if (reserved_que.size() > VMEMORY_RESERVE_MAX) {
    std::set<vaddr_t> release_set;

    while (reserved_que.size() > VMEMORY_RESERVE_BASE) {
      release_set.insert(reserved_que.back());
      reserved_que.pop_back();
    }

    vmemory.send_command_release(*this, release_set);
  }
}
}  // namespace processwarp
