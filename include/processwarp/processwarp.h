#ifndef INCLUDE_PROCESSWARP_PROCESSWARP_H_
#define INCLUDE_PROCESSWARP_PROCESSWARP_H_

#include <inttypes.h>

#ifdef __cplusplus
extern "C" {
#endif

  /** Virtual pointer type with VM. */
  typedef uint64_t pw_ptr_t;

  /** int with VM. */
  typedef int32_t pw_int_t;
  /** unsigned int with VM. */
  typedef uint32_t pw_uint_t;

  /**
   * Regist function to execute when after warp.
   * Function will executed order by registing.
   * @param func Pointer to function to regist.
   * @return Return 0 if normal.
   */
  pw_int_t pw_at_after_warp(void (*func)(void));

  /**
   * Regist function to execute when befor warp.
   * Function will executed order by registing.
   * @param func Pointer to function to regist.
   * @return Return 0 if normal.
   */
  pw_int_t pw_at_befor_warp(void (*func)(void));

  /**
   * This function check having request for warp.
   * Don't use this function in functions those are registed by pw_at_after_warp or pw_at_befor_warp.
   */
  void pw_poll_warp_request();

#define PW_KEY_WARP_TIMING 1
#define PW_VAL_ON_ANYTIME 0
#define PW_VAL_ON_POLLING 1

  /**
   * Set PROCESS WARP parameter value.
   * @param key Parameter key.
   * @param value Parameter Value.
   * @param Return 0 if normal.
   */
  pw_int_t pw_set_processwarp_param(pw_int_t key, pw_int_t value);

#ifdef __cplusplus
}  // extern "C"
#endif

#endif  // INCLUDE_PROCESSWARP_PROCESSWARP_H_
