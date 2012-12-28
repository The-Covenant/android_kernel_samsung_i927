cmd_.tmp_kallsyms2.o := /home/dman3285/arm-eabi-linaro-4.7/bin/arm-eabi-gcc -Wp,-MD,./..tmp_kallsyms2.o.d -D__ASSEMBLY__  -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables  -D__LINUX_ARM_ARCH__=7 -march=armv7-a  -include asm/unified.h -msoft-float -gdwarf-2    -nostdinc -isystem /home/dman3285/arm-eabi-linaro-4.7/bin/../lib/gcc/arm-eabi/4.7.2/include -I/home/dman3285/CM10-I927-Kernel/arch/arm/include -Iarch/arm/include/generated -Iinclude  -include /home/dman3285/CM10-I927-Kernel/include/linux/kconfig.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-tegra/include    -c -o .tmp_kallsyms2.o .tmp_kallsyms2.S

source_.tmp_kallsyms2.o := .tmp_kallsyms2.S

deps_.tmp_kallsyms2.o := \
  /home/dman3285/CM10-I927-Kernel/arch/arm/include/asm/unified.h \
    $(wildcard include/config/arm/asm/unified.h) \
    $(wildcard include/config/thumb2/kernel.h) \
  /home/dman3285/CM10-I927-Kernel/include/linux/kconfig.h \
    $(wildcard include/config/h.h) \
    $(wildcard include/config/.h) \
    $(wildcard include/config/foo.h) \
  /home/dman3285/CM10-I927-Kernel/arch/arm/include/asm/types.h \
  include/asm-generic/int-ll64.h \
  /home/dman3285/CM10-I927-Kernel/arch/arm/include/asm/bitsperlong.h \
  include/asm-generic/bitsperlong.h \
    $(wildcard include/config/64bit.h) \

.tmp_kallsyms2.o: $(deps_.tmp_kallsyms2.o)

$(deps_.tmp_kallsyms2.o):
