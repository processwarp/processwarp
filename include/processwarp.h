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

#ifdef __cplusplus
} // extern "C"
#endif
