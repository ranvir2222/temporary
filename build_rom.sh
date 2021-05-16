# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/AOSPA/manifest.git -b ruby -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/derp-sdm660-common/Local-Manifests.git --depth 1 -b aospa .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
#build/envsetup.sh
./rom-build.sh X00TD

# upload rom
rclone copy out/target/product/X00TD/AOSPA*.zip cirrus:X00TD -P
