# sync rom
repo init -u https://github.com/Havoc-OS/android_manifest.git -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Hashimkp/local_manifests.git --depth 1 -b aosp .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
export WITH_GAPPS = true
lunch havoc_RMX1971-userdebug
mka bacon

# upload rom
rclone copy out/target/product/RMX1971/Havoc-OS*.zip cirrus:RMX1971 -P
