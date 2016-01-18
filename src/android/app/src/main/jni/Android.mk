LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

ROOT_PATH := ../../../../../..
CORE_PATH := $(ROOT_PATH)/src/core

LOCAL_C_INCLUDES += $(CORE_PATH)
LOCAL_C_INCLUDES += $(ROOT_PATH)/include

LOCAL_CPPFLAGS   += -I$(ROOT_PATH)/src/third_party/picojson

LOCAL_LDLIBS     += -llog
LOCAL_LDLIBS     += -latomic

LOCAL_MODULE     := processwarp_jni

LOCAL_SRC_FILES  += router_jni.cpp
LOCAL_SRC_FILES  += $(CORE_PATH)/convert.cpp $(CORE_PATH)/scheduler.cpp

include $(BUILD_SHARED_LIBRARY)
