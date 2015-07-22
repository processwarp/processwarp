
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
  payload.insert(std::make_pair("command", picojson::value(cmd)));
  payload.insert(std::make_pair("from", picojson::value(this->dev_id)));

  delegate.send_memory_data(name, dev_id, picojson::value(payload).serialize());
}

// This request means to update memory for copy data.
void VMemory::send_copy(const dev_id_t& dev_id, Space& space, Page& page, vaddr_t addr) {
  assert(page.type == PT_COPY);
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

// Allocates selected byte of memory.
vaddr_t VMemory::Accessor::alloc(uint64_t size) {
  if (size == 0) size = 1;

  vaddr_t addr = space.assign_addr(get_addr_type(size));

  space.pages.insert(std::make_pair(addr, Page(PT_MASTER, true)));
  space.pages.at(addr).value.resize(size);

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
      
      space.pages.insert(std::make_pair(new_addr, Page(PT_MASTER, true)));
      Page& new_page = space.pages.at(new_addr);
      new_page.value.reserve(size);
      new_page.value = page.value;
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

  space.pages.insert(std::make_pair(new_addr, Page(PT_PROGRAM, true)));

  return new_addr;
}

// Set program data to be selected address.
void VMemory::Accessor::set_program_area(vaddr_t addr, const uint8_t* src, uint64_t size) {
  assert(space.pages.at(addr).value.size() == 0);

  space.pages.at(addr).value = std::string(reinterpret_cast<const char*>(src), size);
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
VMemory::Page::Page(PageType type_, bool flg_update_) :
  type(type_),
  flg_update(flg_update_) {
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
      vaddr_t new_addr = type | (AD_MASK & rnd());
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
