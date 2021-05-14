# sync rom
repo init -u git://github.com/crdroidandroid/android.git -b 11.0 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Hashimkp/local_manifests.git --depth 1 -b los .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 

# build rom
. build/envsetup.sh
lunch lineage_RMX1971-userdebug
mka bacon -j$(nproc --all)

# upload rom
rclone copy out/target/product/RMX1971/crDroid*.zip cirrus:RMX1971 -P
