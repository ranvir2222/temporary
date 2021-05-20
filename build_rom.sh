# sync rom
repo init --depth=1 -u git://github.com/LineageOS/android.git -b lineage-18.1 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/kardebayan/local_manifests.git --depth 1 -b r11 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# Patch
cd external/selinux && curl -L http://ix.io/2FhM > sasta.patch && git am sasta.patch && cd ../..

# build rom
source build/envsetup.sh
lunch lineage_CPH1859-eng
mka bacon

# upload rom
# If you need to upload json/multiple files too then put like this 'rclone copy out/target/product/mido/*.zip cirrus:mido -P && rclone copy out/target/product/mido/*.zip.json cirrus:mido -P'
rclone copy out/target/product/CPH1859/*.zip cirrus:CPH1859 -P
