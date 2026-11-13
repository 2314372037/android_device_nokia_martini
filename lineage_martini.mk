# Boot animation
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080
TARGET_BOOTANIMATION_HALF_RES := true

# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/lineage/config/common_mini_phone.mk)

# Inherit device configuration
$(call inherit-product, device/nokia/martini/full_martini.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := martini
PRODUCT_NAME := lineage_martini
PRODUCT_BRAND := nokia
PRODUCT_MODEL := Lumia 930
PRODUCT_MANUFACTURER := NOKIA
