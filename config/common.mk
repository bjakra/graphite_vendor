# Graphite product configuration, inherited by every Graphite build through
# build/make/target/product/handheld_system_ext.mk (patch 0002-graphite-vendor-hook).

# Graphite settings app (Settings → System → Graphite)
PRODUCT_PACKAGES += \
    GraphiteParts

# Lawnchair: default home and recents provider (prebuilt/Lawnchair, overlay in overlay/)
PRODUCT_PACKAGES += \
    GraphiteLawnchair

# Google's lockscreen clocks from the stock image, refreshed by tools/apps/import-pixel-clocks.sh
PRODUCT_PACKAGES += \
    SystemUIClocks-BigNum \
    SystemUIClocks-Calligraphy \
    SystemUIClocks-Growth \
    SystemUIClocks-Inflate \
    SystemUIClocks-Metro \
    SystemUIClocks-NumOverlap \
    SystemUIClocks-Weather

# Resource overlays for GrapheneOS components (recents provider, SystemUI's plugin allowlist).
# Named RRO modules, not PRODUCT_PACKAGE_OVERLAYS: that generates
# framework-res__<device>__auto_generated_rro_product, which conflicts with the module of the
# same name in adevtool's vendor/google_devices/<device>/overlays.
PRODUCT_PACKAGES += \
    GraphiteFrameworkOverlay \
    GraphiteSystemUIOverlay
