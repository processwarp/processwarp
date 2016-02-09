LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

ROOT_PATH := ../../../../../..
CORE_PATH := $(ROOT_PATH)/src/core

LOCAL_C_INCLUDES += $(CORE_PATH)
LOCAL_C_INCLUDES += $(ROOT_PATH)/include

LOCAL_CPPFLAGS   += -I$(ROOT_PATH)/src/third_party/picojson
LOCAL_CPPFLAGS   += -D PICOJSON_USE_LOCALE=0
LOCAL_CPPFLAGS   += -I$(ROOT_PATH)/src/third_party/safeint

LOCAL_LDLIBS     += -llog
LOCAL_LDLIBS     += -latomic

LOCAL_MODULE     := processwarp_jni

LIBFFI_PATH      := $(ROOT_PATH)/src/third_party/libffi
LOCAL_CFLAGS     += -I$(LIBFFI_PATH)/include
LOCAL_SRC_FILES  += $(LIBFFI_PATH)/src/types.c
LOCAL_SRC_FILES  += $(LIBFFI_PATH)/src/prep_cif.c
ifeq ($(TARGET_ARCH),arm64)
  LOCAL_CFLAGS     += -I$(LIBFFI_PATH)/include_arm64 -I$(LIBFFI_PATH)/src/aarch64
  LOCAL_CPPFLAGS   += -I$(LIBFFI_PATH)/include_arm64 -I$(LIBFFI_PATH)/src/aarch64
  LOCAL_SRC_FILES  += $(LIBFFI_PATH)/src/aarch64/ffi.c
  LOCAL_SRC_FILES  += $(LIBFFI_PATH)/src/aarch64/sysv.S
endif
ifeq ($(TARGET_ARCH),x86_64)
  LOCAL_CFLAGS     += -I$(LIBFFI_PATH)/include_x86_64 -I$(LIBFFI_PATH)/src/x86
  LOCAL_CPPFLAGS   += -I$(LIBFFI_PATH)/include_x86_64 -I$(LIBFFI_PATH)/src/x86
  LOCAL_SRC_FILES  += $(LIBFFI_PATH)/src/x86/ffi64.c
  LOCAL_SRC_FILES  += $(LIBFFI_PATH)/src/x86/unix64.S
endif
ifeq ($(TARGET_ARCH),mips64)
  LOCAL_CFLAGS     += -I$(LIBFFI_PATH)/include_mips64 -I$(LIBFFI_PATH)/src/mips
  LOCAL_CPPFLAGS   += -I$(LIBFFI_PATH)/include_mips64 -I$(LIBFFI_PATH)/src/mips
  LOCAL_SRC_FILES  += $(LIBFFI_PATH)/src/mips/ffi.c
  LOCAL_SRC_FILES  += $(LIBFFI_PATH)/src/mips/o32.S
  LOCAL_SRC_FILES  += $(LIBFFI_PATH)/src/mips/n32.S
endif
ifeq ($(TARGET_ARCH),arm)
  LOCAL_CFLAGS     += -I$(LIBFFI_PATH)/include_arm -I$(LIBFFI_PATH)/src/arm
  LOCAL_CPPFLAGS   += -I$(LIBFFI_PATH)/include_arm -I$(LIBFFI_PATH)/src/arm
  LOCAL_SRC_FILES  += $(LIBFFI_PATH)/src/arm/ffi.c
  LOCAL_SRC_FILES  += $(LIBFFI_PATH)/src/arm/sysv.S
endif
ifeq ($(TARGET_ARCH),x86)
  LOCAL_CFLAGS     += -I$(LIBFFI_PATH)/include_x86 -I$(LIBFFI_PATH)/src/x86
  LOCAL_CFLAGS     += -I$(LIBFFI_PATH)/include_x86 -I$(LIBFFI_PATH)/src/x86
  LOCAL_SRC_FILES  += $(LIBFFI_PATH)/src/x86/ffi.c
  LOCAL_SRC_FILES  += $(LIBFFI_PATH)/src/x86/sysv.S
  LOCAL_SRC_FILES  += $(LIBFFI_PATH)/src/x86/win32.S
endif
ifeq ($(TARGET_ARCH),mips)
  LOCAL_CFLAGS     += -I$(LIBFFI_PATH)/include_mips -I$(LIBFFI_PATH)/src/mips
  LOCAL_CFLAGS     += -I$(LIBFFI_PATH)/include_mips -I$(LIBFFI_PATH)/src/mips
  LOCAL_SRC_FILES  += $(LIBFFI_PATH)/src/mips/ffi.c
  LOCAL_SRC_FILES  += $(LIBFFI_PATH)/src/mips/o32.S
  LOCAL_SRC_FILES  += $(LIBFFI_PATH)/src/mips/n32.S
endif


LOCAL_SRC_FILES  += router_jni.cpp
LOCAL_SRC_FILES  += worker_jni.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/convert.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/error.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/func_store.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/finally.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/basic_operator.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/builtin_bit.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/builtin_gui.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/builtin_libc.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/builtin_memory.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/builtin_overflow.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/builtin_posix.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/builtin_va_arg.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/builtin_warp.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/format.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/interrupt_memory_require.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/process.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/scheduler.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/stackinfo.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/std_error.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/symbols.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/thread.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/type_store.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/util.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/vmachine.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/vmemory.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/wrapped_operator.cpp

include $(BUILD_SHARED_LIBRARY)
