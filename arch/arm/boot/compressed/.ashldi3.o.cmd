cmd_arch/arm/boot/compressed/ashldi3.o := /home/dman3285/arm-eabi-linaro-4.7/bin/arm-eabi-gcc -Wp,-MD,arch/arm/boot/compressed/.ashldi3.o.d  -nostdinc -isystem /home/dman3285/arm-eabi-linaro-4.7/bin/../lib/gcc/arm-eabi/4.7.2/include -I/home/dman3285/CM10-I927-Kernel/arch/arm/include -Iarch/arm/include/generated -Iinclude  -include /home/dman3285/CM10-I927-Kernel/include/linux/kconfig.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-tegra/include -D__ASSEMBLY__  -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables  -D__LINUX_ARM_ARCH__=7 -march=armv7-a  -include asm/unified.h -msoft-float -gdwarf-2    -Wa,-march=all  -Wa,-march=armv7-a+sec   -c -o arch/arm/boot/compressed/ashldi3.o arch/arm/boot/compressed/ashldi3.S

source_arch/arm/boot/compressed/ashldi3.o := arch/arm/boot/compressed/ashldi3.S

deps_arch/arm/boot/compressed/ashldi3.o := \
  /home/dman3285/CM10-I927-Kernel/include/linux/kconfig.h \
    $(wildcard include/config/h.h) \
    $(wildcard include/config/.h) \
    $(wildcard include/config/foo.h) \
  /home/dman3285/CM10-I927-Kernel/arch/arm/include/asm/unified.h \
    $(wildcard include/config/arm/asm/unified.h) \
    $(wildcard include/config/thumb2/kernel.h) \
  include/linux/linkage.h \
  include/linux/compiler.h \
    $(wildcard include/config/sparse/rcu/pointer.h) \
    $(wildcard include/config/trace/branch/profiling.h) \
    $(wildcard include/config/profile/all/branches.h) \
    $(wildcard include/config/enable/must/check.h) \
    $(wildcard include/config/enable/warn/deprecated.h) \
  /home/dman3285/CM10-I927-Kernel/arch/arm/include/asm/linkage.h \

arch/arm/boot/compressed/ashldi3.o: $(deps_arch/arm/boot/compressed/ashldi3.o)

$(deps_arch/arm/boot/compressed/ashldi3.o):
