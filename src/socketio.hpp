#pragma once

#include <atomic>
#include <condition_variable>
#include <mutex>
#include <queue>
#include <thread>

#include <sio_client.h>

#include "definitions.hpp"

namespace processwarp {
  /**
   * Structure using to recv/send_sync_proc_list.
   */
  struct SocketIoProc {
    // pid
    vpid_t pid;
    // Root thread-id.
    vtid_t root_tid;
    // Name of process
    std::string name;
    // Map of tid and device-id.
    std::map<vtid_t, dev_id_t> threads;
  };
  
  /**
   * Delegate for SocketIo-class.
   */
  class SocketIoDelegate {
  public:
    /**
     * Destructor for virtual.
     */
    virtual ~SocketIoDelegate() {};

    /**
     * Call when system error on server.
     * @param code Error code.
     */
    virtual void recv_sys_error(int code) = 0;

    /**
     * Call when application error on server.
     * @param code Error code.
     */
    virtual void recv_app_error(int code) = 0;

    /**
     * Call when recv login message from server.
     * @param result Set 0 when succeed or else error code when error.
     */
    virtual void recv_login(int result) = 0;

    /**
     * Call when recv list device message from server.
     * @param result Set 0 when succeed or else error code when error.
     * @param devices Map of device-id and device-name.
     */
    virtual void recv_list_device(int result,
				  const std::map<dev_id_t, std::string>& devices) = 0;

    /**
     * Call when recv bind device message from server.
     * @param result Set 0 when succeed or else error code when error.
     * @param device_id Device id bound this device.
     */
    virtual void recv_bind_device(int result, const dev_id_t& device_id) = 0;

    /**
     * Call when recv sync proc list message from server.
     * @param procs Map of pid and SocketIoProc.
     */
    virtual void recv_sync_proc_list(const std::map<vpid_t, SocketIoProc>& procs) = 0;
    
    /**
     * Call when recv warp request from other device.
     * @param pid Target pid.
     * @param tid Target tid.
     * @param dst_device_id Warp destination device-id .
     * @param to_device_id Command destination device-id .
     */
    virtual void recv_warp_request_0(const vpid_t& pid,
				     const vtid_t& tid,
				     const dev_id_t& dst_device_id,
				     const dev_id_t& to_device_id) = 0;

    /**
     * Call when recv warp request from device that having process.
     * @param pid Target pid.
     * @param tid Target tid.
     * @param name Process name.
     * @param from_account Source account.
     * @param from_device_id Source device-id.
     * @param to_device_id Command destination device-id .
     */
    virtual void recv_warp_request_1(const vpid_t& pid,
				     const vtid_t& tid,
				     const vtid_t& root_tid,
				     vaddr_t proc_addr,
				     const std::string& name,
				     const std::string& from_account,
				     const dev_id_t& from_device_id,
				     const dev_id_t& to_device_id) = 0;

    /**
     * Call when recv warp acception from warp destination device.
     * @param pid Target pid.
     * @param tid Target tid.
     * @param from_device_id Source device-id.
     * @param to_device_id Command destination device-id .
     * @param result
     */
    virtual void recv_warp_request_2(const vpid_t& pid,
				     const vtid_t& tid,
				     const dev_id_t& from_device_id,
				     const dev_id_t& to_device_id,
				     int result) = 0;

    /**
     * Call when recv warp data from warp source device.
     * @param pid Target pid.
     * @param tid Target tid.
     * @param from_device_id Source device-id.
     * @param to_device_id Command destination device-id .
     * @param payload Binary data.
     */
    virtual void recv_vm_data(const vpid_t& pid,
			      const vtid_t& tid,
			      const dev_id_t& src_device_id,
			      const dev_id_t& dst_device_id,
			      const std::string& payload) = 0;

    /**
     * Call when recv warp data from warp destination device.
     * @param name Target memory space name.
     * @param src_device_id What device send from this data.
     * @param payload Binary data.
     */
    virtual void recv_memory_data(const std::string& name,
				  const dev_id_t& src_device_id,
				  const dev_id_t& dst_device_id,
				  const std::string& payload) = 0;

    /**
     * Call when process was killed.
     * @param pid Target pid.
     */
    virtual void recv_exit_process(const vpid_t& pid) = 0;

    /**
     * Recv console for test.
     * @param pid Source pid.
     * @param dev Device name (stdout/stderr).
     * @param payload output stream or text.
     * @param from_device_id Source deice-id.
     */
    virtual void recv_test_console(const vpid_t& pid,
				   const std::string& dev_name,
				   const std::string& payload,
				   const dev_id_t& from_device_id) = 0;
  };
  
  /**
   * Message sender by using Socket.IO.
   */
  class SocketIo {
  public:
    /**
     * Constractor with delegate.
     * @param delegate Delegate for recv event.
     */
    SocketIo(SocketIoDelegate& delegate);

    /**
     * Destructor with close Socket.IO.
     */
    virtual ~SocketIo();
    
    /**
     * Connect to server.
     * @param url Server's URL.
     */
    void connect(const std::string& url);

    /**
     * Pooling.
     */
    void pool();

    /**
     * Send load llvm command.
     * Packet format: {
     *   name: <Application name>,
     *   file: <File content(binary)>,
     *   args: [<arg1>, <arg2>,...]
     *   dest_device_id: <Destination device-id>
     * }
     * @param name Application name.
     * @param file File content(binary).
     * @param args List of arguments for program.
     * @param dst_device_id Destination device-id.
     */
    void send_load_llvm(const std::string& name,
			const std::string& file,
			const std::vector<std::string>& args,
			const dev_id_t& dst_device_id);

    /**
     * Send login command.
     * Packet format: {
     *   account: <account>,
     *   password: <password>
     * }
     * @param account Account name.
     * @param passward Passward for account.
     */
    void send_login(const std::string& account,
		    const std::string& password);

    /**
     * Send request of device list.
     * Packet format: {
     * }
     */
    void send_list_device();
    

    /**
     * Send device bind command.
     * Packet format: {
     *   id: <id>,
     *   name: <name>
     * }
     * @param id Just using device-id.
     * @param name Name of device.
     */
    void send_bind_device(const dev_id_t& id,
			  const std::string& name);

    /**
     * Send process list for synchronize.
     * Packet format: {
     *   <pid>: {
     *     pid: <pid>,
     *     name: <name of process>,
     *     threads: {
     *       <tid>: {
     *         tid: <tid>,
     *         device_id: <device_id>
     *       }, ...
     *     }
     *   }, ...
     * }
     */
    void send_sync_proc_list(const std::map<vpid_t, SocketIoProc>& procs);

    /**
     * Send request of trigger to warp from other device.
     * Packet format: {
     *   pid: <pid to want to warp.>
     *   tid: <tid to want to warp.>
     *   to_device_id:  <source device-id.>
     *   dst_device_id: <destination device-id.>
     * }
     */
    void send_warp_request_0(const vpid_t& pid,
			     const vtid_t& tid,
			     const dev_id_t& to_device_id,
			     const dev_id_t& dst_device_id);

    /**
     * Send request of trigger to warp from device there running process.
     * Packet format: {
     *   pid: <pid to want to warp.>
     *   tid: <tid to want to warp.>
     *   root_tid: <root tid of process.>
     *   to_device_id: <destination device-id.>
     * }
     */
    void send_warp_request_1(const vpid_t& pid,
			     const vtid_t& tid,
			     const vtid_t& root_tid,
			     vaddr_t proc_addr,
			     const dev_id_t& to_device_id);

    /**
     * Send reply of trigger to warp to device there running process.
     * Packet format: {
     *   pid: <pid to want to warp.>
     *   tid: <tid to want to warp.>
     *   to_device_id: <source device-id.>
     *   result: <true if accept warp.>
     * }
     */
    void send_warp_request_2(const vpid_t& pid,
			     const vtid_t& tid,
			     const dev_id_t& to_device_id,
			     int result);

    /**
     * Send binary data to virtual machine.
     * Packet format: {
     *   pid: <pid to want to warp.>
     *   tid: <tid to want to warp.>
     *   to_device_id: <target device-id.>
     *   payload: <binary data.>
     * }
     */
    void send_vm_data(const vpid_t& pid,
		      const vtid_t& tid,
		      const dev_id_t& to_device_id,
		      const std::string& payload);

    /**
     * Packet format: {
     *   name: <name of memory space>
     *   to_device_id: <target device_id>
     *   data: <payload>
     * }
     */
    void send_memory_data(const std::string& name,
			  const dev_id_t& to_device_id,
			  const std::string& payload);

    /**
     * Send command of exit process.
     * Packet format: {
     *   pid: <pid to want to warp.>
     * }
     */
    void send_exit_process(const vpid_t& pid);

    /**
     * Send console for test.
     * @param pid Source pid.
     * @param dev Device name (stdout/stderr).
     * @param payload output stream or text.
     */
    void send_test_console(const vpid_t& pid,
			   const std::string& dev_name,
			   const std::string& payload);

  private:
    enum SioStatus {
      SETUP,
      CONNECT,
      FAIL,
      CLOSE
    };
    // Delegate for recv events.
    SocketIoDelegate& delegate;

    // Socket.IO client for listen event.
    sio::client client;
    // Socket.IO socket for emit message.
    sio::socket::ptr socket;

    std::mutex sio_mutex;
    std::condition_variable_any sio_cond;
    std::atomic<SioStatus> sio_status {SETUP};
    std::queue<std::pair<std::string, sio::message::ptr>> sio_queue;
    
    /**
     * Event listener for Socket.IO's close event.
     */
    void on_close();

    /**
     * Event listener for Socket.IO's fail event.
     */
    void on_fail();
    
    /**
     * Event listener for Socket.IO's connect event.
     */
    void on_open();
  };
}
