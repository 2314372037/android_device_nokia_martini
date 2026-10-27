#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/omni_martini.mk \
    $(LOCAL_DIR)/twrp_martini.mk

COMMON_LUNCH_CHOICES := \
    omni_martini-user \
    omni_martini-userdebug \
    omni_martini-eng \
    twrp_martini-user \
    twrp_martini-userdebug \
    twrp_martini-eng
