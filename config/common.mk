# Graphite product configuration, inherited by every Graphite build through
# build/make/target/product/handheld_system_ext.mk (patch 0002-graphite-vendor-hook).

# Graphite settings app (Settings → System → Graphite)
PRODUCT_PACKAGES += \
    GraphiteParts \
    GraphiteWeather

# Lawnchair: default home and recents provider (prebuilt/Lawnchair, overlay in overlay/)
PRODUCT_PACKAGES += \
    GraphiteLawnchair

# KernelSU-Next manager (arm64 only): real devices, not the emulator
ifeq ($(filter sdk_phone%,$(TARGET_PRODUCT)),)
PRODUCT_PACKAGES += \
    GraphiteKernelSUNext \
    graphite_ksu_libadbroot \
    graphite_ksu_libandroidx.graphics.path \
    graphite_ksu_libkernelsu \
    graphite_ksu_libksud
endif

# Google's lockscreen clocks from the stock image, refreshed by tools/apps/import-pixel-clocks.sh
PRODUCT_PACKAGES += \
    SystemUIClocks-BigNum \
    SystemUIClocks-Calligraphy \
    SystemUIClocks-Growth \
    SystemUIClocks-Inflate \
    SystemUIClocks-Metro \
    SystemUIClocks-NumOverlap \
    SystemUIClocks-Weather

# Now Playing: on-device song recognition (core, database downloader and engine), off until turned on in
# Graphite settings. See docs/song-recognition-plan.md in the Graphite repo.
PRODUCT_PACKAGES += \
    GraphiteNowPlaying

# Resource overlays for GrapheneOS components (recents provider, SystemUI's plugin allowlist).
# Named RRO modules, not PRODUCT_PACKAGE_OVERLAYS: that generates
# framework-res__<device>__auto_generated_rro_product, which conflicts with the module of the
# same name in adevtool's vendor/google_devices/<device>/overlays.
PRODUCT_PACKAGES += \
    GraphiteFrameworkOverlay \
    GraphiteSystemUIOverlay
