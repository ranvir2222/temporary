# sync rom
repo init -u git://github.com/TenX-OS/manifest_TenX -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/susandahal/local_manifest --depth 1 -b tenx .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_lavender-userdebug
make bacon

# upload rom
rclone copy out/target/product/lavender/TenX*.zip cirrus:lavender -P
