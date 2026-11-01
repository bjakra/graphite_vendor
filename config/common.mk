# Graphite product configuration, inherited by every Graphite build through
# build/make/target/product/handheld_system_ext.mk (patch 0002-graphite-vendor-hook).

# Graphite settings app (Settings → System → Graphite)
PRODUCT_PACKAGES += \
    GraphiteParts \
    GraphiteClocks

# Lawnchair: default home and recents provider (prebuilt/Lawnchair, overlay in overlay/)
PRODUCT_PACKAGES += \
    GraphiteLawnchair

# Resource overlays for GrapheneOS components (e.g. SystemUI's plugin allowlist)
PRODUCT_PACKAGE_OVERLAYS += vendor/graphite/overlay
