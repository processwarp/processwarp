
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
	       [&](sio::event& event) {                                 \
		 print_debug("recv : %s\n", _name);			\
		 std::lock_guard<std::mutex> guard(sio_mutex);		\
		 sio_queue.push(make_pair(_name, event.get_message())); \
	       });							\
  }
  
  M_BIND_SOCKETIO_EVENT("sys_error");
  M_BIND_SOCKETIO_EVENT("app_error");
  M_BIND_SOCKETIO_EVENT("login");
  M_BIND_SOCKETIO_EVENT("list_device");
  M_BIND_SOCKETIO_EVENT("bind_device");
  M_BIND_SOCKETIO_EVENT("sync_proc_list");
  M_BIND_SOCKETIO_EVENT("machine_data");
  M_BIND_SOCKETIO_EVENT("memory_data");
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
      std::vector<ProcessTree> procs;

      for (auto& it_proc : data->get_vector()) {
	ProcessTree proc;
	
	proc.pid  = get_pid_by_map(it_proc, "pid");
	proc.name = get_str_by_map(it_proc, "name");

	auto& threads = it_proc->get_map().at("threads")->get_map();
	for (auto& it_thread : threads) {
	  proc.threads.insert(std::make_pair
			      (Convert::str2vtid(it_thread.first),
			       Convert::str2devid(it_thread.second->get_string())));
	}
	procs.push_back(proc);
	
      }
      delegate.recv_sync_proc_list(procs);

    } else if (name == "machine_data") {
      delegate.recv_machine_data(get_pid_by_map(data, "pid"),
				 get_dev_id_by_map(data, "src"),
				 get_dev_id_by_map(data, "dst"),
				 get_str_by_map(data, "data"));
      
    } else if (name == "memory_data") {
      delegate.recv_memory_data(get_str_by_map(data, "name"),
				get_dev_id_by_map(data, "src"),
				get_dev_id_by_map(data, "dst"),
				get_str_by_map(data, "data"));

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
void SocketIo::send_sync_proc_list(const std::vector<ProcessTree>& procs) {
  auto sio_procs(sio::array_message::create());
  auto& procs_vector = sio_procs->get_vector();

  for (auto& it_proc : procs) {
    auto sio_proc(sio::object_message::create());
    auto& proc_map = sio_proc->get_map();
    auto sio_threads(sio::object_message::create());
    auto& threads_map = sio_threads->get_map();

    proc_map.insert(std::make_pair("pid", get_sio_by_pid(it_proc.pid)));
    proc_map.insert(std::make_pair("name", sio::string_message::create(it_proc.name)));
    proc_map.insert(std::make_pair("threads", sio_threads));

    for (auto& it_thread : it_proc.threads) {
      threads_map.insert(std::make_pair(Convert::vtid2str(it_thread.first),
					get_sio_by_dev_id(it_thread.second)));
    }

    procs_vector.push_back(sio_proc);
  }
  
  socket->emit("sync_proc_list", sio_procs);
}

// Send virtual-machine data packet.
void SocketIo::send_machine_data(const vpid_t& pid,
				 const dev_id_t& dst,
				 const std::string& data) {
  sio::message::ptr sio_data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = sio_data->get_map();

  map.insert(std::make_pair("pid", get_sio_by_pid(pid)));
  map.insert(std::make_pair("dst", get_sio_by_dev_id(dst)));
  map.insert(std::make_pair("data", get_sio_by_str(data)));

  socket->emit("machine_data", sio_data);
}

// Send virtual-memory data packet.
void SocketIo::send_memory_data(const std::string& name,
				const dev_id_t& dst,
				const std::string& data) {
  sio::message::ptr sio_data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = sio_data->get_map();
  
  map.insert(std::make_pair("name", get_sio_by_str(name)));
  map.insert(std::make_pair("dst", get_sio_by_dev_id(dst)));
  map.insert(std::make_pair("data", get_sio_by_str(data)));

  socket->emit("memory_data", sio_data);
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
