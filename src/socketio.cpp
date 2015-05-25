
#include <map>
#include <memory>

#include "error.hpp"
#include "socketio.hpp"
#include "util.hpp"

using namespace processwarp;

// Constractor with delegate.
SocketIo::SocketIo(SocketIoDelegate& _delegate) :
  delegate(_delegate) {
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
      data.reset(front.second);
      sio_queue.pop();
    }

#define M_STRING_CONVERT(K) (data->get_map().at(K).get() != nullptr ? data->get_map().at(K)->get_string() : "")
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
      std::map<std::string, std::string> devices;

      for (auto it : data->get_map().at("devices")->get_vector()) {
	devices.insert(std::make_pair(it->get_map().at("id")->get_string(),
				      it->get_map().at("name")->get_string()));
      }

      delegate.recv_list_device(data->get_map().at("result")->get_int(), devices);

    } else if (name == "bind_device") {
      //
      delegate.recv_bind_device(data->get_map().at("result")->get_int(),
				M_STRING_CONVERT("id"));

    } else if (name == "sync_proc_list") {
      std::map<std::string, SocketIoProc> procs;

      for (auto it_proc : data->get_map()) {
	SocketIoProc proc;
	
	proc.pid  = it_proc.second->get_map().at("pid")->get_string();
	proc.name = it_proc.second->get_map().at("name")->get_string();

	for (auto it_thread : it_proc.second->get_map().at("threads")->get_map()) {
	  proc.threads.insert(std::make_pair(it_thread.first,
					     it_thread.second->get_map().at("device_id")->get_string()));
	}
	procs.insert(std::make_pair(proc.pid, proc));
	
      }
      delegate.recv_sync_proc_list(procs);

    } else if (name == "warp_request_0") {
      delegate.recv_warp_request_0(M_STRING_CONVERT("pid"),
				   M_STRING_CONVERT("tid"),
				   M_STRING_CONVERT("dst_device_id"),
				   M_STRING_CONVERT("to_device_id"));

    } else if (name == "warp_request_1") {
      delegate.recv_warp_request_1(M_STRING_CONVERT("pid"),
				   M_STRING_CONVERT("tid"),
				   M_STRING_CONVERT("name"),
				   M_STRING_CONVERT("from_account"),
				   M_STRING_CONVERT("from_device_id"),
				   M_STRING_CONVERT("to_device_id"));

    } else if (name == "warp_request_2") {
      print_debug("warp_request_2 : %p\n", &*data->get_map().at("result"));
      delegate.recv_warp_request_2(M_STRING_CONVERT("pid"),
				   M_STRING_CONVERT("tid"),
				   M_STRING_CONVERT("from_device_id"),
				   M_STRING_CONVERT("to_device_id"),
				   data->get_map().at("result")->get_int());

    } else if (name == "warp_data_1") {
      delegate.recv_warp_data_1(M_STRING_CONVERT("pid"),
				M_STRING_CONVERT("tid"),
				M_STRING_CONVERT("from_device_id"),
				M_STRING_CONVERT("to_device_id"),
				*data->get_map().at("payload")->get_binary());
      
    } else if (name == "warp_data_2") {
      delegate.recv_warp_data_2(M_STRING_CONVERT("pid"),
				M_STRING_CONVERT("tid"),
				M_STRING_CONVERT("to_device_id"),
				data->get_map().at("result")->get_int());
      
    } else if (name == "exit_process") {
      delegate.recv_exit_process(data->get_map().at("pid")->get_string());

    } else {
      assert(false);
    }

#undef M_STRING_CONVERT
  }
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
void SocketIo::send_bind_device(const std::string& id,
		      const std::string& name) {
  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();

  if (id.length() != 0) {
    map.insert(std::make_pair("id", sio::string_message::create(id)));
  }
  map.insert(std::make_pair("name", sio::string_message::create(name)));

  socket->emit("bind_device", data);
}

// Send process list for synchronize.
void SocketIo::send_sync_proc_list(const std::map<std::string, SocketIoProc>& procs) {
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

    pmap.insert(std::make_pair("pid", sio::string_message::create(proc.pid)));
    pmap.insert(std::make_pair("name", sio::string_message::create(proc.name)));
    pmap.insert(std::make_pair("threads", threads));

    for (auto it_thread : proc.threads) {
      tmap.insert(std::make_pair("tid", sio::string_message::create(it_thread.first)));
      tmap.insert(std::make_pair("device_id", sio::string_message::create(it_thread.second)));
      pthreads.insert(std::make_pair(it_thread.first, tdata));
    }

    map.insert(std::make_pair(proc.pid, pdata));
  }
  
  socket->emit("sync_proc_list", data);
}

// Send request of trigger to warp from other device.
void SocketIo::send_warp_request_0(const std::string& pid,
				   const std::string& tid,
				   const std::string& to_device_id,
				   const std::string& dst_device_id) {
  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();

  map.insert(std::make_pair("pid", sio::string_message::create(pid)));
  map.insert(std::make_pair("tid", sio::string_message::create(tid)));
  map.insert(std::make_pair("to_device_id", sio::string_message::create(to_device_id)));
  map.insert(std::make_pair("dst_device_id", sio::string_message::create(dst_device_id)));

  socket->emit("warp_request_0", data);
}

// Send request of trigger to warp from device there running process.
void SocketIo::send_warp_request_1(const std::string& pid,
				   const std::string& tid,
				   const std::string& to_device_id) {
  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();

  map.insert(std::make_pair("pid", sio::string_message::create(pid)));
  map.insert(std::make_pair("tid", sio::string_message::create(tid)));
  map.insert(std::make_pair("to_device_id", sio::string_message::create(to_device_id)));

  socket->emit("warp_request_1", data);
}

// Send reply of trigger to warp to device there running process.
void SocketIo::send_warp_request_2(const std::string& pid,
				   const std::string& tid,
				   const std::string& to_device_id,
				   int result) {
  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();

  map.insert(std::make_pair("pid", sio::string_message::create(pid)));
  map.insert(std::make_pair("tid", sio::string_message::create(tid)));
  map.insert(std::make_pair("to_device_id", sio::string_message::create(to_device_id)));
  map.insert(std::make_pair("result", sio::int_message::create(result)));

  socket->emit("warp_request_2", data);
}

// Send binary data to virtual machine.
void SocketIo::send_warp_data_1(const std::string& pid,
				const std::string& tid,
				const std::string& to_device_id,
				const std::string& payload) {
  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();

  map.insert(std::make_pair("pid", sio::string_message::create(pid)));
  map.insert(std::make_pair("tid", sio::string_message::create(tid)));
  map.insert(std::make_pair("to_device_id", sio::string_message::create(to_device_id)));
  map.insert(std::make_pair("payload", sio::binary_message::create
			    (std::shared_ptr<const std::string>(new std::string(payload)))));

  socket->emit("warp_data_1", data);
}

// Send result binary data to virtual machine.
void SocketIo::send_warp_data_2(const std::string& pid,
				const std::string& tid,
				const std::string& to_device_id,
				int result) {
  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();

  map.insert(std::make_pair("pid", sio::string_message::create(pid)));
  map.insert(std::make_pair("tid", sio::string_message::create(tid)));
  map.insert(std::make_pair("to_device_id", sio::string_message::create(to_device_id)));
  map.insert(std::make_pair("result", sio::int_message::create(result)));

  socket->emit("warp_data_2", data);
}

// Send command of exit process.
void SocketIo::send_exit_process(const std::string& pid) {
  sio::message::ptr data(sio::object_message::create());
  std::map<std::string, sio::message::ptr>& map = data->get_map();
  
  map.insert(std::make_pair("pid", sio::string_message::create(pid)));

  socket->emit("exit_process", data);
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
