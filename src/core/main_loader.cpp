
#include <picojson.h>

#include <cerrno>
#include <cstring>
#include <iostream>
#include <fstream>
#include <map>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "constant.hpp"
#include "constant_vm.hpp"
#include "convert.hpp"
#include "error.hpp"
#include "llvm_asm_loader.hpp"
#include "loader_mid.hpp"
#include "logger.hpp"
#include "logger_syslog.hpp"
#include "message.hpp"
#include "process.hpp"
#include "type.hpp"
#include "vmemory.hpp"

#ifndef LLVM_VERSION_STRING
#  define EVAL(f, v) f(v)
#  define TO_STR_HELPER(s) #s
#  define TO_STR(s) EVAL(TO_STR_HELPER, s)
#  ifdef LLVM_VERSION_PATCH
static const char* LLVM_VERSION_STRING =
  TO_STR(LLVM_VERSION_MAJOR) "."
  TO_STR(LLVM_VERSION_MINOR) "."
  TO_STR(LLVM_VERSION_PATCH);
#  else
static const char* LLVM_VERSION_STRING =
  TO_STR(LLVM_VERSION_MAJOR) "."
  TO_STR(LLVM_VERSION_MINOR);
#  endif
#  undef EVAL
#  undef TO_STR_HELPER
#  undef TO_STR
#endif

namespace processwarp {

static const char* POOL_PATH = "/tmp/";

/**
 * Load program from LLVM-IR and write a dump file.
 */
class Loader : public ProcessDelegate, public VMemoryDelegate {
 public:
  /** Virtual memory for this loader. */
  VMemory vmemory;
  /** Process-id assigned for loading process. */
  vpid_t in_pid;
  /** Application name. */
  std::string in_name;
  /** Node-id warp to after loading. */
  NodeID in_dst_nid;
  /** Node-id that issued an order to load this process. */
  NodeID in_src_nid;
  /** Account-id that issued an order to load this process. */
  std::string in_src_account;
  /** LLVM-IR type LL or BC. */
  std::string in_type;

  /** The root thread-id assigned by loader. */
  vtid_t out_root_tid;

  /**
   * Constructor, initialize virtual-memory instance.
   */
  Loader() :
      vmemory(*this, NodeID::SERVER) {
  }

  /**
   * Entry point of loader.
   * At first of loop read load instruction json by stdin stream, and launch loader instance.
   * At last of loop, write result json for stdout stream.
   * @param argc
   * @param argv
   * @return Exit code of loader.
   */
  int entry(int argc, char* argv[]) {
    // Read stdin and separate by '\0'.
    std::string line;
    picojson::object result;

    // Create logger.
    Logger::Syslog logger;
    logger.initialize("loader");
    Logger::set_logger_delegate(&logger);

    // Load messages.
    Message::load("loader_message.json");
    Logger::info(LoaderMid::L2001, std::string(LLVM_VERSION_STRING).c_str());

    while (std::getline(std::cin, line, '\0')) {
      // Convert json string to picojson instance.
      picojson::value v;
      std::string err = picojson::parse(v, line);
      if (!err.empty()) {
        Logger::err(LoaderMid::L2003, err.c_str());
      }
      result = v.get<picojson::object>();
      Logger::info(LoaderMid::L2002, line.c_str());

      try {
        // Make loader.
        Loader loader;
        // Read information from json.
        loader.in_pid  = Convert::json2vpid(result.at("pid"));
        loader.in_name = result.at("name").get<std::string>();
        loader.in_dst_nid = NodeID::from_json(result.at("dst_nid"));
        loader.in_src_nid = NodeID::from_json(result.at("src_nid"));
        loader.in_src_account = result.at("src_account").get<std::string>();
        loader.in_type        = result.at("type").get<std::string>();

        // Convert arguments.
        std::vector<std::string> args;
        for (auto& it : result.at("args").get<picojson::array>()) {
          args.push_back(it.get<std::string>());
        }
        // Load.
        loader.load(args);

        // Show result.
        result.insert(std::make_pair("result", picojson::value(0.0)));
        result.insert(std::make_pair("root_tid", Convert::vtid2json(loader.out_root_tid)));

        std::cout << picojson::value(result).serialize() << '\0';
        Logger::info(LoaderMid::L2004, 0, loader.out_root_tid);
      } catch(const Error& ex) {
        // Show error information.
        result.insert(std::make_pair("result", picojson::value(-1.0)));
        result.insert(std::make_pair("reason", picojson::value(std::to_string(ex.reason))));
        result.insert(std::make_pair("message", picojson::value(ex.mesg)));
        result.insert(std::make_pair("llvm_version",
                                     picojson::value(std::string(LLVM_VERSION_STRING))));
        std::cout << picojson::value(result).serialize() << '\0';
        Logger::warn(LoaderMid::L2005, -1, ex.reason, ex.mesg.c_str());
      } catch(const std::exception& ex) {
        // Show error information.
        result.insert(std::make_pair("result", picojson::value(-1.0)));
        result.insert(std::make_pair("reason", picojson::value(std::to_string(-1))));
        result.insert(std::make_pair("message", picojson::value(std::string(ex.what()))));
        result.insert(std::make_pair("llvm_version",
                                     picojson::value(std::string(LLVM_VERSION_STRING))));
        std::cout << picojson::value(result).serialize() << '\0';
        Logger::warn(LoaderMid::L2005, -1, -1, ex.what());
      } catch (...) {
        int errsv = errno;
        // Show error information.
        result.insert(std::make_pair("result", picojson::value(-1.0)));
        result.insert(std::make_pair("reason", picojson::value(std::to_string(-2))));
        result.insert(std::make_pair("message",
                                     picojson::value(std::string(std::strerror(errsv)))));
        result.insert(std::make_pair("llvm_version",
                                     picojson::value(std::string(LLVM_VERSION_STRING))));
        std::cout << picojson::value(result).serialize() << '\0';
        Logger::warn(LoaderMid::L2005, -1, -2, std::strerror(errsv));
      }
    }

    return 0;
  }

  /**
   * Override a delegater method that assign memory accessor for Process class.
   * Get a acccessor by VMemory class and return this instance.
   * @param pid Process-id that is use assigned accessor.
   * @return A memory accessor instance.
   */
  std::unique_ptr<VMemory::Accessor> process_assign_accessor(const vpid_t& pid) override {
    assert(!in_pid.empty());
    return vmemory.get_accessor();
  }

  /**
   * Override a delegater method that do noting.
   * @param process
   */
  void process_change_thread_set(Process& process) override {
  }

  /**
   * Override a delegter method that call when memory data was update.
   * Must not use in loader.
   * @param memory
   * @param addr
   */
  void vmemory_recv_update(VMemory& memory, vaddr_t addr) override {
    assert(false);
  }

  /**
   * Override a delegter method, but it must not use in loader.
   * @param memory
   * @param packet
   */
  void vmemory_send_packet(VMemory& memory, const Packet& packet) override {
    assert(false);
  }

  /**
   * Main routine of loader.
   * Allocate Process class instance and load LLVM-IR file.
   * At last, write dump of pages in memory to output file.
   * @param args Command line arguments for loading process.
   */
  void load(const std::vector<std::string>& args) {
    // Setup virtual-memory.
    vmemory.set_loading(true);
    // Setup virtual machine.
    // Library is empty because don't use in loader.
    std::vector<void*> libs;
    std::map<std::string, std::string> lib_filter;
    std::map<std::string,
             std::pair<builtin_func_t, BuiltinFuncParam>> builtin_funcs;
    std::unique_ptr<Process> proc(Process::alloc(*this, in_pid, JoinWaitStatus::ROOT,
                                                 libs, lib_filter,
                                                 builtin_funcs));
    proc->setup();

    // Load program from LLVM file.
    LlvmAsmLoader loader(*proc);

    if (in_type == "LL") {
      loader.load_ir_file(POOL_PATH + Convert::vpid2str(in_pid) + ".llvm");

    } else if (in_type == "BC") {
      loader.load_bc_file(POOL_PATH + Convert::vpid2str(in_pid) + ".llvm");

    } else {
      throw_error(Error::SERVER_SYS);
    }

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

    picojson::array js_sched_packet;
    {
      picojson::object content;
      content.insert(std::make_pair("pid", Convert::vpid2json(in_pid)));
      content.insert(std::make_pair("root_tid", Convert::vtid2json(proc->root_tid)));
      content.insert(std::make_pair("proc_addr", Convert::vaddr2json(proc->addr)));
      content.insert(std::make_pair("master_nid", NodeID::SERVER.to_json()));
      content.insert(std::make_pair("name", picojson::value(in_name)));
      content.insert(std::make_pair("tid", Convert::vtid2json(proc->root_tid)));
      content.insert(std::make_pair("dst_nid", in_dst_nid.to_json()));
      content.insert(std::make_pair("src_nid", in_src_nid.to_json()));
      content.insert(std::make_pair("src_account", picojson::value(in_src_account)));

      picojson::object packet;
      packet.insert(std::make_pair("packet_id", Convert::int2json(0)));
      packet.insert(std::make_pair("command", picojson::value(std::string("warp_thread"))));
      packet.insert(std::make_pair("mode",
                                   Convert::int2json(PacketMode::EXPLICIT | PacketMode::ONE_WAY)));
      packet.insert(std::make_pair("content",
                                   picojson::value(picojson::value(content).serialize())));

      js_sched_packet.push_back(picojson::value(packet));
    }
    body.insert(std::make_pair("sched_packet", picojson::value(js_sched_packet)));

    picojson::array js_memory_packet;
    for (auto& it : vmemory.pages) {
      // Don't export builtin variables.
      if (proc->builtin_addrs.find(it.first) != proc->builtin_addrs.end()) {
        continue;
      }

      picojson::object content;
      content.insert(std::make_pair("addr", Convert::vaddr2json(it.first)));
      content.insert(std::make_pair("value",
                                    Convert::bin2json(it.second.value.get(), it.second.size)));
      content.insert(std::make_pair("leader_nid", NodeID::NONE.to_json()));
      content.insert(std::make_pair("acceptor_nids", picojson::value(picojson::array())));
      content.insert(std::make_pair("hint_nids", picojson::value(picojson::array())));

      picojson::object packet;
      packet.insert(std::make_pair("packet_id", Convert::int2json(0)));
      packet.insert(std::make_pair("command", picojson::value(std::string("delegate"))));
      packet.insert(std::make_pair("mode", Convert::int2json(PacketMode::ONE_WAY)));
      packet.insert(std::make_pair("content",
                                   picojson::value(picojson::value(content).serialize())));

      js_memory_packet.push_back(picojson::value(packet));
    }
    body.insert(std::make_pair("memory_packet", picojson::value(js_memory_packet)));

    std::ofstream ofs(POOL_PATH + Convert::vpid2str(in_pid) + ".out");
    ofs << picojson::value(body).serialize();
  }
};
}  // namespace processwarp

/**
 * Entry point, call actual entry process.
 * @param argc Count of command line option.
 * @param argv Strings of command line options.
 * @return Exit status.
 */
int main(int argc, char* argv[]) {
  processwarp::Loader THIS;

  return THIS.entry(argc, argv);
}
