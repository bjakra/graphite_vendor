# System apps don't extract compressed native libraries, and recompressing would break the manager's
# signature. So its libraries, which it runs ksud from, are installed next to the APK as extracted from it.
LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_ARCH),arm64)
define graphite-ksu-lib
include $$(CLEAR_VARS)
LOCAL_MODULE := graphite_ksu_$(1)
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_STEM := $(1)
LOCAL_SRC_FILES := lib/arm64/$(1).so
LOCAL_MODULE_PATH := $$(TARGET_OUT_SYSTEM_EXT)/app/GraphiteKernelSUNext/lib/arm64
LOCAL_MODULE_TARGET_ARCH := arm64
LOCAL_STRIP_MODULE := false
LOCAL_CHECK_ELF_FILES := false
LOCAL_LICENSE_KINDS := SPDX-license-identifier-GPL-3.0
LOCAL_LICENSE_CONDITIONS := restricted
LOCAL_NOTICE_FILE := build/soong/licenses/LICENSE
include $$(BUILD_PREBUILT)
endef
$(foreach lib,$(patsubst %.so,%,$(notdir $(wildcard $(LOCAL_PATH)/lib/arm64/*.so))),$(eval $(call graphite-ksu-lib,$(lib))))
endif
