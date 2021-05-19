# sync rom
repo init --depth=1 -u https://github.com/PixelExperience/manifest -b eleven -g default,-device,-mips,-darwin,-notdefault
git clone  --depth 1 https://github.com/flashokiller/manifest_pine.git -b main .repo/local_manifests
repo sync --force-sync --no-tags --no-clone-bundle

# build rom
source build/envsetup.sh
# oof 
export ALLOW_MISSING_DEPENDENCIES=true
lunch aosp_pine-userdebug
make bacon

# upload rom
rclone copy out/target/product/pine/*.zip cirrus:pine -P
