
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

#include <dlfcn.h>
#include <getopt.h>

#include "lib/picojson.h"

#include "controller.hpp"
#include "socketio.hpp"
#include "error.hpp"

using namespace processwarp;

class NativeVm : public ControllerDelegate, public SocketIoDelegate {
public:
  Controller controller;
  SocketIo socket;

  /** Device name. */
  std::string device_name;
  /** Device ID. */
  std::string device_id;
  
  /** Dynamic link libraries. */
  std::vector<void*> libs;

  /** Map of pid and program name. */
  std::map<std::string, std::string> procs;

  /**
   * Constructor
   */
  NativeVm() :
    controller(*this),
    socket(*this) {
  }
  
  // Call when send data to other device.
  void send_warp_data(const std::string& pid,
		      const std::string& tid,
		      const std::string& dst_device_id,
		      const std::string& data) override {
    socket.send_warp_data_1(pid, tid, dst_device_id, data);
  }
    
  // Call when context switch of process.
  /*
  void on_switch_proccess(const std::string& pid) override {
  }
  //*/
  
  // Call when process was finish.
  void on_finish_proccess(const std::string& pid) override {
    procs.erase(pid);

    std::map<std::string, SocketIoProc> sio_procs;
    for (auto it : procs) {
      SocketIoProc sio_proc;
      sio_proc.pid  = it.first;
      sio_proc.name = it.second;
      sio_proc.threads.insert(make_pair("1", device_id));

      sio_procs.insert(std::make_pair(sio_proc.pid, sio_proc));
    }

    print_debug("(s)\n");
    for (auto it : sio_procs) {
      print_debug("pid:%s\n  pid:%s\n  name:%s\n",
		  it.first.c_str(), it.second.pid.c_str(), it.second.name.c_str());
      for (auto it2 : it.second.threads) {
	print_debug("    %s : %s\n", it2.first.c_str(), it2.second.c_str());
      }
    }

    socket.send_sync_proc_list(sio_procs);
  }

  // Call when rise error.
  void on_error(const std::string& pid, const std::string& message) override {
    print_debug("error(%s) : %s\n", pid.c_str(), message.c_str());
    on_finish_proccess(pid);
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
    socket.send_list_device();
  }

  // Call when recv list device message from server.
  void recv_list_device(int result,
			const std::map<std::string, std::string>& devices) override {
    if (result != 0) {
      throw_error(Error::SERVER_APP);
    }

    bool is_new_device = true;
    for(auto it : devices) {
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
  void recv_bind_device(int result, const std::string& device_id) override {
    if (result != 0) {
      throw_error(Error::SERVER_APP);
    }

    this->device_id = device_id;

    // Syncronize processes empty because processes not running just run program.
    socket.send_sync_proc_list(std::map<std::string, SocketIoProc>());
  }

  // Call when recv sync proc list message from server.
  void recv_sync_proc_list(const std::map<std::string, SocketIoProc>& new_procs) override {
    print_debug("(r)\n");
    for (auto it : new_procs) {
      print_debug("pid:%s\n  pid:%s\n  name:%s\n",
		  it.first.c_str(), it.second.pid.c_str(), it.second.name.c_str());
      for (auto it2 : it.second.threads) {
	print_debug("    %s : %s\n", it2.first.c_str(), it2.second.c_str());
      }
    }
    
    // Check finished process.
    auto it = procs.begin();
    while (it != procs.end()) {
      if (new_procs.find(it->first) == new_procs.end()) {
	// Delete proccess if not exit in server's proccess list.
	controller.delete_process(it->first);
	it = procs.erase(it);

      } else {
	it ++;
      }
    }

    // Update process list.
    for (auto it : new_procs) {
      if (procs.find(it.first) == procs.end()) {
	procs.insert(std::make_pair(it.first, it.second.name));

      } else {
	procs.at(it.first) = it.second.name;
      }
    }
  }

  // Call when recv warp request from other device.
  void recv_warp_request_0(const std::string& pid,
			   const std::string& tid,
			   const std::string& dst_device_id,
			   const std::string& to_device_id) override {
    // Not to me.
    if (to_device_id != device_id) return;

    if (procs.find(pid) == procs.end()) return;

    socket.send_warp_request_1(pid, tid, dst_device_id);
  }

  // Call when recv warp request from device that having process.
  void recv_warp_request_1(const std::string& pid,
			   const std::string& tid,
			   const std::string& name,
			   const std::string& from_account,
			   const std::string& from_device_id,
			   const std::string& to_device_id) override {
    // Not to me.
    if (to_device_id != device_id) return;

    if (from_account == "") {
      // Accept from the same account.
      socket.send_warp_request_2(pid, tid, from_device_id, 0);
      procs.insert(std::make_pair(pid, name));
      controller.create_process(pid, libs);

    } else {
      // Deny from other account.
      socket.send_warp_request_2(pid, tid, from_device_id, -111);
    }
  }

  // Call when recv warp acception from warp destination device.
  void recv_warp_request_2(const std::string& pid,
			   const std::string& tid,
			   const std::string& from_device_id,
			   const std::string& to_device_id,
			   int result) override {
    // Not to me.
    if (to_device_id != device_id) return;
    
    if (result == 0) {
      controller.warp_process(pid, from_device_id);

    } else {
      fixme("Ouutput log & ignore?");
    }
  }

  // Call when recv warp data from warp source device.
  void recv_warp_data_1(const std::string& pid,
			const std::string& tid,
			const std::string& from_device_id,
			const std::string& to_device_id,
			const std::string& payload) override {
    // Not to me.
    if (to_device_id != device_id) return;

    socket.send_warp_data_2(pid,
			    tid,
			    from_device_id,
			    controller.recv_warp_data(pid, tid, payload) ? 0 : -111);
  }

  // Call when recv warp data from warp destination device.
  void recv_warp_data_2(const std::string& pid,
			const std::string& tid,
			const std::string& to_device_id,
			int result) override {
    // Do nothing.
  }

  // Call when process was killed.
  void recv_exit_process(const std::string& pid) override {
    controller.exit_process(pid);
  }

  // Recv console for test.
  void recv_test_console(const std::string& pid,
			 const std::string& dev,
			 const std::string& payload,
			 const std::string& from_device_id) {
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
  
    // Get device-name.
    device_name = conf.at("device-name").get<std::string>();
  
    // Connect to server by using Socket.IO.
    socket.connect(conf.at("server").get<std::string>());
    socket.send_login(conf.at("account").get<std::string>(),
		      conf.at("password").get<std::string>());

    // If exist apps directive, load listuped applications.
    /*
    if (conf.find("apps") != conf.end()) {
      const picojson::array& apps = conf.at("apps").get<picojson::array>();
      
      for (auto it = apps.begin(); it != apps.end(); it ++) {
	picojson::object filename = it->get<picojson::object>();
	
	assign_vm(filename);
      }
    }
    //*/
  }

  void run(const picojson::object& conf) {
    init(conf);
    
    // Main loop
    while(true) {
#ifndef NDEBUG
      // Stop program when application is not running on test.
      /* TODO ■
      if(getenv("TEST") != nullptr &&
	 server.vms.size() != 0) {
	break;
	}//*/
#endif
      socket.pool();
      controller.loop();
    }
  }
};

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
    {0, 0, 0, 0} // terminate
  };
  
  // Analyse command line option using getopt.
  while((opt = getopt_long(argc, argv, "ac:l:", long_options, &option_index)) != -1) {
    switch(opt) {
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
	conf.insert(std::make_pair("apps", picojson::value(picojson::array())));
      }
      // Make per application directive in 'apps' directive.
      picojson::object app;
      app.insert(std::make_pair("type", picojson::value(std::string("llvm"))));
      app.insert(std::make_pair("path", picojson::value(std::string(optarg))));
      app.insert(std::make_pair("args", picojson::value(picojson::array())));
      
      picojson::array& apps = conf.at("apps").get<picojson::array>();
      apps.push_back(picojson::value(app));
    } break;

    case ':':
    case '?': {
      printf("Unknown or required argument option -%c\n", opt);
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
    NativeVm native_vm;
    native_vm.run(conf);

    // Finish
    return EXIT_SUCCESS;
  }

 on_error:
  printf("Usage : COMMAND -c path [-l path [-- ...]]\n");
  return EXIT_FAILURE;
}
