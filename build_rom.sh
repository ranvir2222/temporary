# sync rom
repo init -u git://github.com/LineageOS/android.git -b lineage-18.1 --depth=1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/cArN4gEisDeD/local_manifest.git -b olivelite --depth 1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_olivelite-userdebug
mka bacon

# upload rom
rclone copy out/target/product/olivalite/*UNOFFICIAL*.zip cirrus:olivelite -P
