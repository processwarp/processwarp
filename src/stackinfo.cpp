
#include <memory>

#include "convert.hpp"
#include "func_store.hpp"
#include "stackinfo.hpp"

using namespace processwarp;

// コンストラクタ。
StackInfo::StackInfo(vaddr_t addr_,
		     vaddr_t func_,
		     vaddr_t ret_addr_,
		     unsigned int normal_pc_,
		     unsigned int unwind_pc_,
		     vaddr_t stack_) :
  addr(addr_),
  func(func_),
  ret_addr(ret_addr_),
  normal_pc(normal_pc_),
  unwind_pc(unwind_pc_),
  stack(stack_) {
}

// Allocate a now stack-information on memory.
vaddr_t StackInfo::alloc(VMemory::Accessor& memory,
			 vaddr_t func, vaddr_t ret_addr,
			 unsigned int normal_pc, unsigned int unwind_pc,
			 vaddr_t stack) {
  picojson::object js_stackinfo;
  
  js_stackinfo.insert(std::make_pair("func", Convert::vaddr2json(func)));
  js_stackinfo.insert(std::make_pair("ret_addr", Convert::vaddr2json(ret_addr)));
  js_stackinfo.insert(std::make_pair("normal_pc",
				     Convert::int2json<unsigned int>(normal_pc)));
  js_stackinfo.insert(std::make_pair("unwind_pc",
				     Convert::int2json<unsigned int>(unwind_pc)));
  js_stackinfo.insert(std::make_pair("stack", Convert::vaddr2json(stack)));

  js_stackinfo.insert(std::make_pair("alloca_addrs", picojson::value(picojson::array())));
  js_stackinfo.insert(std::make_pair("var_arg", Convert::vaddr2json(VADDR_NULL)));
  js_stackinfo.insert(std::make_pair("pc", Convert::int2json<unsigned int>(0)));
  js_stackinfo.insert(std::make_pair("phi0", Convert::int2json<unsigned int>(0)));
  js_stackinfo.insert(std::make_pair("phi1", Convert::int2json<unsigned int>(0)));
  js_stackinfo.insert(std::make_pair("type", Convert::vaddr2json(VADDR_NULL)));
  js_stackinfo.insert(std::make_pair("alignment", Convert::int2json<vm_int_t>(0)));
  js_stackinfo.insert(std::make_pair("output", Convert::vaddr2json(VADDR_NULL)));
  js_stackinfo.insert(std::make_pair("value", Convert::vaddr2json(VADDR_NULL)));
  js_stackinfo.insert(std::make_pair("address", Convert::vaddr2json(VADDR_NULL)));

  std::string str_stackinfo = picojson::value(js_stackinfo).serialize();
  return memory.set_meta_area(str_stackinfo, VADDR_NULL);
}

// Read out stack-informaition from memory and generate instance.
std::unique_ptr<StackInfo> StackInfo::read(VMemory::Accessor& memory, vaddr_t addr) {
  picojson::value js_tmp;
  std::istringstream is(memory.get_meta_area(addr));
  std::string err = picojson::parse(js_tmp, is);
  if (!err.empty()) {
    /// @todo error
    assert(false);
  }
  picojson::object& js_stackinfo = js_tmp.get<picojson::object>();
  std::unique_ptr<StackInfo> stackinfo
    (new StackInfo(addr,
		   Convert::json2vaddr(js_stackinfo.at("func")),
		   Convert::json2vaddr(js_stackinfo.at("ret_addr")),
		   Convert::json2int<unsigned int>(js_stackinfo.at("normal_pc")),
		   Convert::json2int<unsigned int>(js_stackinfo.at("unwind_pc")),
		   Convert::json2vaddr(js_stackinfo.at("stack"))));

  stackinfo->read(js_stackinfo);

  return stackinfo;
}

// Read and update stack-information for this instance.
void StackInfo::read(VMemory::Accessor& memory) {
  picojson::value js_tmp;
  std::istringstream is(memory.get_meta_area(addr));
  std::string err = picojson::parse(js_tmp, is);
  if (!err.empty()) {
    /// @todo error
    assert(false);
  }
  
  return read(js_tmp.get<picojson::object>());
}

// Read and update stack-information for this instance.
void StackInfo::read(const picojson::object& js_stackinfo) {
  alloca_addrs = Convert::json2vaddr_vector(js_stackinfo.at("alloca_addrs"));
  var_arg = Convert::json2vaddr(js_stackinfo.at("var_arg"));
  pc = Convert::json2int<unsigned int>(js_stackinfo.at("pc"));
  phi0 = Convert::json2int<unsigned int>(js_stackinfo.at("phi0"));
  phi1 = Convert::json2int<unsigned int>(js_stackinfo.at("phi1"));
  type = Convert::json2vaddr(js_stackinfo.at("type"));
  type_operator = nullptr;
  type_store.reset(nullptr);
  alignment = Convert::json2int<vm_int_t>(js_stackinfo.at("alignment"));
  output = Convert::json2vaddr(js_stackinfo.at("output"));
  value = Convert::json2vaddr(js_stackinfo.at("value"));
  address = Convert::json2vaddr(js_stackinfo.at("address"));
}

// Write out stack-information to memory.
void StackInfo::write(VMemory::Accessor& memory) {
  picojson::object js_stackinfo;

  js_stackinfo.insert(std::make_pair("func", Convert::vaddr2json(func)));
  js_stackinfo.insert(std::make_pair("ret_addr", Convert::vaddr2json(ret_addr)));
  js_stackinfo.insert(std::make_pair("normal_pc",
				     Convert::int2json<unsigned int>(normal_pc)));
  js_stackinfo.insert(std::make_pair("unwind_pc",
				     Convert::int2json<unsigned int>(unwind_pc)));
  js_stackinfo.insert(std::make_pair("stack", Convert::vaddr2json(stack)));

  js_stackinfo.insert(std::make_pair("alloca_addrs",
				     Convert::vaddr_vector2json(alloca_addrs)));
  js_stackinfo.insert(std::make_pair("var_arg", Convert::vaddr2json(var_arg)));
  js_stackinfo.insert(std::make_pair("pc", Convert::int2json<unsigned int>(pc)));
  js_stackinfo.insert(std::make_pair("phi0", Convert::int2json<unsigned int>(phi0)));
  js_stackinfo.insert(std::make_pair("phi1", Convert::int2json<unsigned int>(phi1)));
  js_stackinfo.insert(std::make_pair("type", Convert::vaddr2json(type)));
  js_stackinfo.insert(std::make_pair("alignment", Convert::int2json<vm_int_t>(alignment)));
  js_stackinfo.insert(std::make_pair("output", Convert::vaddr2json(output)));
  js_stackinfo.insert(std::make_pair("value", Convert::vaddr2json(value)));
  js_stackinfo.insert(std::make_pair("address", Convert::vaddr2json(address)));

  memory.update_meta_area(addr, picojson::value(js_stackinfo).serialize());
}

// Free all memory area bind to this stack without a area bind to this instance.
void StackInfo::destroy(VMemory::Accessor& memory) {
  memory.free(stack);
  for (vaddr_t alloca_addr : alloca_addrs) {
    memory.free(alloca_addr);
  }
}
