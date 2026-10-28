LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := wcnss_service
LOCAL_VENDOR_MODULE := true
LOCAL_SRC_FILES := wcnss_service.c
LOCAL_SHARED_LIBRARIES := libc libcutils libutils liblog libdl
LOCAL_CFLAGS := -Wall -Wno-error -DWCNSS_QMI_OSS -DWCNSS_COPY_CONFIG
LOCAL_MODULE_TAGS := optional
include $(BUILD_EXECUTABLE)
