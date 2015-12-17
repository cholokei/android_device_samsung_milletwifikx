#
# Copyright (C) 2015-2016 The CyanogenMod Project
# by Cholokei - leesl0416@naver.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := device/samsung/milletwifikx

PRODUCT_CHARACTERISTICS := tablet

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Get non-open-source specific aspects if available
$(call inherit-product-if-exists, vendor/samsung/milletwifikx/milletwifikx-vendor.mk)

# Overlay
DEVICE_PACKAGE_OVERLAYS += device/samsung/milletwifikx/overlay

# Screen density
PRODUCT_AAPT_CONFIG := large
PRODUCT_AAPT_PREF_CONFIG := mdpi
PRODUCT_LOCALES += mdpi

# Boot animation
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 800

############### Dalvik

# Ramdisk
PRODUCT_PACKAGES += \
    init.crda.sh \
    init.qcom.bt.sh

PRODUCT_PACKAGES += \
    fstab.qcom \
    init.qcom.rc \
    init.qcom.usb.rc \
    init.target.rc \
    ueventd.qcom.rc

# Audio configuration
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_platform_info.xml:system/etc/audio_platform_info.xml \
    $(LOCAL_PATH)/audio/audio_policy.conf:system/etc/audio_policy.conf \
    $(LOCAL_PATH)/audio/mixer_paths.xml:system/etc/mixer_paths.xml

# Keylayouts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayout/sec_touchscreen.kl:system/usr/keylayout/sec_touchscreen.kl

# Doze
PRODUCT_PACKAGES += \
    SamsungDoze

# Lights
PRODUCT_PACKAGES += \
    lights.msm8226

# Media
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml

# Permissions
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
	frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml

# Thermal
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/thermal-engine-8226.conf:system/etc/thermal-engine-8226.conf

# Wifi
PRODUCT_COPY_FILES += \
    kernel/samsung/millet/drivers/staging/prima/firmware_bin/WCNSS_cfg.dat:system/etc/firmware/wlan/prima/WCNSS_cfg.dat \
    kernel/samsung/millet/drivers/staging/prima/firmware_bin/WCNSS_qcom_cfg.ini:system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini

PRODUCT_PACKAGES += \
    hostapd_default.conf \
    p2p_supplicant_overlay.conf \
    wpa_supplicant_overlay.conf

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_wlan_nv.bin:system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin

# Radio (needed for audio controls even on wifi-only)
PRODUCT_PACKAGES += \
    libsecril-client \
    libsecril-client-sap

ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.secure=0 \
    ro.adb.secure=0

# Common build.props
#PRODUCT_PROPERTY_OVERRIDES += \
#	ro.vendor.extension_library=/system/vendor/lib/libqc-opt.so \
#	persist.data.netmgrd.qos.enable=false \
#	persist.radio.add_power_save=1 \
#	ro.use_data_netmgrd=false

# Inherit from qcom-common
$(call inherit-product, device/samsung/qcom-common/qcom-common.mk)
