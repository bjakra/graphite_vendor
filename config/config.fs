# Graphite: file modes in the images (TARGET_FS_CONFIG_GEN, see config/BoardConfig.mk).

# The KernelSU-Next manager runs its daemon from its native library directory. The build installs
# app files as 0644, so without this it can't start ksud and never gets root.
[system_ext/app/GraphiteKernelSUNext/lib/arm64/libksud.so]
mode: 0755
user: AID_ROOT
group: AID_ROOT
caps: 0
