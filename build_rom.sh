# sync rom
repo init --depth=1 -u git://github.com/LineageOS/android.git -b lineage-18.1 -g default,-device,-mips,-darwin,-notdefault

git clone https://github.com/MinatiScape/local_manifests.git --depth=1 -b main .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Build Lineage
. build/envsetup.sh
lunch lineage_olives-userdebug
mka bacon -j$(nproc --all)

# Upload Build
rclone copy out/target/product/olives/*UNOFFICIAL*.zip cirrus:olives -P
