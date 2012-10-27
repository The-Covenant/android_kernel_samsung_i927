#! /bin/bash

echo
date
echo "Starting Script"
echo 

cd ..

export CROSS_COMPILE=/opt/toolchains/android-toolchain-eabi/bin/arm-eabi-

make tegra_bose_defconfig

echo
date
echo "Compiling Kernel"
echo 

make -j5

echo
echo "Packaging Kernel"
echo

cp -a ./arch/arm/boot/zImage ./Build

cp -a ./drivers/net/wireless/bcmdhd/dhd.ko ./Build/ramdisk/lib/modules

cp -a ./drivers/scsi/scsi_wait_scan.ko ./Build/ramdisk/lib/modules

cd ./Build


echo
echo "Building Ramdisk"
echo

cd ramdisk

find . | cpio -o -H newc | gzip > ../newramdisk.cpio.gz
cd ..

./mkbootimg --kernel zImage --ramdisk newramdisk.cpio.gz --base 0x81600000 --kernelMD5 3751cc8e6e4d4b3da0017a725bfe5aed -o boot.img

tar -cf newboot.tar boot.img

cp -a ./boot.img /mnt/hgfs/VM_Share/LiteKernel--JB-OUTPUT

echo
date
echo "Finished"
echo
bash
