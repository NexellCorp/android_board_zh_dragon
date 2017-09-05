#
# Copyright (C) 2015 The Android Open-Source Project
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

# refer to marlin/sailfish
#
KERNEL_DIR := $(LOCAL_PATH)/../kernel/kernel-4.4.x

PRODUCT_AAPT_CONFIG := normal xlarge large
PRODUCT_AAPT_PREF_CONFIG := hdpi
PRODUCT_AAPT_PREBUILT_DPI := xxhdpi xhdpi hdpi mdpi ldpi

PRODUCT_SHIPPING_API_LEVEL := 25

DEVICE_PACKAGE_OVERLAYS += device/nexell/zh_dragon/overlay

# PRODUCT_ENFORCE_RRO_TARGETS := \
	framework-res

PRODUCT_COPY_FILES += \
	$(KERNEL_DIR)/arch/arm/boot/zImage:kernel

PRODUCT_COPY_FILES += \
	$(KERNEL_DIR)/arch/arm/boot/dts/s5p4418-zh_dragon-rev00.dtb:2ndbootloader

# Vendor Interface Manifest
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/manifest.xml:vendor/manifest.xml

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/init.zh_dragon.rc:root/init.zh_dragon.rc \
	$(LOCAL_PATH)/init.zh_dragon.usb.rc:root/init.zh_dragon.usb.rc \
	$(LOCAL_PATH)/ueventd.zh_dragon.rc:root/ueventd.zh_dragon.rc \
	$(LOCAL_PATH)/fstab.zh_dragon:root/fstab.zh_dragon \
	$(LOCAL_PATH)/init.recovery.zh_dragon.rc:root/init.recovery.zh_dragon.rc

# memtester
PRODUCT_COPY_FILES += \
	device/nexell/zh_dragon/memtester:system/bin/memtester

# Recovery
PRODUCT_PACKAGES += \
	librecovery_updater_nexell

PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_CHARACTERISTICS := tablet

# OpenGL ES API version: 2.0
PRODUCT_PROPERTY_OVERRIDES += \
	ro.opengles.version=131072

# density
PRODUCT_PROPERTY_OVERRIDES += \
	ro.sf.lcd_density=160

PRODUCT_PACKAGES += \
	audio.a2dp.default \
	audio.usb.default \
	audio.r_submix.default \
	tinyplay

# libion needed by gralloc, ogl
PRODUCT_PACKAGES += libion iontest

PRODUCT_PACKAGES += libdrm

# HAL
PRODUCT_PACKAGES += \
	gralloc.zh_dragon \
	libGLES_mali \
	hwcomposer.zh_dragon \
	audio.primary.zh_dragon \
	memtrack.zh_dragon \
	camera.zh_dragon

# tinyalsa
PRODUCT_PACKAGES += \
	libtinyalsa \
	tinyplay \
	tinycap \
	tinymix \
	tinypcminfo

PRODUCT_PACKAGES += fs_config_files

# omx
PRODUCT_PACKAGES += \
	libstagefrighthw \
	libnx_video_api \
	libNX_OMX_VIDEO_DECODER \
	libNX_OMX_Base \
	libNX_OMX_Core \
	libNX_OMX_Common

# stagefright FFMPEG compnents
ifeq ($(EN_FFMPEG_AUDIO_DEC),true)
PRODUCT_PACKAGES += libNX_OMX_AUDIO_DECODER_FFMPEG
endif

ifeq ($(EN_FFMPEG_EXTRACTOR),true)
PRODUCT_PACKAGES += libNX_FFMpegExtractor
endif

# New HAL Interface
# ConfigStore
PRODUCT_PACKAGES += \
	android.hardware.configstore@1.0-service

# Health HAL
PRODUCT_PACKAGES += \
    android.hardware.health@1.0-impl

# Keymaster HAL
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl

# Gralloc
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.mapper@2.0-impl

# HW Composer
PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.graphics.composer@2.1-service

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@2.0-impl \
    android.hardware.audio.effect@2.0-impl \
    android.hardware.broadcastradio@1.0-impl \
    android.hardware.soundtrigger@2.0-impl

# new gatekeeper HAL
# PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-impl

# RenderScript HAL
# PRODUCT_PACKAGES += \
    android.hardware.renderscript@1.0-impl

# limit dex2oat threads to improve thermals
PRODUCT_PROPERTY_OVERRIDES += \
	dalvik.vm.boot-dex2oat-threads=4 \
	dalvik.vm.dex2oat-threads=4 \
	dalvik.vm.image-dex2oat-threads=4

PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapstartsize=16m \
    dalvik.vm.heapgrowthlimit=256m \
    dalvik.vm.heapsize=512m \
    dalvik.vm.heaptargetutilization=0.75 \
    dalvik.vm.heapminfree=512k \
    dalvik.vm.heapmaxfree=8m

# HWUI common settings
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hwui.gradient_cache_size=1 \
    ro.hwui.drop_shadow_cache_size=6 \
    ro.hwui.r_buffer_cache_size=8 \
    ro.hwui.texture_cache_flushrate=0.4 \
    ro.hwui.text_small_cache_width=1024 \
    ro.hwui.text_small_cache_height=1024 \
    ro.hwui.text_large_cache_width=2048 \
    ro.hwui.text_large_cache_height=1024

#skip boot jars check
SKIP_BOOT_JARS_CHECK := true

$(call inherit-product, frameworks/base/data/fonts/fonts.mk)
