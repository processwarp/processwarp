#pragma once

#include <processwarp.h>

#ifdef __cplusplus
extern "C" {
#endif

  typedef struct __jmp_buf {
    __pw_vm_int_t stack_count;
    __pw_vm_ptr_t ret_addr;
    __pw_vm_uint_t pc;
    __pw_vm_uint_t phi0;
    __pw_vm_uint_t phi1;
    __pw_vm_ptr_t type;
    __pw_vm_int_t alignment;
    __pw_vm_ptr_t output;
    __pw_vm_ptr_t value;
    __pw_vm_ptr_t address;
  } jmp_buf[1];

  int setjmp(jmp_buf);

  void longjmp(jmp_buf, int);
  
#ifdef __cplusplus
} // extern "C"
#endif
