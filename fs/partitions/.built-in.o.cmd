cmd_fs/partitions/built-in.o :=  /opt/toolchains/android-toolchain-eabi/bin/arm-eabi-ld -EL    -r -o fs/partitions/built-in.o fs/partitions/check.o fs/partitions/msdos.o fs/partitions/efi.o 
