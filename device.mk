#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/nokia/martini

# busybox
PRODUCT_COPY_FILES += $(LOCAL_PATH)/recovery/root/sbin/busybox:recovery/root/sbin/busybox

# TWRP
PRODUCT_COPY_FILES += \
    device/nokia/martini/recovery.fstab:recovery/root/etc/twrp.fstab
