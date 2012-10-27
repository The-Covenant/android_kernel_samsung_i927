cd ramdisk
find . | cpio -o -H newc | gzip > ../newramdisk.cpio.gz
bash
