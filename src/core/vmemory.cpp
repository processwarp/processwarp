
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
    nid(nid_),
    rnd(std::random_device()()),
    delegate(delegate_) {
}

// Recv and decode data from other node.
void VMemory::recv_memory_data(const std::string& name, const std::string& data) {
  picojson::value v;
  std::istringstream is(data);
  std::string err = picojson::parse(v, is);
  if (!err.empty()) {
    std::cerr << err << std::endl;
    assert(false);
    /// @todo error
  }
  picojson::object& json = v.get<picojson::object>();

  std::string cmd = json.at("command").get<std::string>();
  if (cmd == "copy") {
    recv_copy(name, json);

  } else if (cmd == "require") {
    recv_require(name, json);

  } else if (cmd == "update") {
    recv_update(name, json);

  } else if (cmd == "reserve") {
    recv_reserve(name, json);

  } else if (cmd == "free") {
    recv_free(name, json);

    /*
      } else if (cmd == "release") {
    */
  } else if (cmd == "stand") {
    recv_stand(name, json);

  } else if (cmd == "give") {
    recv_give(name, json);
  } else {
    assert(false);
    /// @todo error
  }

  return;
}

void VMemory::recv_copy(const std::string& name, picojson::object& json) {
  vaddr_t addr = Convert::json2vaddr(json.at("addr"));
  const std::string& value = Convert::json2bin(json.at("value"));
  nid_t src = Convert::json2nid(json.at("src_nid"));
  if (get_upper_addr(addr) != addr) {
    /// @todo error
    assert(false);
  }

  auto it_space = spaces.find(name);
  if (it_space == spaces.end()) {
    send_unwant(name, src, addr);
    return;
  }

  Space& space = *it_space->second;
  auto it_page = space.pages.find(addr);
  if (it_page == space.pages.end()) {
    if (value.size() == 0) return;

    auto it_ri = space.requiring.find(addr);
    if (it_ri != space.requiring.end()) {
      std::set<nid_t> hint;
      hint.insert(src);
      space.pages.insert(std::make_pair
                         (addr, Page(is_program(addr) ? PT_PROGRAM : PT_COPY,
                                     true, value, hint)));
      space.requiring.erase(it_ri);
    }

  } else {
    Page& page = it_page->second;
    assert(page.type == PT_COPY);
    assert(page.hint.size() == 1);
    assert(*page.hint.begin() == src);

    if (value.size() != 0) {
      if (page.size != value.size()) {
        page.size = value.size();
        page.value.reset(new uint8_t[page.size]);
      }
      std::memcpy(page.value.get(), value.data(), page.size);
      page.flg_update = true;

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

void VMemory::recv_free(const std::string& name, picojson::object& json) {
  vaddr_t addr = Convert::json2vaddr(json.at("addr"));
  assert(addr == get_upper_addr(addr));

  auto it_space = spaces.find(name);
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
      for (auto& to : page.hint) {
        send_copy(to, space, page, addr);
      }
      space.release_addr(addr);
      space.pages.erase(addr);
    } break;

    case PT_COPY: {
      assert(page.hint.size() == 1);
      send_free(*page.hint.begin(), space, addr);
    } break;

    default: {
      /// @todo error
      assert(false);
    } break;
  }
}

void VMemory::recv_give(const std::string& name, picojson::object& json) {
  vaddr_t addr = Convert::json2vaddr(json.at("addr"));
  const std::string& value = Convert::json2bin(json.at("value"));
  nid_t src = Convert::json2nid(json.at("src_nid"));
  nid_t dst = Convert::json2nid(json.at("dst_nid"));
  picojson::array js_hint = json.at("hint_nid").get<picojson::array>();
  assert(addr == get_upper_addr(addr));

  auto it_space = spaces.find(name);
  if (it_space == spaces.end()) {
    if (dst == nid) {
      /// @todo Give master to this node but this node is't binded selected name space.
      assert(false);

    } else {
      send_unwant(name, dst, addr);
      /// @todo send_unwant and relay packet to dst.
      assert(false);
      return;
    }
  }

  Space& space = *it_space->second;
  auto it_page = space.pages.find(addr);
  if (dst == nid) {
    std::set<nid_t> hint;
    for (auto& js_h : js_hint) {
      const nid_t& hint_node = Convert::json2nid(js_h);
      if (hint_node != nid) {
        hint.insert(hint_node);
      }
    }
    if (src != SpecialNID::SERVER) {
      hint.insert(src);
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
    }

    auto it_ri = space.requiring.find(addr);
    if (it_ri != space.requiring.end()) {
      space.requiring.erase(it_ri);
    }

    delegate.vmemory_recv_update(*this, addr);

  } else {
    if (it_page == space.pages.end()) {
      /// @todo
      assert(false);
      send_unwant(name, dst, addr);

    } else {
      Page& page = it_page->second;
      assert(page.type == PT_COPY);

      page.hint.clear();
      page.hint.insert(dst);
    }
  }
}

void VMemory::recv_require(const std::string& name, picojson::object& json) {
  vaddr_t addr = Convert::json2vaddr(json.at("addr"));
  nid_t src = Convert::json2nid(json.at("src_nid"));
  assert(addr == get_upper_addr(addr));
  assert(src != nid);

  auto it_space = spaces.find(name);
  if (it_space == spaces.end()) {
    if (src != SpecialNID::BROADCAST && src != nid) {
      picojson::object packet;

      packet.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
      packet.insert(std::make_pair("src_nid", Convert::nid2json(src)));

      send_packet(name, SpecialNID::BROADCAST, "require", packet);
    }
    return;
  }

  Space& space = *it_space->second;
  auto it_page = space.pages.find(addr);
  if (it_page == space.pages.end()) {
    if (src != SpecialNID::BROADCAST && src != nid) {
      picojson::object packet;

      packet.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
      packet.insert(std::make_pair("src_nid", Convert::nid2json(src)));

      send_packet(name, SpecialNID::BROADCAST, "require", packet);
    }
    return;
  }

  Page& page = it_page->second;
  if (page.type == PT_MASTER) {
    page.hint.insert(src);

  } else if (page.type == PT_COPY) {
    picojson::object packet;

    packet.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
    packet.insert(std::make_pair("src_nid", Convert::nid2json(src)));

    send_packet(name, *page.hint.begin(), "require", packet);
  }

  send_copy(src, space, page, addr);
}

void VMemory::recv_reserve(const std::string& name, picojson::object& json) {
  auto it_space = spaces.find(name);
  if (it_space == spaces.end()) {
    /// @todo send "I'm not in this space"
  }

  Space& space = *it_space->second;
  for (auto& js_addr : json.at("addrs").get<picojson::array>()) {
    vaddr_t addr = Convert::json2vaddr(js_addr);

    if (space.pages.find(addr) != space.pages.end()) {
      /// @todo send "Address send was used yet!"
      assert(false);
    }
  }
}

void VMemory::recv_stand(const std::string& name, picojson::object& json) {
  vaddr_t addr = Convert::json2vaddr(json.at("addr"));
  nid_t src_node = Convert::json2nid(json.at("src_nid"));
  assert(addr == get_upper_addr(addr));
  assert(src_node != nid);

  auto it_space = spaces.find(name);
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
    send_give(space, page, addr, src_node);

    page.type = PT_COPY;
    page.hint.clear();
    page.hint.insert(src_node);
  }

  space.requiring.erase(addr);
}

void VMemory::recv_update(const std::string& name, picojson::object& json) {
  std::string value = Convert::json2bin(json.at("value"));
  vaddr_t addr = Convert::json2vaddr(json.at("addr"));

  auto it_space = spaces.find(name);
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
      /// @toto error
      assert(false);
      return;
    }
    std::memcpy(page.value.get() + get_lower_addr(addr), value.data(), value.size());
    delegate.vmemory_recv_update(*this, get_upper_addr(addr));

  } else if (page.type == PT_COPY) {
    send_update(*page.hint.begin(), space, addr,
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

// Send packet.
void VMemory::send_packet(const std::string& name, const nid_t& nid,
                          const std::string& cmd, picojson::object& data) {
  assert(nid != this->nid);
  data.insert(std::make_pair("command", picojson::value(cmd)));
  data.insert(std::make_pair("src_nid", Convert::nid2json(this->nid)));

  delegate.vmemory_send_packet(*this, nid, picojson::value(data).serialize());
}

// This request means to update memory for copy data.
void VMemory::send_copy(const nid_t& nid, Space& space, Page& page, vaddr_t addr) {
  assert(page.type != PT_COPY);
  assert(nid != this->nid);
  assert(get_upper_addr(addr) == addr);
  picojson::object packet;

  packet.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  packet.insert(std::make_pair("value", Convert::bin2json(page.value.get(), page.size)));

  send_packet(space.name, nid, "copy", packet);
}

// This request means to selected memory isn't able to use.
void VMemory::send_free(const nid_t& nid, Space& space, vaddr_t addr) {
  picojson::object packet;

  packet.insert(std::make_pair("addr", Convert::vaddr2json(addr)));

  send_packet(space.name, nid, "free", packet);
}

// This request means to give right of master.
void VMemory::send_give(Space& space, Page& page, vaddr_t addr, const nid_t& dst) {
  assert(page.type == PT_MASTER && page.master_count == 0);
  assert(addr == get_upper_addr(addr));
  picojson::object packet;
  picojson::array hint;

  packet.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  packet.insert(std::make_pair("value", Convert::bin2json(page.value.get(), page.size)));
  packet.insert(std::make_pair("dst_nid", Convert::nid2json(dst)));
  for (auto& h : page.hint) {
    hint.push_back(Convert::nid2json(h));
  }
  packet.insert(std::make_pair("hint_nid", picojson::value(hint)));

  send_packet(space.name, dst, "give", packet);
}

// This request means to broadcast some unused address.
void VMemory::send_release(Space& space, std::set<vaddr_t> addrs) {
  picojson::object packet;
  picojson::array js_addrs;

  for (auto addr : addrs) {
    js_addrs.push_back(Convert::vaddr2json(addr));
  }
  packet.insert(std::make_pair("addrs", picojson::value(js_addrs)));

  send_packet(space.name, SpecialNID::BROADCAST, "release", packet);
}

// This request means to need a data of copy.
void VMemory::send_require(Space& space, vaddr_t addr, const nid_t& nid) {
  assert(get_upper_addr(addr) == addr);
  space.requiring.insert(addr);
  picojson::object packet;

  packet.insert(std::make_pair("addr", Convert::vaddr2json(addr)));

  send_packet(space.name, nid, "require", packet);
}

// This request means to broadcast some reserve address for this node.
void VMemory::send_reserve(Space& space, std::set<vaddr_t> addrs) {
  picojson::object packet;
  picojson::array js_addrs;

  for (auto addr : addrs) {
    js_addrs.push_back(Convert::vaddr2json(addr));
  }
  packet.insert(std::make_pair("addrs", picojson::value(js_addrs)));

  send_packet(space.name, SpecialNID::BROADCAST, "reserve", packet);
}

// This request means to stand as master.
void VMemory::send_stand(Space& space, Page& page, vaddr_t addr) {
  assert(page.type == PT_COPY);
  assert(page.hint.size() == 1);
  assert(addr == get_upper_addr(addr));
  picojson::object packet;

  packet.insert(std::make_pair("addr", Convert::vaddr2json(addr)));

  send_packet(space.name, *page.hint.begin(), "stand", packet);
}

// This request means tell unwant copy packet to sender.
void VMemory::send_unwant(const std::string name, const nid_t& nid, vaddr_t addr) {
  picojson::object packet;
  packet.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  send_packet(name, nid, "unwant", packet);
}

// Send update packet.
void VMemory::send_update(const nid_t& nid, Space& space, vaddr_t addr,
                          const uint8_t* data, uint64_t size) {
  picojson::object packet;
  packet.insert(std::make_pair("value", Convert::bin2json(data, size)));
  packet.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  send_packet(space.name, nid, "update", packet);
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
      return vmemory.nid;
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
      vmemory.send_stand(space, page, addr);
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
        vmemory.send_copy(it_hint, space, page, addr);
      }
    } break;

    case PT_COPY: {
      assert(page.hint.size() == 1);
      page.flg_update = false;
      vmemory.send_update(*page.hint.begin(), space, addr,
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
      for (auto& to : page.hint) {
        vmemory.send_copy(to, space, page, addr);
      }
      space.release_addr(addr);
      space.pages.erase(addr);
    } break;

    case PT_COPY: {
      assert(page.hint.size() == 1);
      vmemory.send_free(*page.hint.begin(), space, addr);
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
          vmemory.send_copy(to, space, page, addr);
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
      vmemory.send_stand(space, page, addr);
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
          vmemory.send_copy(it_hint, space, page, it->first);
        }
      } break;

      case PT_COPY: {
        assert(page.hint.size() == 1);
        page.flg_update = false;
        vmemory.send_update(*page.hint.begin(), space, it->first, it->second.get(), page.size);
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
      print_debug("value(size=%llu):", page.size);
      for (unsigned int i = 0; i < page.size; i ++) {
        if (i % 16 == 0) fprintf(stderr, "\n%016llx : ", addr + i);
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
    master_count(0) {
  std::memcpy(value.get(), value_str.data(), size);
}

// Constructor without initialize value.
VMemory::Page::Page(PageType type_, bool flg_update_, const std::set<nid_t>& hint_) :
    type(type_),
    flg_update(flg_update_),
    size(0),
    hint(hint_),
    master_count(0) {
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
      vmemory.send_reserve(*this, new_reserve);
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

    vmemory.send_release(*this, release_set);
  }
}
}  // namespace processwarp
