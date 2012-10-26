cmd_arch/arm/lib/div64.o := /opt/toolchains/android-toolchain-eabi/bin/arm-eabi-gcc -Wp,-MD,arch/arm/lib/.div64.o.d  -nostdinc -isystem /opt/toolchains/android-toolchain-eabi/bin/../lib/gcc/arm-eabi/4.7.1/include -I/home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include -Iarch/arm/include/generated -Iinclude  -include /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/include/linux/kconfig.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-tegra/include -D__ASSEMBLY__ -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables  -D__LINUX_ARM_ARCH__=7 -march=armv7-a  -include asm/unified.h -msoft-float -gdwarf-2        -c -o arch/arm/lib/div64.o arch/arm/lib/div64.S

source_arch/arm/lib/div64.o := arch/arm/lib/div64.S

deps_arch/arm/lib/div64.o := \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/include/linux/kconfig.h \
    $(wildcard include/config/h.h) \
    $(wildcard include/config/.h) \
    $(wildcard include/config/foo.h) \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include/asm/unified.h \
    $(wildcard include/config/arm/asm/unified.h) \
    $(wildcard include/config/thumb2/kernel.h) \
  include/linux/linkage.h \
  include/linux/compiler.h \
    $(wildcard include/config/sparse/rcu/pointer.h) \
    $(wildcard include/config/trace/branch/profiling.h) \
    $(wildcard include/config/profile/all/branches.h) \
    $(wildcard include/config/enable/must/check.h) \
    $(wildcard include/config/enable/warn/deprecated.h) \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include/asm/linkage.h \

arch/arm/lib/div64.o: $(deps_arch/arm/lib/div64.o)

$(deps_arch/arm/lib/div64.o):
