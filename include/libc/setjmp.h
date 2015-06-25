#ifndef	_SETJMP_H
#define	_SETJMP_H

#ifdef __cplusplus
extern "C" {
#endif

#include <features.h>

#include <bits/setjmp.h>

typedef struct __jmp_buf_tag {
  __pw_vm_uint_t stack_count;
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
/*
#if defined(_POSIX_SOURCE) || defined(_POSIX_C_SOURCE) \
 || defined(_XOPEN_SOURCE) || defined(_GNU_SOURCE) \
 || defined(_BSD_SOURCE)
typedef jmp_buf sigjmp_buf;
int sigsetjmp (sigjmp_buf, int);
_Noreturn void siglongjmp (sigjmp_buf, int);
#endif

#if defined(_XOPEN_SOURCE) || defined(_GNU_SOURCE) \
 || defined(_BSD_SOURCE)
int _setjmp (jmp_buf);
_Noreturn void _longjmp (jmp_buf, int);
#endif
*/
int setjmp (jmp_buf);
_Noreturn void longjmp (jmp_buf, int);

#define setjmp setjmp
#define longjmp longjmp

#ifdef __cplusplus
}
#endif

#endif
