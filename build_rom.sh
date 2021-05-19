# sync rom
repo init --depth=1 -u https://github.com/PotatoProject/manifest -b dumaloo-release -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/LinkBoi00/linkmanifest -b dumaloo-release --depth=1 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch potato_daisy-user
brunch daisy

# upload rom
rclone copy out/target/product/daisy/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d _ -f 2 | cut -d - -f 1) -P