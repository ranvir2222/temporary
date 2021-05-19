# sync rom
repo init --depth=1 -u git://github.com/PotatoProject/manifest.git -b dumaloo-release -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/Apon77Lab/android_.repo_local_manifests.git --depth 1 -b POSP .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 

# build rom
source build/envsetup.sh
lunch potato_ysl-user
brunch ysl

# upload rom
rclone copy out/target/product/mido/*.zip cirrus:ysl -P 
