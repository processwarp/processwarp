#pragma once

#include <inttypes.h>

#ifdef __cplusplus
extern "C" {
#endif

  /** virtual ptr with VM */
  typedef uint64_t __pw_vm_ptr_t;

  /** int with VM */
  typedef int64_t __pw_vm_int_t;
  /** unsigned int with VM */
  typedef uint64_t __pw_vm_uint_t;

  __pw_vm_int_t at_after_warp(void (*func)(void));

  __pw_vm_int_t at_befor_warp(void (*func)(void));

  /**
   * This function check having request for warp.
   * note:dont call in function that called on warp out or in.
   */
  void poll_warp_request();

#define PW_KEY_WARP_TIMING 1
#define PW_VAL_ON_ANYTIME 0
#define PW_VAL_ON_POLLING 1

  __pw_vm_int_t set_processwarp_param(__pw_vm_int_t key, __pw_vm_int_t value);
  
#ifdef __cplusplus
} // extern "C"
#endif
