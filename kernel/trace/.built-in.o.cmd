cmd_kernel/trace/built-in.o :=  /opt/toolchains/android-toolchain-eabi/bin/arm-eabi-ld -EL    -r -o kernel/trace/built-in.o kernel/trace/trace_clock.o kernel/trace/ring_buffer.o 
