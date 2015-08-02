
#include <cassert>
#include <queue>
#include <set>

#include "convert.hpp"
#include "error.hpp"
#include "finally.hpp"
#include "util.hpp"
#include "vmemory.hpp"

using namespace processwarp;

const vaddr_t VMemory::UPPER_MASKS[]  = {
  0xFFFFFFFFFFFFFFFF, ///< Meta data
  0xFFFFFFFFFFFFFF00,
  0xFFFFFFFFFFFF0000,
  0xFFFFFFFFFF000000,
  0xFFFFFFFF00000000,
  0xFFFFFF0000000000,
  0xFFFF000000000000,
  0x0000000000000000, // dummy
  0x0000000000000000, // dummy
  0xFFFFFFFFFFFFFF00,
  0xFFFFFFFFFFFF0000,
  0xFFFFFFFFFF000000,
  0xFFFFFFFF00000000,
  0xFFFFFF0000000000,
  0xFFFF000000000000,
  0xFFFFFFFFFFFFFFFF, // Function, Type
};

// Constructor with device-id.
VMemory::VMemory(VMemoryDelegate& delegate_, const dev_id_t& dev_id_) :
  dev_id(dev_id_),
  rnd(std::random_device()()),
  delegate(delegate_) {
}

// Recv and decode data from other device.
void VMemory::recv_packet(const std::string& name, const std::string& data) {
  picojson::value v;
  std::istringstream is(data);
  std::string err = picojson::parse(v, is);
  if (!err.empty()) {
    std::cerr << err << std::endl;
    assert(false);
    /// @todo error
  }
  picojson::object& json = v.get<picojson::object>();

  std::string cmd = json.at("cmd").get<std::string>();
  if (cmd == "copy") {
    recv_copy(name, json);

  } else if (cmd == "require") {
    recv_require(name, json);
    /*
  } else if (cmd == "update") {
  } else if (cmd == "reserve") {
  } else if (cmd == "free") {
  } else if (cmd == "release") {
  } else if (cmd == "stand") {
    */
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
  const std::string& value = json.at("value").get<std::string>();
  dev_id_t src = Convert::json2devid(json.at("src"));
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
    if (it_ri == space.requiring.end()) {
      send_unwant(name, src, addr);

    } else {
      std::set<dev_id_t> hint;
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
      page.value = value;
      page.flg_update = true;

    } else {
      space.pages.erase(addr);
    }

    space.requiring.erase(addr);
  }
}

void VMemory::recv_give(const std::string& name, picojson::object& json) {
  vaddr_t addr = get_upper_addr(Convert::json2vaddr(json.at("addr")));
  const std::string& value = json.at("value").get<std::string>();
  dev_id_t src = Convert::json2devid(json.at("src"));
  dev_id_t dst = Convert::json2devid(json.at("dst"));
  picojson::array js_hint = json.at("hint").get<picojson::array>();

  auto it_space = spaces.find(name);
  if (it_space == spaces.end()) {
    if (dst == dev_id) {
      /// @todo Give master to this device but this device is't binded selected name space.
      assert(false);

    } else {
      send_unwant(name, dst, addr);
      return;
    }
  }

  Space& space = *it_space->second;
  auto it_page = space.pages.find(addr);
  if (dst == dev_id) {
    std::set<dev_id_t> hint;
    for (auto& js_h : js_hint)
      hint.insert(Convert::json2devid(js_h));
    
    if (it_page == space.pages.end()) {
      space.pages.insert(std::make_pair(addr, Page(PT_MASTER, true, value, hint)));

    } else {
      Page& page = it_page->second;
      assert(page.type == PT_COPY);

      page.type = PT_MASTER;
      page.flg_update = true;
      page.value = value;
      page.hint = hint;
    }
    space.requiring.erase(addr);

  } else {
    if (it_page == space.pages.end()) {
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
  vaddr_t addr = get_upper_addr(Convert::json2vaddr(json.at("addr")));
  dev_id_t src = Convert::json2devid(json.at("src"));

  auto it_space = spaces.find(name);
  if (it_space == spaces.end()) {
    if (src != DEV_BROADCAST && src != dev_id) {
      picojson::object packet;

      packet.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
      packet.insert(std::make_pair("src", Convert::devid2json(src)));

      send_packet(name, DEV_BROADCAST, "require", packet);
    }
    return;
  }

  Space& space = *it_space->second;
  auto it_page = space.pages.find(addr);
  if (it_page == space.pages.end()) {
    if (src != DEV_BROADCAST && src != dev_id) {
      picojson::object packet;

      packet.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
      packet.insert(std::make_pair("src", Convert::devid2json(src)));

      send_packet(name, DEV_BROADCAST, "require", packet);
    }
    return;
  }
  
  Page& page = it_page->second;
  if (page.type == PT_MASTER) {
    page.hint.insert(src);
    
  } if (page.type == PT_COPY) {
    picojson::object packet;

    packet.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
    packet.insert(std::make_pair("src", Convert::devid2json(src)));

    send_packet(name, *page.hint.begin(), "require", packet);
  }

  send_copy(src, space, page, addr);
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
void VMemory::send_packet(const std::string& name, const dev_id_t& dev_id,
			  const std::string& cmd, picojson::object& payload) {
  payload.insert(std::make_pair("cmd", picojson::value(cmd)));
  payload.insert(std::make_pair("src", picojson::value(this->dev_id)));

  delegate.send_memory_data(name, dev_id, picojson::value(payload).serialize());
}

// This request means to update memory for copy data.
void VMemory::send_copy(const dev_id_t& dev_id, Space& space, Page& page, vaddr_t addr) {
  assert(page.type == PT_COPY);
  assert(get_upper_addr(addr) == addr);
  picojson::object packet;
  
  packet.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  packet.insert(std::make_pair("value", picojson::value(page.value)));

  send_packet(space.name, dev_id, "copy", packet);
}

// This request means to selected memory isn't able to use.
void VMemory::send_free(const dev_id_t& dev_id, Space& space, vaddr_t addr) {
  picojson::object packet;

  packet.insert(std::make_pair("addr", Convert::vaddr2json(addr)));

  send_packet(space.name, dev_id, "free", packet);
}

// This request means to broadcast some unused address.
void VMemory::send_release(Space& space, std::set<vaddr_t> addrs) {
  picojson::object packet;
  picojson::array js_addrs;

  for (auto addr : addrs) {
    js_addrs.push_back(Convert::vaddr2json(addr));
  }
  packet.insert(std::make_pair("addrs", picojson::value(js_addrs)));

  send_packet(space.name, DEV_BROADCAST, "release", packet);
}

// This request means to need a data of copy.
void VMemory::send_require(Space& space, vaddr_t addr, const dev_id_t& dev_id) {
  auto it_ri = space.requiring.find(addr);
  if (it_ri == space.requiring.end()) {
    VMemory::Space::RequireInfo ri;
    ri.last_clock = clock();
    ri.try_count = 1;
    space.requiring.insert(std::make_pair(addr, ri));

  } else {
    VMemory::Space::RequireInfo& ri = it_ri->second;
    clock_t now = clock();
    if (now - ri.last_clock < MEMORY_REQUIRE_INTERVAL) return;
    if (ri.try_count > MEMORY_REQUIRE_TRY_MAX) {
      /// @todo error
      assert(false);
    }
    ri.last_clock = now;
    ri.try_count ++;
  }
  picojson::object packet;

  packet.insert(std::make_pair("addr", Convert::vaddr2json(addr)));

  send_packet(space.name, dev_id, "require", packet);
}

// This request means to broadcast some reserve address for this device.
void VMemory::send_reserve(Space& space, std::set<vaddr_t> addrs) {
  picojson::object packet;
  picojson::array js_addrs;

  for (auto addr : addrs) {
    js_addrs.push_back(Convert::vaddr2json(addr));
  }
  packet.insert(std::make_pair("addrs", picojson::value(js_addrs)));

  send_packet(space.name, DEV_BROADCAST, "reserve", packet);
}

// This request means to stand as master.
void VMemory::send_stand(Space& space, Page& page, vaddr_t addr) {
  if (page.type != PT_MASTER) {
    assert(page.hint.size() == 1);
    picojson::object packet;

    packet.insert(std::make_pair("addr", Convert::vaddr2json(addr)));

    send_packet(space.name, *page.hint.begin(), "stand", packet);
  }
}

// This request means tell unwant copy packet to sender.
void VMemory::send_unwant(const std::string name, const dev_id_t& dev_id, vaddr_t addr) {
  picojson::object packet;
  packet.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  send_packet(name, dev_id, "unwant", packet);
}

// Send update packet.
void VMemory::send_update(const dev_id_t& dev_id, Space& space, vaddr_t addr,
			  const uint8_t* data, uint64_t size) {
  picojson::object packet;
  packet.insert(std::make_pair("value", picojson::value
			       (std::string(reinterpret_cast<const char*>(data), size))));
  packet.insert(std::make_pair("addr", Convert::vaddr2json(addr)));
  send_packet(space.name, dev_id, "update", packet);
}

// Constructor with memory space.
VMemory::Accessor::Accessor(VMemory& vmemory_, Space& space_) :
  vmemory(vmemory_),
  space(space_) {
}

// Set meta data.
vaddr_t VMemory::Accessor::set_meta_area(const std::string& data, vaddr_t addr) {
  if (addr == VADDR_NULL) {
    addr = space.assign_addr(AD_META);
  }
  assert(space.pages.find(addr) == space.pages.end());
  space.pages.insert(std::make_pair(addr, Page(PT_MASTER, true, data,
					       std::set<dev_id_t>())));
  
  return addr;
}

// Get meta data.
const std::string& VMemory::Accessor::get_meta_area(vaddr_t addr) {
  assert((AD_MASK & addr) == AD_META);
  Page& page = get_page(addr, true);

  return page.value;
}

// Allocates selected byte of memory.
vaddr_t VMemory::Accessor::alloc(uint64_t size) {
  if (size == 0) size = 1;

  vaddr_t addr = space.assign_addr(get_addr_type(size));

  space.pages.insert(std::make_pair(addr, Page(PT_MASTER, true, std::string(size, '\0'),
					       std::set<dev_id_t>())));

  return addr;
}

// Frees allocations that were created via the preceding alloc or realloc.
void VMemory::Accessor::free(vaddr_t addr) {
  if (addr == VADDR_NULL) return;

  if (addr != get_upper_addr(addr)) {
    /// TODO:error
    assert(false);
  }

  Page& page = get_page(addr, false);
  switch(page.type) {
  case PT_MASTER: {
    page.value.resize(0);
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
    /// TODO:error
    assert(false);
  } break;
  }
}

// Change the size of allocation pointed to by addr to size.
vaddr_t VMemory::Accessor::realloc(vaddr_t addr, uint64_t size) {
  if (addr == VADDR_NULL) return this->alloc(size);
  if (addr != get_upper_addr(addr)) {
    /// TODO:error
    assert(false);
  }
  if (size == 0) size = 1;

  Page& page = get_page(addr, false);
  switch(page.type) {
  case PT_MASTER: {
    AddrType old_type = static_cast<AddrType>(addr & AD_MASK);
    AddrType new_type = get_addr_type(size);
    if (old_type == new_type) {
      page.value.resize(size, 0);
      for (auto& to : page.hint) {
	vmemory.send_copy(to, space, page, addr);
      }
      return addr;
      
    } else {
      vaddr_t new_addr = space.assign_addr(get_addr_type(size));
      
      Page& new_page =
	space.pages.insert(std::make_pair(new_addr, Page
					  (PT_MASTER, true, page.value, page.hint))).
	first->second;
      new_page.value.resize(size, 0);
      this->free(addr);

      return new_addr;
    }
  } break;

  case PT_COPY: {
    assert(page.hint.size() == 1);
    vmemory.send_stand(space, page, addr);
    /// TODO:skip
    assert(false);
    return VADDR_NULL;
  } break;

  default: {
    /// TODO:error
    assert(false);
    return VADDR_NULL;
  } break;
  }
}

// Reserve address in program area.
vaddr_t VMemory::Accessor::reserve_program_area() {
  vaddr_t new_addr;

  do {
    new_addr = AD_PROGRAM | (~AD_MASK & space.rnd());
  } while(space.pages.find(new_addr) != space.pages.end());

  space.pages.insert(std::make_pair(new_addr, Page(PT_PROGRAM, true, "",
						   std::set<dev_id_t>())));

  return new_addr;
}

// Set program data to be selected address.
void VMemory::Accessor::set_program_area(vaddr_t addr, const std::string& data) {
  assert((AD_MASK & addr) == AD_PROGRAM);
  if (space.pages.find(addr) == space.pages.end()) {
    space.pages.insert(std::make_pair(addr, Page(PT_PROGRAM, true, data,
						 std::set<dev_id_t>())));

  } else {
    assert(space.pages.at(addr).value.size() == 0);
    space.pages.at(addr).value = data;
  }
}

// Get program data.
const std::string& VMemory::Accessor::get_program_area(vaddr_t addr) {
  Page& page = get_page(addr, true);
  
  return page.value;
}

// Write out the data selected by get_raw_writable.
void VMemory::Accessor::write_out() {
  auto it = raw_writable.begin();

  while (it != raw_writable.end()) {
    Page& page = get_page(it->first, false);
    switch(page.type) {
    case PT_MASTER: {
      std::string tmp(reinterpret_cast<const char*>(it->second.get()), page.value.size());
      page.value.swap(tmp);
      for(auto& it_hint : page.hint) {
	vmemory.send_copy(it_hint, space, page, it->first);
      }
    } break;

    case PT_COPY: {
      assert(page.hint.size() == 1);
      page.flg_update = false;
      vmemory.send_update(*page.hint.begin(), space, it->first,
			  it->second.get(), page.value.size());
    } break;

    default: {
      /// TODO:error
      assert(false);
    } break;
    }
    
    it = raw_writable.erase(it);
  }
}

// Constructor with member value.
VMemory::Page::Page(PageType type_, bool flg_update_,
		    const std::string& value_, const std::set<dev_id_t>& hint_) :
  type(type_),
  flg_update(flg_update_),
  value(value_),
  hint(hint_) {
}

// Constructor with name and random.
VMemory::Space::Space(const std::string& name_, std::mt19937_64& rnd_, VMemory& vmemory_) :
  name(name_),
  rnd(rnd_),
  vmemory(vmemory_),
  is_loading(false) {
}

// Get a new address to allocate a new memory.
vaddr_t VMemory::Space::assign_addr(AddrType type) {
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
      vaddr_t new_addr = get_upper_addr(type | (~AD_MASK & rnd()));

      if (type == AD_META && new_addr <= 0xFF) {
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
    /// TODO:skip
    assert(false);
  }

  vaddr_t r = reserved_que.front();
  reserved_que.pop_front();
  return r;
}

// Release a binded address for be used memory to be unused.
void VMemory::Space::release_addr(vaddr_t addr) {
  std::deque<vaddr_t>& reserved_que = reserved[get_addr_type(addr) >> 60];
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
