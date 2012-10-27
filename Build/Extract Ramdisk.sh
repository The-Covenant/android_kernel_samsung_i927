 mkdir ramdisk2
 cd ramdisk2
 gzip -dc ../boot.img-ramdisk.gz | cpio -i
 cd ..
bash
