cmd_arch/arm/mm/proc-v7.o := /opt/toolchains/android-toolchain-eabi/bin/arm-eabi-gcc -Wp,-MD,arch/arm/mm/.proc-v7.o.d  -nostdinc -isystem /opt/toolchains/android-toolchain-eabi/bin/../lib/gcc/arm-eabi/4.7.1/include -I/home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include -Iarch/arm/include/generated -Iinclude  -include /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/include/linux/kconfig.h -D__KERNEL__ -mlittle-endian -Iarch/arm/mach-tegra/include -D__ASSEMBLY__ -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables  -D__LINUX_ARM_ARCH__=7 -march=armv7-a  -include asm/unified.h -msoft-float -gdwarf-2     -Wa,-march=armv7-a   -c -o arch/arm/mm/proc-v7.o arch/arm/mm/proc-v7.S

source_arch/arm/mm/proc-v7.o := arch/arm/mm/proc-v7.S

deps_arch/arm/mm/proc-v7.o := \
    $(wildcard include/config/mmu.h) \
    $(wildcard include/config/arm/errata/430973.h) \
    $(wildcard include/config/arm/errata/754322.h) \
    $(wildcard include/config/cpu/use/domains.h) \
    $(wildcard include/config/arm/save/debug/context.h) \
    $(wildcard include/config/pm/sleep.h) \
    $(wildcard include/config/trusted/foundations.h) \
    $(wildcard include/config/smp.h) \
    $(wildcard include/config/arm/errata/458693.h) \
    $(wildcard include/config/arm/errata/460075.h) \
    $(wildcard include/config/arm/errata/716044.h) \
    $(wildcard include/config/arm/errata/720791.h) \
    $(wildcard include/config/arm/errata/742230.h) \
    $(wildcard include/config/arm/errata/742231.h) \
    $(wildcard include/config/arm/errata/743622.h) \
    $(wildcard include/config/arm/errata/751472.h) \
    $(wildcard include/config/arm/errata/752520.h) \
    $(wildcard include/config/cpu/endian/be8.h) \
    $(wildcard include/config/swp/emulate.h) \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/include/linux/kconfig.h \
    $(wildcard include/config/h.h) \
    $(wildcard include/config/.h) \
    $(wildcard include/config/foo.h) \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include/asm/unified.h \
    $(wildcard include/config/arm/asm/unified.h) \
    $(wildcard include/config/thumb2/kernel.h) \
  include/linux/init.h \
    $(wildcard include/config/modules.h) \
    $(wildcard include/config/hotplug.h) \
  include/linux/compiler.h \
    $(wildcard include/config/sparse/rcu/pointer.h) \
    $(wildcard include/config/trace/branch/profiling.h) \
    $(wildcard include/config/profile/all/branches.h) \
    $(wildcard include/config/enable/must/check.h) \
    $(wildcard include/config/enable/warn/deprecated.h) \
  include/linux/linkage.h \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include/asm/linkage.h \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include/asm/assembler.h \
    $(wildcard include/config/cpu/feroceon.h) \
    $(wildcard include/config/trace/irqflags.h) \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include/asm/ptrace.h \
    $(wildcard include/config/arm/thumb.h) \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include/asm/hwcap.h \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include/asm/domain.h \
    $(wildcard include/config/io/36.h) \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include/asm/asm-offsets.h \
  include/generated/asm-offsets.h \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include/asm/pgtable-hwdef.h \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include/asm/pgtable.h \
    $(wildcard include/config/arm/dma/mem/bufferable.h) \
    $(wildcard include/config/proc/fs.h) \
    $(wildcard include/config/highpte.h) \
  include/linux/const.h \
  include/asm-generic/4level-fixup.h \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include/asm/proc-fns.h \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include/asm/glue-proc.h \
    $(wildcard include/config/cpu/arm610.h) \
    $(wildcard include/config/cpu/arm7tdmi.h) \
    $(wildcard include/config/cpu/arm710.h) \
    $(wildcard include/config/cpu/arm720t.h) \
    $(wildcard include/config/cpu/arm740t.h) \
    $(wildcard include/config/cpu/arm9tdmi.h) \
    $(wildcard include/config/cpu/arm920t.h) \
    $(wildcard include/config/cpu/arm922t.h) \
    $(wildcard include/config/cpu/fa526.h) \
    $(wildcard include/config/cpu/arm925t.h) \
    $(wildcard include/config/cpu/arm926t.h) \
    $(wildcard include/config/cpu/arm940t.h) \
    $(wildcard include/config/cpu/arm946e.h) \
    $(wildcard include/config/cpu/sa110.h) \
    $(wildcard include/config/cpu/sa1100.h) \
    $(wildcard include/config/cpu/arm1020.h) \
    $(wildcard include/config/cpu/arm1020e.h) \
    $(wildcard include/config/cpu/arm1022.h) \
    $(wildcard include/config/cpu/arm1026.h) \
    $(wildcard include/config/cpu/xscale.h) \
    $(wildcard include/config/cpu/xsc3.h) \
    $(wildcard include/config/cpu/mohawk.h) \
    $(wildcard include/config/cpu/v6.h) \
    $(wildcard include/config/cpu/v6k.h) \
    $(wildcard include/config/cpu/v7.h) \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include/asm/glue.h \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include/asm/page.h \
    $(wildcard include/config/cpu/copy/v3.h) \
    $(wildcard include/config/cpu/copy/v4wt.h) \
    $(wildcard include/config/cpu/copy/v4wb.h) \
    $(wildcard include/config/cpu/copy/feroceon.h) \
    $(wildcard include/config/cpu/copy/fa.h) \
    $(wildcard include/config/cpu/copy/v6.h) \
    $(wildcard include/config/have/arch/pfn/valid.h) \
  include/asm-generic/getorder.h \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include/asm/memory.h \
    $(wildcard include/config/page/offset.h) \
    $(wildcard include/config/task/size.h) \
    $(wildcard include/config/highmem.h) \
    $(wildcard include/config/dram/size.h) \
    $(wildcard include/config/dram/base.h) \
    $(wildcard include/config/have/tcm.h) \
    $(wildcard include/config/arm/patch/phys/virt.h) \
    $(wildcard include/config/arm/patch/phys/virt/16bit.h) \
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
  arch/arm/mach-tegra/include/mach/memory.h \
    $(wildcard include/config/arch/tegra/2x/soc.h) \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include/asm/sizes.h \
  include/asm-generic/sizes.h \
  include/asm-generic/memory_model.h \
    $(wildcard include/config/flatmem.h) \
    $(wildcard include/config/discontigmem.h) \
    $(wildcard include/config/sparsemem/vmemmap.h) \
    $(wildcard include/config/sparsemem.h) \
  arch/arm/mach-tegra/include/mach/vmalloc.h \
  arch/arm/mm/proc-macros.S \
    $(wildcard include/config/cpu/dcache/writethrough.h) \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include/asm/thread_info.h \
    $(wildcard include/config/arm/thumbee.h) \
  /home/cody/build_kernel/SGH-I927_Kernel/LiteKernel-CM10/arch/arm/include/asm/fpstate.h \
    $(wildcard include/config/vfpv3.h) \
    $(wildcard include/config/iwmmxt.h) \

arch/arm/mm/proc-v7.o: $(deps_arch/arm/mm/proc-v7.o)

$(deps_arch/arm/mm/proc-v7.o):
