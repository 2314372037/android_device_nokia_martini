#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit from martini device
$(call inherit-product, device/nokia/martini/device.mk)

# Remove ro.adb.secure=1 set by vendor/omni/config/common.mk
PRODUCT_SYSTEM_DEFAULT_PROPERTIES := \
    $(filter-out ro.adb.secure=%,$(PRODUCT_SYSTEM_DEFAULT_PROPERTIES)) \
    ro.adb.secure=0

PRODUCT_DEFAULT_PROPERTY_OVERRIDES := \
    $(filter-out ro.adb.secure=% ro.secure=%,$(PRODUCT_DEFAULT_PROPERTY_OVERRIDES)) \
    ro.adb.secure=0 \
    ro.secure=0

PRODUCT_DEVICE := martini
PRODUCT_NAME := twrp_martini
PRODUCT_BRAND := nokia
PRODUCT_MODEL := Lumia 930
PRODUCT_MANUFACTURER := nokia

PRODUCT_GMS_CLIENTID_BASE := android-google

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="twrp_martini-eng 9 PQ3A.190801.002 27 test-keys"

BUILD_FINGERPRINT := google/twrp_martini/martini:9/PQ3A.190801.002/27:eng/test-keys
