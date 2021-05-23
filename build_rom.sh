# sync rom
repo init --depth=1 -u git://github.com/CarbonROM/android.git -b cr-9.0 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/ranvir2222/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch carbon_surya-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
make carbon -j$(nproc --all)

# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P && rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/surya/*UNOFFICIAL*.zip cirrus:surya -P
