# sync rom
repo init --depth=1 -u https://github.com/Palladium-OS/platform_manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/MiDoNaSR545/mainfest_personal --depth 1 -b p .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch palladium_ysl-user
make clean
mka palladium

# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P && rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/ysl/*.zip cirrus:ysl -P
