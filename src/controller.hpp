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
    virtual void send_warp_data(const vpid_t& pid,
				const vtid_t& tid,
				const dev_id_t& dst_device_id,
				const std::string& data);
    
    /**
     * Call when context switch of process.
     * @param pid Target pid. Empty (length == 0) when switch to controller's process.
     */
    virtual void on_switch_proccess(const vpid_t& pid);

    /**
     * Call when process was finish.
     * @param pid Target pid.
     */
    virtual void on_finish_proccess(const vpid_t& pid);

    /**
     * Call when rise error.
     * @param pid Target pid.
     * @param message Error message.
     */
    virtual void on_error(const vpid_t& pid,
			  const std::string& message);
  };
  
  /**
   * Controller for set of processes.
   */
  class Controller : protected VMachineDelegate {
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
    bool recv_warp_data(const vpid_t& pid,
			const vtid_t& tid,
			const std::string& data);
    
    /**
     * Create empty process.
     * @param pid New process's pid.
     * @param libs List of external libraries.
     * @param lib_filter Map of API name call from and call for.
     */
    void create_process(const vpid_t& pid,
			std::vector<void*> libs,
			const std::map<std::string, std::string>& lib_filter);

    /**
     * Delete process.
     * @param pid Target pid.
     */
    void delete_process(const vpid_t& pid);

    /**
     * Start exiting process.
     * Resource remain after exit. Need to call delete_process after all.
     * @param pid Target pid.
     */
    void exit_process(const vpid_t& pid);

    /**
     * Start warp process.
     * Resource remain after warp. Need to call delete_process after all.
     * @param pid Target pid.
     * @param tid Target thread-id.
     * @param dst_device_id Warp destination.
     */
    void warp_process(const vpid_t& pid,
		      const vtid_t& tid,
		      const dev_id_t& dst_device_id);

  protected:
    /**
     * @inheritDoc
     */
    vtid_t assign_tid(VMachine& vm) override;

  private:
    /** Event assignee */
    ControllerDelegate& delegate;
    /** Map of pid and VMachine. */
    std::map<vpid_t, std::shared_ptr<VMachine>> procs;
    /** Map of pid and warp destination device-ids. */
    std::map<vpid_t, dev_id_t> warp_dest;

    /**
     * Dump and send data to warp process. 
     * @param pid Target pid.
     */
    void do_warp_process(const vpid_t& pid);

    void recv_process_warp(const vpid_t& pid, picojson::object& json);
  };
}
