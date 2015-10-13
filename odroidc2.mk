# Copyright (C) 2015 Hardkernel Co., Ltd.
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
# This file is the build configuration for a full Android
# build for Meson reference board.
#

# Dynamic enable start/stop zygote_secondary in 64bits
# and 32bit system, default closed
#TARGET_DYNAMIC_ZYGOTE_SECONDARY_ENABLE := true

# Inherit from those products. Most specific first.
ifneq ($(ANDROID_BUILD_TYPE), 32)
ifeq ($(TARGET_DYNAMIC_ZYGOTE_SECONDARY_ENABLE), true)
$(call inherit-product, device/hardkernel/common/dynamic_zygote_seondary/dynamic_zygote_64_bit.mk)
else
$(call inherit-product, build/target/product/core_64_bit.mk)
endif
endif

$(call inherit-product, device/hardkernel/common/products/mbox/product_mbox.mk)
$(call inherit-product, device/hardkernel/odroidc2/device.mk)

# ODROID-C2:
PRODUCT_MANUFACTURER := HardKernel Co., Ltd.
PRODUCT_MODEL := ODROIDC2
PRODUCT_BRAND := ODROID
PRODUCT_DEVICE := odroidc2
PRODUCT_NAME := odroidc2

NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

PRODUCT_PROPERTY_OVERRIDES += \
        sys.fb.bits=32

WITH_LIBPLAYER_MODULE := false

PRODUCT_COPY_FILES += \
    device/hardkernel/odroidc2/fstab.odroidc2:root/fstab.odroidc2

#-----------------------------------------------------------------------------
# WiFi
#-----------------------------------------------------------------------------
BOARD_WIFI_VENDOR		:= realtek
BOARD_WLAN_DEVICE		:= rtl8192cu
BOARD_WPA_SUPPLICANT_DRIVER	:= NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB:= lib_driver_cmd_nl80211
WPA_SUPPLICANT_VERSION		:= VER_0_8_X

WIFI_DRIVER			:= rtl8192cu
WIFI_DRIVER_MODULE_NAME		:= rtl8192cu
WIFI_DRIVER_MODULE_PATH		:= /system/lib/modules/8192cu.ko

WIFI_DRIVER_MODULE_ARG		:= ""
WIFI_FIRMWARE_LOADER		:= ""
WIFI_DRIVER_FW_PATH_STA		:= ""
WIFI_DRIVER_FW_PATH_AP		:= ""
WIFI_DRIVER_FW_PATH_P2P		:= ""
WIFI_DRIVER_FW_PATH_PARAM	:= ""

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0

# Change this to match target country
# 11 North America; 14 Japan; 13 rest of world
PRODUCT_DEFAULT_WIFI_CHANNELS := 11

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	device/hardkernel/$(TARGET_PRODUCT)/wifi/wifi_id_list.txt:system/etc/wifi_id_list.txt \
	device/hardkernel/$(TARGET_PRODUCT)/wifi/rtl8192cu:system/etc/modprobe.d/rtl8192cu \
	device/hardkernel/$(TARGET_PRODUCT)/wifi/rt2800usb:system/etc/modprobe.d/rt2800usb

PRODUCT_PACKAGES += \
	wpa_supplicant.conf \
	wpa_supplicant_overlay.conf \
	p2p_supplicant_overlay.conf

# Ralink RT2800 USB Dongle firmware & configuration
PRODUCT_COPY_FILES += \
	device/hardkernel/$(TARGET_PRODUCT)/wifi/rt2870.bin:root/lib/firmware/rt2870.bin \
	device/hardkernel/$(TARGET_PRODUCT)/wifi/RT2870STA.dat:system/etc/Wireless/RT2870STA/RT2870STA.dat

PRODUCT_PACKAGES += libbt-vendor

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml

# Audio
#
BOARD_ALSA_AUDIO=tiny
include device/hardkernel/common/audio.mk

#########################################################################
#
#                                                Camera
#
#########################################################################
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml

$(call inherit-product, device/hardkernel/common/media.mk)

#########################################################################
#
#                                                Languages
#
#########################################################################

# For all locales, $(call inherit-product, build/target/product/languages_full.mk)
PRODUCT_LOCALES := en_US en_AU en_IN fr_FR it_IT es_ES et_EE de_DE nl_NL cs_CZ pl_PL ja_JP \
  zh_TW zh_CN zh_HK ru_RU ko_KR nb_NO es_US da_DK el_GR tr_TR pt_PT pt_BR rm_CH sv_SE bg_BG \
  ca_ES en_GB fi_FI hi_IN hr_HR hu_HU in_ID iw_IL lt_LT lv_LV ro_RO sk_SK sl_SI sr_RS uk_UA \
  vi_VN tl_PH ar_EG fa_IR th_TH sw_TZ ms_MY af_ZA zu_ZA am_ET hi_IN en_XA ar_XB fr_CA km_KH \
  lo_LA ne_NP si_LK mn_MN hy_AM az_AZ ka_GE my_MM mr_IN ml_IN is_IS mk_MK ky_KG eu_ES gl_ES \
  bn_BD ta_IN kn_IN te_IN uz_UZ ur_PK kk_KZ

#################################################################################
#
#                                                PPPOE
#
#################################################################################

BUILD_WITH_PPPOE := true

ifeq ($(BUILD_WITH_PPPOE),true)
PRODUCT_PACKAGES += \
    PPPoE \
    libpppoejni \
    libpppoe \
    pppoe_wrapper \
    pppoe \
    droidlogic.frameworks.pppoe \
    droidlogic.external.pppoe \
    droidlogic.external.pppoe.xml
PRODUCT_PROPERTY_OVERRIDES += \
    ro.platform.has.pppoe=true
endif

#################################################################################
#
#                                                DEFAULT LOWMEMORYKILLER CONFIG
#
#################################################################################
BUILD_WITH_LOWMEM_COMMON_CONFIG := true

BOARD_USES_USB_PM := true

PRODUCT_PACKAGES += \
	Utility \
	updater
# inherit from the non-open-source side, if present
$(call inherit-product-if-exists, device/hardkernel/proprietary/proprietary.mk)
