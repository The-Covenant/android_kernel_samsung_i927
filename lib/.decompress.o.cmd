cmd_lib/decompress.o := /opt/toolchains/android-toolchain-eabi/bin/arm-eabi-gcc -Wp,-MD,lib/.decompress.o.d  -nostdinc -isystem /opt/toolchains/android-toolchain-eabi/bin/../lib/gcc/arm-eabi/4.7.1/include -I/home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include -Iarch/arm/include/generated -Iinclude  -include /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/include/linux/kconfig.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-tegra/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -O2 -marm -fno-dwarf2-cfi-asm -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables -D__LINUX_ARM_ARCH__=7 -march=armv7-a -msoft-float -Uarm -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fomit-frame-pointer -g -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -DCC_HAVE_ASM_GOTO    -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(decompress)"  -D"KBUILD_MODNAME=KBUILD_STR(decompress)" -c -o lib/decompress.o lib/decompress.c

source_lib/decompress.o := lib/decompress.c

deps_lib/decompress.o := \
    $(wildcard include/config/decompress/gzip.h) \
    $(wildcard include/config/decompress/bzip2.h) \
    $(wildcard include/config/decompress/lzma.h) \
    $(wildcard include/config/decompress/xz.h) \
    $(wildcard include/config/decompress/lzo.h) \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/include/linux/kconfig.h \
    $(wildcard include/config/h.h) \
    $(wildcard include/config/.h) \
    $(wildcard include/config/foo.h) \
  include/linux/decompress/generic.h \
  include/linux/decompress/bunzip2.h \
  include/linux/decompress/unlzma.h \
  include/linux/decompress/unxz.h \
  include/linux/decompress/inflate.h \
  include/linux/decompress/unlzo.h \
  include/linux/types.h \
    $(wildcard include/config/uid16.h) \
    $(wildcard include/config/lbdaf.h) \
    $(wildcard include/config/arch/dma/addr/t/64bit.h) \
    $(wildcard include/config/phys/addr/t/64bit.h) \
    $(wildcard include/config/64bit.h) \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include/asm/types.h \
  include/asm-generic/int-ll64.h \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include/asm/bitsperlong.h \
  include/asm-generic/bitsperlong.h \
  include/linux/posix_types.h \
  include/linux/stddef.h \
  include/linux/compiler.h \
    $(wildcard include/config/sparse/rcu/pointer.h) \
    $(wildcard include/config/trace/branch/profiling.h) \
    $(wildcard include/config/profile/all/branches.h) \
    $(wildcard include/config/enable/must/check.h) \
    $(wildcard include/config/enable/warn/deprecated.h) \
  include/linux/compiler-gcc.h \
    $(wildcard include/config/arch/supports/optimized/inlining.h) \
    $(wildcard include/config/optimize/inlining.h) \
  include/linux/compiler-gcc4.h \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include/asm/posix_types.h \
  include/linux/string.h \
    $(wildcard include/config/binary/printf.h) \
  /opt/toolchains/android-toolchain-eabi/bin/../lib/gcc/arm-eabi/4.7.1/include/stdarg.h \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include/asm/string.h \

lib/decompress.o: $(deps_lib/decompress.o)

$(deps_lib/decompress.o):