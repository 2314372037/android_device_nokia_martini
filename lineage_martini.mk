# Boot animation
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080
TARGET_BOOTANIMATION_HALF_RES := true

# Temporary bring-up: collect USB logs before the framework authorization UI.
# Keep this before common_mini.mk: the first property value wins.
ifeq ($(TARGET_BUILD_VARIANT),userdebug)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
endif

# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/lineage/config/common_mini.mk)

# Retain the keyboard from common_mini_phone without telephony packages.
PRODUCT_PACKAGES += LatinIME

# Inherit device configuration
$(call inherit-product, device/nokia/martini/full_martini.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := martini
PRODUCT_NAME := lineage_martini
PRODUCT_BRAND := nokia
PRODUCT_MODEL := Lumia 930
PRODUCT_MANUFACTURER := NOKIA
