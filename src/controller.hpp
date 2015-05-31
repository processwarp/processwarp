#pragma once

#include <map>
#include <memory>
#include <string>
#include <vector>

#include "lib/picojson.h"

#include "vmachine.hpp"

namespace processwarp {
  /**
   * Delegate for Controller-class.
   */
  class ControllerDelegate {
  public:
    /**
     * Destructor for virtual.
     */
    virtual ~ControllerDelegate();
    
    /**
     * Call when send data to other device.
     * @param pid Target pid.
     * @param tid Target tid.
     * @param dst_device_id Destination device-id.
     * @param data Send data (Binary).
     */
    virtual void send_warp_data(const std::string& pid,
				const std::string& tid,
				const std::string& dst_device_id,
				const std::string& data);
    
    /**
     * Call when context switch of process.
     * @param pid Target pid. Empty (length == 0) when switch to controller's process.
     */
    virtual void on_switch_proccess(const std::string& pid);

    /**
     * Call when process was finish.
     * @param pid Target pid.
     */
    virtual void on_finish_proccess(const std::string& pid);

    /**
     * Call when rise error.
     * @param pid Target pid.
     * @param message Error message.
     */
    virtual void on_error(const std::string& pid,
			  const std::string& message);
  };
  
  /**
   * Controller for set of processes.
   */
  class Controller {
  public:
    /// device_id to controller.
    std::string device_id;

    /**
     * Constractor with delegate
     * @param delegate Events assignee.
     */
    Controller(ControllerDelegate& delegate);

    /**
     * Main loop.
     */
    void loop();
    
    /**
     * Pass data from other device.
     * @param pid Target pid.
     * @param tid Target tid.
     * @param data Received data (Binary).
     * @return True if accept data.
     */
    bool recv_warp_data(const std::string& pid,
			const std::string& tid,
			const std::string& data);
    
    /**
     * Create empty process.
     * @param pid New process's pid.
     * @param libs List of external libraries.
     * @param lib_filter Map of API name call from and call for.
     */
    void create_process(const std::string& pid,
			std::vector<void*> libs,
			const std::map<std::string, std::string>& lib_filter);

    /**
     * Delete process.
     * @param pid Target pid.
     */
    void delete_process(const std::string& pid);

    /**
     * Start exiting process.
     * Resource remain after exit. Need to call delete_process after all.
     * @param pid Target pid.
     */
    void exit_process(const std::string& pid);

    /**
     * Start warp process.
     * Resource remain after warp. Need to call delete_process after all.
     * @param pid Target pid.
     * @param dst_device_id Warp destination.
     */
    void warp_process(const std::string& pid,
		      const std::string& dst_device_id);

  private:
    /** Event assignee */
    ControllerDelegate& delegate;
    /** Map of pid and VMachine. */
    std::map<std::string, std::shared_ptr<VMachine>> procs;
    /** Map of pid and warp destination device-ids. */
    std::map<std::string, std::string> warp_dest;

    /**
     * Dump and send data to warp process. 
     * @param pid Target pid.
     */
    void do_warp_process(std::string pid);

    void recv_process_warp(std::string pid, picojson::object& json);
  };
}
