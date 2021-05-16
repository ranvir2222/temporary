# sync rom
repo init -u https://github.com/PotatoProject/manifest -b dumaloo-release --depth=1 -g default,-mips,-darwin,-notdefault

git clone https://github.com/cArN4gEisDeD/local_manifest --depth=1 -b main .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# patches
#cd external/selinux
#curl -LO https://github.com/PixelExperience/external_selinux/commit/9d6ebe89430ffe0aeeb156f572b2a810f9dc98cc.patch
#patch -p1 < *.patch
#cd ../..

#cd frameworks/base
#curl -LO https://github.com/PixelExperience/frameworks_base/commit/37f5a323245b0fd6269752742a2eb7aa3cae24a7.patch
#patch -p1 < *.patch
#cd ../..

#cd frameworks/opt/net/wifi
#curl -LO https://github.com/PixelExperience/frameworks_opt_net_wifi/commit/3bd2c14fbda9c079a4dc39ff4601ba54da589609.patch
#patch -p1 < *.patch
#cd ../../../..

#cd frameworks/opt/net/ims
#curl -LO https://github.com/PixelExperience/frameworks_opt_net_ims/commit/661ae9749b5ea7959aa913f2264dc5e170c63a0a.patch
#patch -p1 < *.patch
#cd ../../../..

# build
. build/envsetup.sh
lunch potato_RMX1941-userdebug
brunch RMX1941

# upload
rclone copy out/target/product/RMX1941/potato_RMX1941*Community.zip cirrus:RMX1941 -P
