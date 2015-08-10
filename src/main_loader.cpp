#include <cerrno>
#include <cstring>
#include <iostream>
#include <fstream>
#include <sstream>

#include "lib/picojson.h"

#include "convert.hpp"
#include "definitions.hpp"
#include "error.hpp"
#include "llvm_asm_loader.hpp"
#include "process.hpp"
#include "vmemory.hpp"

using namespace processwarp;

static const std::string pool_path("/tmp/");

/**
 * Load program from LLVM-IR and write dump file.
 */
class Loader : public ProcessDelegate, public VMemoryDelegate {
public:
  /// Virtual memory for this loader.
  VMemory vmemory;

  /// Assigned process-id.
  vpid_t in_pid;
  ///
  std::string in_name;
  /// 
  dev_id_t in_dst_device;
  ///
  dev_id_t in_src_device;
  ///
  std::string in_src_account;

  ///
  vtid_t out_root_tid;

  /**
   * Constructor, initialize virtual-memory instance.
   */
  Loader() :
    vmemory(*this, DEV_SERVER) {
  }

  /**
   */
  std::unique_ptr<VMemory::Accessor> assign_accessor(const vpid_t& pid) override {
    assert(!in_pid.empty());
    return std::move(vmemory.get_accessor(Convert::vpid2str(pid)));
  }

  /**
   */
  void on_change_thread_set(Process& proc) override {
  }

  // Call when send memory data to other device.
  void send_memory_data(const std::string& name,
			const dev_id_t& dev_id,
			const std::string& data) override {
    print_debug("send memory data (%s@%s):%s\n", name.c_str(), dev_id.c_str(), data.c_str());
    assert(false);
  }
  
  /**
   * 
   */
  void load(const std::vector<std::string>& args) {
    // Setup virtual-memory.
    vmemory.set_loading(Convert::vpid2str(in_pid), true);
    // Setup virtual machine.
    // Library is empty because don't use in loader.
    std::vector<void*> libs;
    std::map<std::string, std::string> lib_filter;
    std::map<std::string, std::pair<builtin_func_t, BuiltinFuncParam>> builtin_funcs;
    std::unique_ptr<Process> proc(Process::alloc(*this, in_pid, JOIN_WAIT_ROOT,
						 libs, lib_filter, builtin_funcs));
    proc->setup();
    
    // Load program from LLVM-IR file.
    LlvmAsmLoader loader(*proc);
    loader.load_file(pool_path + Convert::vpid2str(in_pid) + ".ll");

    std::map<std::string, std::string> envs;
    // Run virtual machine for bind argument and environment variables.
    proc->run(args, envs);

    proc->get_thread(proc->root_tid).write();


    // Copy output information.
    out_root_tid = proc->root_tid;
    
    // Write out data to memory.
    proc->proc_memory->write_out();
      
    // Dump and write to file.
    picojson::object body;
    body.insert(std::make_pair("pid", Convert::vpid2json(in_pid)));

    picojson::array js_machine;
    {
      picojson::object packet;
      packet.insert(std::make_pair("cmd", picojson::value(std::string("warp"))));
      packet.insert(std::make_pair("pid", Convert::vpid2json(in_pid)));
      packet.insert(std::make_pair("root_tid", Convert::vtid2json(proc->root_tid)));
      packet.insert(std::make_pair("proc_addr", Convert::vaddr2json(proc->addr)));
      packet.insert(std::make_pair("master_device", Convert::devid2json(DEV_SERVER)));
      packet.insert(std::make_pair("name", picojson::value(in_name)));
      packet.insert(std::make_pair("tid", Convert::vtid2json(proc->root_tid)));
      packet.insert(std::make_pair("dst_device", Convert::devid2json(in_dst_device)));
      packet.insert(std::make_pair("src_device", Convert::devid2json(in_src_device)));
      packet.insert(std::make_pair("src_account", picojson::value(in_src_account)));
      js_machine.push_back(picojson::value(picojson::value(packet).serialize()));
    }
    body.insert(std::make_pair("machine_data", picojson::value(js_machine)));

    picojson::array js_memory;
    for (auto& it : vmemory.get_space(Convert::vpid2str(in_pid)).pages) {
      // Don't export builtin variables.
      if (proc->builtin_addrs.find(it.first) != proc->builtin_addrs.end()) continue;
      
      picojson::object packet;
      packet.insert(std::make_pair("cmd", picojson::value(std::string("give"))));
      packet.insert(std::make_pair("addr", Convert::vaddr2json(it.first)));
      packet.insert(std::make_pair("value", Convert::bin2json(it.second.value)));
      packet.insert(std::make_pair("src", Convert::devid2json(DEV_SERVER)));
      packet.insert(std::make_pair("dst", Convert::devid2json(in_dst_device)));
      packet.insert(std::make_pair("hint", picojson::value(picojson::array())));
      js_memory.push_back(picojson::value(picojson::value(packet).serialize()));
    }
    body.insert(std::make_pair("memory_data", picojson::value(js_memory)));

    std::ofstream ofs(pool_path + Convert::vpid2str(in_pid) + ".out");
    ofs << picojson::value(body).serialize();
  }
};
  
int main(int argc, char* argv[]) {
  // Read stdin and separate by '\0'.
  std::string line;
  picojson::object result;

  while(std::getline(std::cin, line, '\0')) {
    // Convert json string to picojson instance.
    picojson::value v;
    std::istringstream is(line);
    std::string err = picojson::parse(v, is);
    if (!err.empty()) {
      std::cerr << err << std::endl;
      exit(EXIT_FAILURE);
    }
    result = v.get<picojson::object>();
    
    try {
      // Make loader.
      Loader loader;
      // Read information from json.
      loader.in_pid        = Convert::json2vpid(result.at("pid"));
      loader.in_name       = result.at("name").get<std::string>();
      loader.in_dst_device = Convert::json2devid(result.at("dst_device"));
      loader.in_src_device = Convert::json2devid(result.at("src_device"));
      loader.in_src_account = result.at("src_account").get<std::string>();
      
      // Convert arguments.
      std::vector<std::string> args;
      for (auto& it : result.at("args").get<picojson::array>()) {
	args.push_back(it.get<std::string>());
      }
      // Load.
      loader.load(args);
    
      // Show result.
      result.insert(std::make_pair("result",    picojson::value(0.0)));
      result.insert(std::make_pair("root_tid",  Convert::vtid2json(loader.out_root_tid)));
      
      std::cout << picojson::value(result).serialize() << '\0';
    
    } catch(const Error& ex) {
      // Show error information.
      result.insert(std::make_pair("result",    picojson::value(-1.0)));
      result.insert(std::make_pair("reason",    picojson::value(std::to_string(ex.reason))));
      result.insert(std::make_pair("message",   picojson::value(ex.mesg)));
      result.insert(std::make_pair("llvm_version",
				   picojson::value(std::string(LLVM_VERSION_STRING))));
      std::cout << picojson::value(result).serialize() << '\0';
      
    } catch(const std::exception& ex) {
      // Show error information.
      result.insert(std::make_pair("result",    picojson::value(-1.0)));
      result.insert(std::make_pair("reason",    picojson::value(std::to_string(-1))));
      result.insert(std::make_pair("message",   picojson::value(std::string(ex.what()))));
      result.insert(std::make_pair("llvm_version",
				   picojson::value(std::string(LLVM_VERSION_STRING))));
      std::cout << picojson::value(result).serialize() << '\0';
      
    } catch(...) {
      int errsv = errno;
      // Show error information.
      result.insert(std::make_pair("result",    picojson::value(-1.0)));
      result.insert(std::make_pair("reason",    picojson::value(std::to_string(-2))));
      result.insert(std::make_pair("message",   picojson::value(std::string(std::strerror(errsv)))));
      result.insert(std::make_pair("llvm_version",
				   picojson::value(std::string(LLVM_VERSION_STRING))));
      std::cout << picojson::value(result).serialize() << '\0';
    }
  }

  return 0;
}
