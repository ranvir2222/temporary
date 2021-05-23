# sync rom
repo init -u --depth=1 https://github.com/StagOS/manifest.git -b r11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/baibhab34/local_manifest --depth 1 -b stag .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export WITH_GAPPS=true
lunch stag_RMX1805-userdebug
mka stag

# upload rom
rclone copy out/target/product/RMX1805/StagOS*RMX1805*.zip cirrus:RMX1805 -P
