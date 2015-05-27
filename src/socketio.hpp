#pragma once

#include <atomic>
#include <condition_variable>
#include <mutex>
#include <queue>
#include <thread>

#include <sio_client.h>

namespace processwarp {
  /**
   * Structure using to recv/send_sync_proc_list.
   */
  struct SocketIoProc {
    // pid
    std::string pid;
    // Name of process
    std::string name;
    // Map of tid and device-id.
    std::map<std::string, std::string> threads;
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
				  const std::map<std::string, std::string>& devices) = 0;

    /**
     * Call when recv bind device message from server.
     * @param result Set 0 when succeed or else error code when error.
     * @param device_id Device id bound this device.
     */
    virtual void recv_bind_device(int result, const std::string& device_id) = 0;

    /**
     * Call when recv sync proc list message from server.
     * @param procs Map of pid and SocketIoProc.
     */
    virtual void recv_sync_proc_list(const std::map<std::string, SocketIoProc>& procs) = 0;
    
    /**
     * Call when recv warp request from other device.
     * @param pid Target pid.
     * @param tid Target tid.
     * @param dst_device_id Warp destination device-id .
     * @param to_device_id Command destination device-id .
     */
    virtual void recv_warp_request_0(const std::string& pid,
				     const std::string& tid,
				     const std::string& dst_device_id,
				     const std::string& to_device_id) = 0;

    /**
     * Call when recv warp request from device that having process.
     * @param pid Target pid.
     * @param tid Target tid.
     * @param name Process name.
     * @param from_account Source account.
     * @param from_device_id Source device-id.
     * @param to_device_id Command destination device-id .
     */
    virtual void recv_warp_request_1(const std::string& pid,
				     const std::string& tid,
				     const std::string& name,
				     const std::string& from_account,
				     const std::string& from_device_id,
				     const std::string& to_device_id) = 0;

    /**
     * Call when recv warp acception from warp destination device.
     * @param pid Target pid.
     * @param tid Target tid.
     * @param from_device_id Source device-id.
     * @param to_device_id Command destination device-id .
     * @param result
     */
    virtual void recv_warp_request_2(const std::string& pid,
				     const std::string& tid,
				     const std::string& from_device_id,
				     const std::string& to_device_id,
				     int result) = 0;

    /**
     * Call when recv warp data from warp source device.
     * @param pid Target pid.
     * @param tid Target tid.
     * @param from_device_id Source device-id.
     * @param to_device_id Command destination device-id .
     * @param payload Binary data.
     */
    virtual void recv_warp_data_1(const std::string& pid,
				  const std::string& tid,
				  const std::string& from_device_id,
				  const std::string& to_device_id,
				  const std::string& payload) = 0;

    /**
     * Call when recv warp data from warp destination device.
     * @param pid Target pid.
     * @param tid Target tid.
     * @param to_device_id Command destination device-id .
     * @param result Binary data.
     */
    virtual void recv_warp_data_2(const std::string& pid,
				  const std::string& tid,
				  const std::string& to_device_id,
				  int result) = 0;

    /**
     * Call when process was killed.
     * @param pid Target pid.
     */
    virtual void recv_exit_process(const std::string& pid) = 0;

    /**
     * Recv console for test.
     * @param pid Source pid.
     * @param dev Device name (stdout/stderr).
     * @param payload output stream or text.
     * @param from_device_id Source deice-id.
     */
    virtual void recv_test_console(const std::string& pid,
				   const std::string& dev,
				   const std::string& payload,
				   const std::string& from_device_id) = 0;
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
     * Connect to server.
     * @param url Server's URL.
     */
    void connect(const std::string& url);

    /**
     * Pooling.
     */
    void pool();
    
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
    void send_bind_device(const std::string& id,
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
    void send_sync_proc_list(const std::map<std::string, SocketIoProc>& procs);

    /**
     * Send request of trigger to warp from other device.
     * Packet format: {
     *   pid: <pid to want to warp.>
     *   tid: <tid to want to warp.>
     *   to_device_id:  <source device-id.>
     *   dst_device_id: <destination device-id.>
     * }
     */
    void send_warp_request_0(const std::string& pid,
			     const std::string& tid,
			     const std::string& to_device_id,
			     const std::string& dst_device_id);

    /**
     * Send request of trigger to warp from device there running process.
     * Packet format: {
     *   pid: <pid to want to warp.>
     *   tid: <tid to want to warp.>
     *   to_device_id: <destination device-id.>
     * }
     */
    void send_warp_request_1(const std::string& pid,
			     const std::string& tid,
			     const std::string& to_device_id);

    /**
     * Send reply of trigger to warp to device there running process.
     * Packet format: {
     *   pid: <pid to want to warp.>
     *   tid: <tid to want to warp.>
     *   to_device_id: <source device-id.>
     *   result: <true if accept warp.>
     * }
     */
    void send_warp_request_2(const std::string& pid,
			     const std::string& tid,
			     const std::string& to_device_id,
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
    void send_warp_data_1(const std::string& pid,
			  const std::string& tid,
			  const std::string& to_device_id,
			  const std::string& payload);

    /**
     * Send result binary data to virtual machine.
     * Packet format: {
     *   pid: <pid to want to warp.>
     *   tid: <tid to want to warp.>
     *   to_device_id: <target device-id.>
     *   result: <true if accept data1.>
     * }
     */
    void send_warp_data_2(const std::string& pid,
			  const std::string& tid,
			  const std::string& to_device_id,
			  int result);

    /**
     * Send command of exit process.
     * Packet format: {
     *   pid: <pid to want to warp.>
     * }
     */
    void send_exit_process(const std::string& pid);

    /**
     * Send console for test.
     * @param pid Source pid.
     * @param dev Device name (stdout/stderr).
     * @param payload output stream or text.
     */
    void send_test_console(const std::string& pid,
			   const std::string& dev,
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
