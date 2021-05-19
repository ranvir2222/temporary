# sync rom
repo init --depth=1 -u https://github.com/PixelExperience/manifest -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone  --depth 1 https://github.com/flashokiller/manifest_pine.git -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8


# build rom
source build/envsetup.sh
lunch aosp_pine-userdebug
make bacon

# upload rom
rclone copy out/target/product/pine/*.zip cirrus:pine -P
