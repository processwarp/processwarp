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

using namespace processwarp;

static const std::string pool_path("/tmp/");

/**
 * Load program from LLVM-IR and write dump file.
 */
class Loader : public ProcessDelegate {
public:
  /// Assigned process-id.
  const vpid_t pid;
  /// Assigned thread-id.
  const vtid_t tid;
  
  /**
   * Constructor with assined id.
   * @param _pid Assigned process-id.
   * @param _tid Assigned thread-id.
   */
  Loader(const vpid_t& _pid, const vtid_t& _tid) :
    pid(_pid),
    tid(_tid) {
  }

  /**
   * Must not return thread-id.
   * Because only root thread need for loading.
   */
  vtid_t assign_tid(Process& vm) override {
    assert(false);
    return 0;
  }

  /**
   */
  VMemory::Accessor assign_accessor();
  
  /**
   * 
   */
  void load(const std::vector<std::string>& args) {
    // Setup virtual machine.
    // Library is empty because don't use in loader.
    std::vector<void*> libs;
    std::map<std::string, std::string> lib_filter;
    Process proc(*this, pid, tid, libs, lib_filter);
    proc.setup();
    
    // Load program from LLVM-IR file.
    LlvmAsmLoader loader(proc);
    loader.load_file(pool_path + Convert::vpid2str(pid) + ".ll");

    std::map<std::string, std::string> envs;
    // Run virtual machine for bind argument and environment variables.
    proc.run(args, envs);
      
    // Dump and write to file.
    Convert convert(proc);
    Convert::Related related;
    picojson::object body;
    picojson::object dump;
    picojson::object threads;
    body.insert(std::make_pair("cmd", picojson::value(std::string("warp"))));
    body.insert(std::make_pair("pid", Convert::vpid2json(pid)));
    for (auto& it : proc.threads) {
      threads.insert(std::make_pair(Convert::vtid2str(it.first),
				    convert.export_thread(*it.second, related)));
    }
    body.insert(std::make_pair("threads", picojson::value(threads)));
    /*
    std::set<vaddr_t> all = proc.vmemory.get_alladdr();
    for (auto it = all.begin(); it != all.end(); it ++) {
      // Don't export NULL.
      if (*it == VADDR_NULL || *it == VADDR_NON) continue;
      // Don't export builtin variables.
      if (proc.builtin_addrs.find(*it) != proc.builtin_addrs.end()) continue;
	
      dump.insert(std::make_pair(Util::vaddr2str(*it), convert.export_store(*it, related)));
    }
    body.insert(std::make_pair("dump", picojson::value(dump)));
    */
    std::ofstream ofs(pool_path + Convert::vpid2str(pid) + ".out");
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
      // Get pid.
      vpid_t pid = Convert::json2vpid(result.at("pid"));
      // Get tid.
      vtid_t tid = Convert::json2vtid(result.at("tid"));
      // Make loader.
      Loader loader(pid, tid);
      
      // Convert arguments.
      std::vector<std::string> args;
      for (auto& it : result.at("args").get<picojson::array>()) {
	args.push_back(it.get<std::string>());
      }
      // Load.
      loader.load(args);
    
      // Show result.
      result.insert(std::make_pair("result",    picojson::value(0.0)));
      std::cout << picojson::value(result).serialize() << '\0';
    
    } catch(const Error& ex) {
      // Show error information.
      result.insert(std::make_pair("result",    picojson::value(-1.0)));
      result.insert(std::make_pair("reason",    picojson::value(std::to_string(ex.reason))));
      result.insert(std::make_pair("message",   picojson::value(ex.mesg)));
      std::cout << picojson::value(result).serialize() << '\0';
      
    } catch(const std::exception& ex) {
      // Show error information.
      result.insert(std::make_pair("result",    picojson::value(-1.0)));
      result.insert(std::make_pair("reason",    picojson::value(std::to_string(-1))));
      result.insert(std::make_pair("message",   picojson::value(std::string(ex.what()))));
      std::cout << picojson::value(result).serialize() << '\0';
      
    } catch(...) {
      int errsv = errno;
      // Show error information.
      result.insert(std::make_pair("result",    picojson::value(-1.0)));
      result.insert(std::make_pair("reason",    picojson::value(std::to_string(-2))));
      result.insert(std::make_pair("message",   picojson::value(std::string(std::strerror(errsv)))));
      std::cout << picojson::value(result).serialize() << '\0';
    }
  }

  return 0;
}
