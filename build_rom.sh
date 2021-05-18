# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/AOSPA/manifest.git -b ruby -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/derp-sdm660-common/Local-Manifests.git --depth 1 -b aospa .repo/local_manifests
sudo apt update
sudo apt install cpio
sudo apt install wget
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

#qcom/common patch
cd device/qcom/common && wget https://github.com/AOSPA/android_device_qcom_common/commit/832de59190dd996820281e78dd4afd55fe13dd9c.patch && git am *.patch && cd -

#vendor patch
cd vendor/pa && wget https://github.com/AOSPA/android_vendor_pa/commit/f0bfe716960ee8498d6a9442d734615909163d6b.patch && git am *.patch && cd -

# build rom
#build/envsetup.sh
#lunch aosp_X00TD-user
export GLOBAL_THINLTO=true
./rom-build.sh X00TD -t user

# upload rom
rclone copy out/target/product/X00TD/AOSPA*.zip cirrus:X00TD -P
