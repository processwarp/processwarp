
#include <map>
#include <memory>

#include "convert.hpp"
#include "error.hpp"
#include "socketio.hpp"
#include "util.hpp"

using namespace processwarp;

/**
 * Get string value by key from Socket.IO map.
 * @param data Pointer to Socket.IO map.
 * @param key Key in map.
 * @return Value as string in map.
 */
std::string get_str_by_map(sio::message::ptr data, std::string key, bool is_must = false) {
  if (data->get_map().find(key) == data->get_map().end()) {
    if (is_must) {
      throw_error_message(Error::PROTOCOL, key);

    } else {
      return "";
    }

  } else {
    sio::message::ptr ptr = data->get_map().at(key);
    if (ptr.get() == nullptr) {
      if (is_must) {
	throw_error_message(Error::PROTOCOL, key);

      } else {
	return "";
      }
    } else {
      return data->get_map().at(key)->get_string();
    }
  }
}

/**
 * Convert string to Socket.IO value.
 * @param str Source string value.
 * @return Socket.IO value.
 */
sio::message::ptr get_sio_by_str(const std::string& str) {
  return sio::string_message::create(str);
}

/**
 * Get process-id value by key from Socket.IO map.
 * @param data Pointer to Socket.IO map.
 * @param key Key in map.
 * @return Value as process-id in map.
 */
vpid_t get_pid_by_map(sio::message::ptr data, const std::string& key) {
  return Convert::str2vpid(get_str_by_map(data, key));
}

/**
 * Convert process-id to Socket.IO value.
 * @param pid process-id.
 * @return Socket.IO value.
 */
sio::message::ptr get_sio_by_pid(const vpid_t& pid) {
  return get_sio_by_str(Convert::vpid2str(pid));
}

/**
 * Get thread-id value by key from Socket.IO map.
 * @param data Pointer to Socket.IO map.
 * @param key Key in map.
 * @return Value as thread-id in map.
 */
vtid_t get_tid_by_map(sio::message::ptr data, const std::string& key) {
  return Convert::str2vtid(get_str_by_map(data, key));
}

/**
 * Convert thread-id to Socket.IO value.
 * @param pid thread-id.
 * @return Socket.IO value.
 */
sio::message::ptr get_sio_by_tid(vtid_t tid) {
  return get_sio_by_str(Convert::vtid2str(tid));
}

/**
 * Convert virtual-address by key from Socket.IO value.
 * @param data Pointer to Socket.IO map.
 * @param key Key in map.
 * @return Value as virtual-address in map.
 */
vaddr_t get_addr_by_map(sio::message::ptr data, const std::string& key) {
  return Convert::str2vaddr(get_str_by_map(data, key));
}

/**
 * Convert virtual-address to Socket.IO value.
 * @param addr Virtual address.
 * @return Socket.IO value.
 */
sio::message::ptr get_sio_by_addr(vaddr_t addr) {
  return get_sio_by_str(Convert::vaddr2str(addr));
}

/**
 * Get device-id value by key from Socket.IO map.
 * @param data Pointer to Socket.IO map.
 * @param key Key in map.
 * @return Value as device-id in map.
 */
dev_id_t get_dev_id_by_map(sio::message::ptr data, const std::string& key) {
  return Convert::str2devid(get_str_by_map(data, key));
}

/**
 * Convert device-id to Socket.IO value.
 * @param pid device-id.
 * @return Socket.IO value.
 */
sio::message::ptr get_sio_by_dev_id(dev_id_t dev_id) {
  return get_sio_by_str(Convert::devid2str(dev_id));
}

// Constractor with delegate.
SocketIo::SocketIo(SocketIoDelegate& _delegate) :
  delegate(_delegate) {
}

// Destructor with close Socket.IO.
SocketIo::~SocketIo() {
  client.sync_close();
  client.clear_con_listeners();
}


// Connect to server.
void SocketIo::connect(const std::string& url) {
  // Bind basic event to Socket.IO.
  client.set_close_listener(std::bind(&SocketIo::on_close, this));
  client.set_fail_listener(std::bind(&SocketIo::on_fail, this));
  client.set_open_listener(std::bind(&SocketIo::on_open, this));

  client.connect(url);
  {
    std::lock_guard<std::mutex> guard(sio_mutex);
    if (sio_status == SETUP) {
      sio_cond.wait(sio_mutex);
    }
  }
  
  if (sio_status == CONNECT) {
    socket = client.socket();

  } else {
    throw_error(Error::NETWORK);
  }

  // Bind 'on' event to Socket.IO.
#define M_BIND_SOCKETIO_EVENT(_name) {					\
    socket->on(_name,							\
	       (sio::socket::event_listener_aux) [&]			\
	       (std::string const& name, sio::message::ptr const& data,	\
		bool isAck, sio::message::ptr& ack_resp) {		\
		 print_debug("recv : %s\n", _name);			\
		 std::lock_guard<std::mutex> guard(sio_mutex);		\
		 sio_queue.push(make_pair(_name, data));		\
	       });							\
  }
  
  M_BIND_SOCKETIO_EVENT("sys_error");
  M_BIND_SOCKETIO_EVENT("app_error");
  M_BIND_SOCKETIO_EVENT("login");
  M_BIND_SOCKETIO_EVENT("list_device");
  M_BIND_SOCKETIO_EVENT("bind_device");
  M_BIND_SOCKETIO_EVENT("sync_proc_list");
  M_BIND_SOCKETIO_EVENT("warp_request_0");
  M_BIND_SOCKETIO_EVENT("warp_request_1");
  M_BIND_SOCKETIO_EVENT("warp_request_2");
  M_BIND_SOCKETIO_EVENT("warp_data_1");
  M_BIND_SOCKETIO_EVENT("warp_data_2");
  M_BIND_SOCKETIO_EVENT("exit_process");
  M_BIND_SOCKETIO_EVENT("test_console");

#undef M_BIND_SOCKETIO_EVENT
}

// Pooling
void SocketIo::pool() {
  while (true) {
    std::string name;
    sio::message::ptr data;
    {
      std::lock_guard<std::mutex> guard(sio_mutex);
      if (sio_queue.empty()) break;
      auto front = sio_queue.front();
      name = front.first;
      data = front.second;
      sio_queue.pop();
    }

    if (name == "sys_error") {
      //
      delegate.recv_sys_error(data->get_map().at("code")->get_int());

    } else if (name == "app_error") {
      //
      delegate.recv_app_error(data->get_map().at("code")->get_int());
      
    } else if (name == "login") {
      //
      delegate.recv_login(data->get_map().at("result")->get_int());
      
    } else if (name == "list_device") {
      //
      std::map<dev_id_t, std::string> devices;

      for (auto it : data->get_map().at("devices")->get_vector()) {
	devices.insert(std::make_pair(get_dev_id_by_map(it, "id"),
				      it->get_map().at("name")->get_string()));
      }

      delegate.recv_list_device(data->get_map().at("result")->get_int(), devices);

    } else if (name == "bind_device") {
      //
      delegate.recv_bind_device(data->get_map().at("result")->get_int(),
				get_dev_id_by_map(data, "id"));

    } else if (name == "sync_proc_list") {
      std::map<vpid_t, SocketIoProc> procs;

      for (auto it_proc : data->get_map()) {
	SocketIoProc proc;
	
	proc.pid  = get_pid_by_map(it_proc.second, "pid");
	proc.name = get_str_by_map(it_proc.second, "name");

	for (auto it_thread : it_proc.second->get_map().at("threads")->get_map()) {
	  proc.threads.insert(std::make_pair(Convert::str2vtid(it_thread.first),
					     get_dev_id_by_map(it_thread.second, "device_id")));
	}
	procs.insert(std::make_pair(proc.pid, proc));
	
      }
      delegate.recv_sync_proc_list(procs);

    } else if (name == "warp_request_0") {
      delegate.recv_warp_request_0(get_pid_by_map(data, "pid"),
				   get_tid_by_map(data, "tid"),
				   get_dev_id_by_map(data, "dst_device_id"),
				   get_dev_id_by_map(data, "to_device_id"));

    } else if (name == "warp_request_1") {
      delegate.recv_warp_request_1(get_pid_by_map(data, "pid"),
				   get_tid_by_map(data, "tid"),
				   get_tid_by_map(data, "root_tid"),
				   get_addr_by_map(data, "proc_addr"),
				   get_str_by_map(data, "name"),
				   get_str_by_map(data, "from_account", false),
				   get_dev_id_by_map(data, "from_device_id"),
				   get_dev_id_by_map(data, "to_device_id"));

    } else if (name == "warp_request_2") {
      print_debug("warp_request_2 : %p\n", &*data->get_map().at("result"));
      delegate.recv_warp_request_2(get_pid_by_map(data, "pid"),
				   get_tid_by_map(data, "tid"),
				   get_dev_id_by_map(data, "from_device_id"),
				   get_dev_id_by_map(data, "to_device_id"),
				   data->get_map().at("result")->get_int());

    } else if (name == "vm_data") {
      delegate.recv_vm_data(get_pid_by_map(data, "pid"),
			    get_tid_by_map(data, "tid"),
			    get_dev_id_by_map(data, "from_device_id"),
			    get_dev_id_by_map(data, "to_device_id"),
			    *data->get_map().at("payload")->get_binary());
      
    } else if (name == "memory_data") {
      delegate.recv_memory_data(get_str_by_map(data, "name"),
				get_dev_id_by_map(data, "from_device_id"),
				get_dev_id_by_map(data, "to_device_id"),
				*data->get_map().at("payload")->get_binary());
      
    } else if (name == "exit_process") {
      delegate.recv_exit_process(get_pid_by_map(data, "pid"));

    } else if (name == "test_console") {
#ifndef NDEBUG
      delegate.recv_test_console(get_pid_by_map(data, "pid"),
				 get_str_by_map(data, "dev"),
				 *data->get_map().at("payload")->get_binary(),
				 get_dev_id_by_map(data, "from_device_id"));
#endif

    } else {
      assert(false);
    }
  }
}

// Send load llvm command.
void SocketIo::send_load_llvm(const std::string& name,
			      const std::string& file,
			      const std::vector<std::string>& args,
			      const dev_id_t& dst_device_id) {
  sio::message::ptr data(sio::object_message::create());
  sio::message::ptr args_ptr(sio::array_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();
  std::vector<sio::message::ptr>& args_vtr = args_ptr->get_vector();
  
  map.insert(std::make_pair("name", sio::string_message::create(name)));
  map.insert(std::make_pair("file", sio::binary_message::create
			    (std::shared_ptr<const std::string>(new std::string(file)))));
  for (auto& arg : args) {
    args_vtr.push_back(sio::string_message::create(arg));
  }
  map.insert(std::make_pair("args", args_ptr));
  map.insert(std::make_pair("dst_device_id", get_sio_by_dev_id(dst_device_id)));
  
  socket->emit("load_llvm", data);
}

// Send login command.
void SocketIo::send_login(const std::string& account,
			  const std::string& password) {
  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();
  
  map.insert(std::make_pair("account",  sio::string_message::create(account)));
  map.insert(std::make_pair("password", sio::string_message::create(password)));
  
  socket->emit("login", data);
}

// Send request of device list.
void SocketIo::send_list_device() {
  sio::message::ptr data(sio::object_message::create());

  socket->emit("list_device", data);
}
    

// Send device bind command.
void SocketIo::send_bind_device(const dev_id_t& id,
				const std::string& name) {
  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();

  if (!id.empty()) {
    map.insert(std::make_pair("id", get_sio_by_dev_id(id)));
  }
  map.insert(std::make_pair("name", sio::string_message::create(name)));

  socket->emit("bind_device", data);
}

// Send process list for synchronize.
void SocketIo::send_sync_proc_list(const std::map<vpid_t, SocketIoProc>& procs) {
  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();

  for (auto it_proc : procs) {
    SocketIoProc& proc = it_proc.second;

    sio::message::ptr pdata(sio::object_message::create());
    std::map<std::string, sio::message::ptr>& pmap = pdata->get_map();
    sio::message::ptr tdata(sio::object_message::create());
    std::map<std::string, sio::message::ptr>& tmap = tdata->get_map();
    sio::message::ptr threads(sio::object_message::create());
    std::map<std::string, sio::message::ptr>& pthreads = threads->get_map();

    pmap.insert(std::make_pair("pid", get_sio_by_pid(proc.pid)));
    pmap.insert(std::make_pair("name", sio::string_message::create(proc.name)));
    pmap.insert(std::make_pair("threads", threads));

    for (auto it_thread : proc.threads) {
      tmap.insert(std::make_pair("tid", get_sio_by_tid(it_thread.first)));
      tmap.insert(std::make_pair("device_id", get_sio_by_dev_id(it_thread.second)));
      pthreads.insert(std::make_pair(Convert::vtid2str(it_thread.first), tdata));
    }

    map.insert(std::make_pair(Convert::vpid2str(proc.pid), pdata));
  }
  
  socket->emit("sync_proc_list", data);
}

// Send request of trigger to warp from other device.
void SocketIo::send_warp_request_0(const vpid_t& pid,
				   const vtid_t& tid,
				   const dev_id_t& to_device_id,
				   const dev_id_t& dst_device_id) {
  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();

  map.insert(std::make_pair("pid", get_sio_by_pid(pid)));
  map.insert(std::make_pair("tid", get_sio_by_tid(tid)));
  map.insert(std::make_pair("to_device_id", get_sio_by_dev_id(to_device_id)));
  map.insert(std::make_pair("dst_device_id", get_sio_by_dev_id(dst_device_id)));

  socket->emit("warp_request_0", data);
}

// Send request of trigger to warp from device there running process.
void SocketIo::send_warp_request_1(const vpid_t& pid,
				   const vtid_t& tid,
				   const vtid_t& root_tid,
				   vaddr_t proc_addr,
				   const dev_id_t& to_device_id) {
  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();

  map.insert(std::make_pair("pid", get_sio_by_pid(pid)));
  map.insert(std::make_pair("tid", get_sio_by_tid(tid)));
  map.insert(std::make_pair("root_tid", get_sio_by_tid(root_tid)));
  map.insert(std::make_pair("proc_addr", get_sio_by_addr(proc_addr)));
  map.insert(std::make_pair("to_device_id", get_sio_by_dev_id(to_device_id)));

  socket->emit("warp_request_1", data);
}

// Send reply of trigger to warp to device there running process.
void SocketIo::send_warp_request_2(const vpid_t& pid,
				   const vtid_t& tid,
				   const dev_id_t& to_device_id,
				   int result) {
  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();

  map.insert(std::make_pair("pid", get_sio_by_pid(pid)));
  map.insert(std::make_pair("tid", get_sio_by_tid(tid)));
  map.insert(std::make_pair("to_device_id", get_sio_by_dev_id(to_device_id)));
  map.insert(std::make_pair("result", sio::int_message::create(result)));

  socket->emit("warp_request_2", data);
}

// Send binary data to virtual machine.
void SocketIo::send_vm_data(const vpid_t& pid,
			    const vtid_t& tid,
			    const dev_id_t& dst_device_id,
			    const std::string& payload) {
  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();

  map.insert(std::make_pair("pid", get_sio_by_pid(pid)));
  map.insert(std::make_pair("tid", get_sio_by_tid(tid)));
  map.insert(std::make_pair("to_device_id", get_sio_by_dev_id(dst_device_id)));
  map.insert(std::make_pair("payload", sio::binary_message::create
			    (std::shared_ptr<const std::string>(new std::string(payload)))));

  socket->emit("vm_data", data);
}

// Send result binary data to virtual machine.
void SocketIo::send_memory_data(const std::string& name,
				const dev_id_t& dst_device_id,
				const std::string& payload) {
  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();

  map.insert(std::make_pair("name", get_sio_by_str(name)));
  map.insert(std::make_pair("to_device_id", get_sio_by_dev_id(dst_device_id)));
  map.insert(std::make_pair("payload", sio::binary_message::create
			    (std::shared_ptr<const std::string>(new std::string(payload)))));

  socket->emit("memory_data", data);
}

// Send command of exit process.
void SocketIo::send_exit_process(const vpid_t& pid) {
  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();
  
  map.insert(std::make_pair("pid", get_sio_by_pid(pid)));

  socket->emit("exit_process", data);
}

// Send console for test.
void SocketIo::send_test_console(const vpid_t& pid,
				 const std::string& dev,
				 const std::string& payload) {
#ifndef NDEBUG
  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();
  
  map.insert(std::make_pair("pid", get_sio_by_pid(pid)));
  map.insert(std::make_pair("dev", sio::string_message::create(dev)));
  map.insert(std::make_pair("payload", sio::binary_message::create
			    (std::shared_ptr<const std::string>(new std::string(payload)))));
  
  socket->emit("test_console", data);
#endif
}

// Event listener for Socket.IO's close event.
void SocketIo::on_close() {
  std::lock_guard<std::mutex> guard(sio_mutex);
  sio_cond.notify_all();
  sio_status = CLOSE;
}

// Event listener for Socket.IO's fail event.
void SocketIo::on_fail() {
  std::lock_guard<std::mutex> guard(sio_mutex);
  sio_cond.notify_all();
  sio_status = FAIL;
}

// Event listener for Socket.IO's connect event.
void SocketIo::on_open() {
  std::lock_guard<std::mutex> guard(sio_mutex);
  sio_cond.notify_all();
  sio_status = CONNECT;
}
