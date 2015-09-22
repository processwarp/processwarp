
#include <dlfcn.h>
#include <getopt.h>

#include <cstdlib>
#include <fstream>
#include <iostream>
#include <map>
#include <regex>
#include <string>
#include <vector>

#include "lib/picojson.h"

#include "socketio.hpp"
#include "error.hpp"
#include "vmachine.hpp"
#include "vmemory.hpp"

namespace processwarp {

class Main :
      public VMachineDelegate,
      public VMemoryDelegate,
      public SocketIoDelegate {
 public:
  /** Configuration */
  const picojson::object conf;
  /** Connection by SocketIO. */
  SocketIo socket;
  /** Login account. */
  std::string account;
  /** Device name. */
  std::string device_name;
  /** Device ID. */
  dev_id_t device_id;
  /** Virtual machine. */
  std::unique_ptr<VMachine> vm;

  /** Dynamic link libraries. */
  std::vector<void*> libs;
  /** Map of API name call from and call for that can access. */
  std::map<std::string, std::string> lib_filter;

  /** List of process and threads. */
  std::vector<ProcessTree> procs;

  /** Map of device-id and device-name. */
  std::map<dev_id_t, std::string> devices;

  /**
   * Constructor.
   * @param conf_ Configuration.
   */
  explicit Main(const picojson::object& conf_) :
      conf(conf_),
      socket(*this) {
  }

  /**
   * Load applications list on configure file and command line argument.
   */
  void load_apps() {
    if (conf.find("apps") == conf.end()) return;
    const picojson::array& apps = conf.at("apps").get<picojson::array>();

    for (auto it : apps) {
      const picojson::object& app = it.get<picojson::object>();
      // Check application type.
      if (app.find("type") != app.end() &&
          app.at("type").get<std::string>() != "llvm") {
        throw_error_message(Error::CONFIGURE, "Unknown application type.");
      }

      // Get name from filename.
      if (app.find("file") == app.end()) {
        throw_error_message(Error::CONFIGURE,
                            "Unrecognizable application file.");
      }
      std::string name;
      std::smatch match;
      if (regex_search(app.at("file").get<std::string>(),
                       match, std::regex("[^\\\\/]*$"))) {
        name = match.str();

      } else {
        assert(false);
      }

      // Load file.
      std::ifstream ifs(app.at("file").get<std::string>());
      if (!ifs.is_open()) {
        throw_error_message(Error::CONFIGURE,
                            "Unrecognizable application file.");
      }
      std::stringstream file;
      std::string line;
      while (std::getline(ifs, line, '\n')) {
        file << line << '\n';
      }
      ifs.close();

      // Get args.
      std::vector<std::string> args;
      args.push_back(app.at("file").get<std::string>());
      if (app.find("args") != app.end()) {
        for (auto& it : app.at("args").get<picojson::array>()) {
          args.push_back(it.get<std::string>());
        }
      }

      // Search device.
      dev_id_t dst_device_id;
      if (app.find("device") == app.end()) {
        dst_device_id = device_id;

      } else {
        std::string device_name = app.at("device").get<std::string>();
        for (auto it : devices) {
          if (it.second == device_name) {
            dst_device_id = it.first;
            break;
          }
        }
        if (dst_device_id.empty()) {
          throw_error_message(Error::CONFIGURE, "Unknown device name.");
        }
      }

      // Send request.
      socket.send_load_llvm(name, file.str(), args, dst_device_id);
    }
  }

  // Call when send data to other device.
  void send_machine_data(const vpid_t& pid,
                         const dev_id_t& dst,
                         const std::string& data) override {
    socket.send_machine_data(pid, dst, data);
  }

  // Call when change process and thread status running on this virtual machine.
  void send_sync_proc_list(const std::vector<ProcessTree>& procs) override {
    socket.send_sync_proc_list(procs);
  }

  void send_memory_data(const std::string& name,
                        const dev_id_t& dst,
                        const std::string& data) override {
    socket.send_memory_data(name, dst, data);
  }

  // Call when context switch of process.
  /*
    void on_switch_proccess(const std::string& pid) override {
    }
  //*/

  // Call when rise error.
  void on_error(const vpid_t& pid, const std::string& message) override {
    print_debug("error(%s) : %s\n", pid.c_str(), message.c_str());
  }

  /**
   * Call when memory is update by other node.
   * Relay event to instance of virtual-machine.
   */
  void on_recv_update(const std::string& name, vaddr_t addr) override {
    if (vm.get() != nullptr) {
      vm->on_recv_update(Convert::str2vpid(name), addr);
    }
  }

  // Call when new process is arrive.
  bool judge_new_process(const std::string& name,
                         const dev_id_t& src_device,
                         const std::string& src_account) override {
    if (src_device == DEV_SERVER ||
        src_account == account) {
      return true;

    } else {
      return false;
    }
  }

  // Call when get login account information.
  std::string get_account() override {
    return account;
  }

  // Call when system error on server.
  void recv_sys_error(int code) override {
    throw_error(Error::SERVER_SYS);
  }

  // Call when application error on server.
  void recv_app_error(int code) override {
    throw_error(Error::SERVER_APP);
  }

  // Call when recv login message from server.
  void recv_login(int result) override {
    if (result != 0) {
      throw_error(Error::SERVER_APP);
    }
    socket.send_list_device();
  }

  // Call when recv list device message from server.
  void recv_list_device
  (int result, const std::map<dev_id_t, std::string>& devices) override {
    if (result != 0) {
      throw_error(Error::SERVER_APP);
    }

    // Keep last devices.
    this->devices = devices;

    bool is_new_device = true;
    for (auto it : devices) {
      if (it.second == device_name) {
        is_new_device = false;
        socket.send_bind_device(it.first, it.second);
        break;
      }
    }

    if (is_new_device) {
      socket.send_bind_device("", device_name);
    }
  }

  // Call when recv bind device message from server.
  void recv_bind_device(int result, const dev_id_t& device_id) override {
    if (result != 0) {
      throw_error(Error::SERVER_APP);
    }

    this->device_id = device_id;
    this->vm.reset(new VMachine(*this, *this, device_id, libs, lib_filter));
    this->vm->setup_builtin();

    // Syncronize processes empty
    // because processes not running just run program.
    vm->update_proc_list();

    // Execute applications.
    load_apps();
  }

  // Call when recv sync proc list message from server.
  void recv_sync_proc_list(const std::vector<ProcessTree>& procs) override {
    this->procs = procs;
    vm->recv_sync_proc_list(procs);
  }

  // Call when recv warp data from warp source device.
  void recv_machine_data(const vpid_t& pid,
                         const dev_id_t& src,
                         const dev_id_t& dst,
                         const std::string& data) override {
    if (dst == device_id ||
        (dst == DEV_BROADCAST && src != device_id)) {
      assert(src != device_id);
      vm->recv_machine_data(pid, data);
    }
  }

  void recv_memory_data(const std::string& name,
                        const dev_id_t& src,
                        const dev_id_t& dst,
                        const std::string& data) override {
    if (dst == device_id ||
        (dst == DEV_BROADCAST && src != device_id)) {
      assert(src != device_id);
      vm->vmemory.recv_memory_data(name, data);
    }
  }

  // Recv console for test.
  void recv_test_console(const vpid_t& pid,
                         const std::string& dev,
                         const std::string& payload,
                         const dev_id_t& from_device_id) override {
#ifndef NDEBUG
    if (dev == "stdout") {
      std::cout << payload;
    } else {
      std::cerr << payload;
    }
#endif
  }

  void init(const picojson::object& conf) {
    // Load dynamic link libraries.
    if (conf.find("libs") != conf.end()) {
      const picojson::array& lib_paths = conf.at("libs").get<picojson::array>();
      for (auto lib : lib_paths) {
        void* dl_handle = dlopen(lib.get<std::string>().c_str(), RTLD_LAZY);
        if (!dl_handle) {
          throw_error_message(Error::EXT_LIBRARY, dlerror());
        }
        libs.push_back(dl_handle);
      }
    }

    // Load api filter.
    if (conf.find("lib-filter") != conf.end()) {
      const picojson::array& filter_files =
          conf.at("lib-filter").get<picojson::array>();
      for (auto filter : filter_files) {
        std::ifstream ifs(filter.get<std::string>());
        if (!ifs.is_open()) {
          throw_error_message(Error::CONFIGURE, filter.get<std::string>());
        }
        picojson::value v;
        std::string err = picojson::parse(v, ifs);
        ifs.close();
        if (!err.empty()) {
          throw_error_message(Error::CONFIGURE, err);
        }

        picojson::object& o = v.get<picojson::object>();
        for (auto& it : o) {
          lib_filter.insert(std::make_pair(it.first,
                                           it.second.get<std::string>()));
        }
      }
    }

    // Get device-name.
    device_name = conf.at("device-name").get<std::string>();
    account = conf.at("account").get<std::string>();

    // Connect to server by using Socket.IO.
    socket.connect(conf.at("server").get<std::string>());
    socket.send_login(account,
                      conf.at("password").get<std::string>());
  }

  void run() {
    init(conf);
#ifndef NDEBUG
    bool is_run_app = false;
#endif

    // Loop befor login.
    while (vm.get() == nullptr) {
      socket.pool();
    }

    // Main loop.
    while (true) {
#ifndef NDEBUG
      // Stop program when application is not running on test.
      if (getenv("TEST") != nullptr) {
        if (procs.size() != 0) {
          is_run_app = true;
        }
        if (is_run_app && procs.size() == 0) {
          break;
        }
      }
#endif
      socket.pool();
      vm->loop();
    }
  }
};

void show_usage(std::ostream& stream, const std::string& command) {
  stream <<
      "Usage : " << command <<
      " [OPTION].. [-- application argument]..." <<
      std::endl <<
      "" <<
      std::endl <<
      "Options:" <<
      std::endl <<
      "  -c, --config FILENAME    read configurations from FILENAME." <<
      std::endl <<
      "  -d, --device DEVICENAME  set DEVICENAME to device name." <<
      std::endl <<
      "  -h, --help               display this help and exit." <<
      std::endl <<
      "  -l, --llvm FILENAME      " <<
      "read FILENAME as LLVM-IR file and execute it." <<
      std::endl << std::endl;
}
}  // namespace processwarp

/**
 * Entry point for NativeVM.
 * @return return code.
 */
int main(int argc, char* argv[]) {
  int opt, option_index;
  picojson::object conf;

  option long_options[] = {
    {"config", required_argument, nullptr, 'c'},
    {"llvm",   required_argument, nullptr, 'l'},
    {"device", required_argument, nullptr, 'd'},
    {"help",   no_argument,       nullptr, 'h'},
    {0, 0, 0, 0}  // terminate
  };

  // Analyse command line option using getopt.
  while ((opt = getopt_long(argc, argv, "c:l:d:h", long_options, &option_index))
         != -1) {
    switch (opt) {
      case 'c': {
        // Read configuration file.
        std::ifstream conf_file(optarg);
        if (!conf_file.is_open()) {
          std::cerr << "Can't open configure-file." << std::endl;
          return EXIT_FAILURE;
        }

        // Read as JSON formated file.
        picojson::value v;
        std::string err = picojson::parse(v, conf_file);
        conf_file.close();
        if (!err.empty()) {
          std::cerr << err << std::endl;
          goto on_error;
        }
        conf = v.get<picojson::object>();
      } break;

      case 'l': {
        // Make 'apps' directive if don't exist yet.
        if (conf.find("apps") == conf.end()) {
          conf.insert(std::make_pair("apps",
                                     picojson::value(picojson::array())));
        }
        // Make per application directive in 'apps' directive.
        picojson::object app;
        app.insert(std::make_pair("type",
                                  picojson::value(std::string("llvm"))));
        app.insert(std::make_pair("file",
                                  picojson::value(std::string(optarg))));
        app.insert(std::make_pair("args",
                                  picojson::value(picojson::array())));

        picojson::array& apps = conf.at("apps").get<picojson::array>();
        apps.push_back(picojson::value(app));
      } break;

      case 'd': {
        if (conf.find("apps") == conf.end()) goto on_error;
        picojson::array& apps = conf.at("apps").get<picojson::array>();

        for (auto& it : apps) {
          picojson::object& app = it.get<picojson::object>();
          if (app.find("device") == app.end()) {
            app.insert(std::make_pair("device",
                                      picojson::value(std::string(optarg))));
          }
        }
      } break;

      case 'h': {
        // Show help
        processwarp::show_usage(std::cout, argv[0]);
        return EXIT_SUCCESS;
      } break;

      case ':':
      case '?': {
        std:: cerr <<
            "Unknown or required argument option -" <<
            opt << std::endl;
        goto on_error;
      } break;
    }
  }

  // Deal with after '--' options for last listed application.
  for (int i = optind; i < argc; i ++) {
    if (conf.find("apps") == conf.end()) goto on_error;
    picojson::array& apps = conf.at("apps").get<picojson::array>();
    if (apps.size() == 0) goto on_error;
    // Get 'arg' directive and push options.
    picojson::object& app = apps.back().get<picojson::object>();
    if (app.find("args") == app.end()) {
      app.insert(std::make_pair("args", picojson::value(picojson::array())));
    }
    picojson::array& args = app.at("args").get<picojson::array>();
    args.push_back(picojson::value(std::string(argv[i])));
  }

  { // Run.
    processwarp::Main THIS(conf);
    THIS.run();

    // Finish
    return EXIT_SUCCESS;
  }

on_error:
  processwarp::show_usage(std::cerr, argv[0]);
  return EXIT_FAILURE;
}
