cmd_drivers/regulator/built-in.o :=  /opt/toolchains/android-toolchain-eabi/bin/arm-eabi-ld -EL    -r -o drivers/regulator/built-in.o drivers/regulator/core.o drivers/regulator/dummy.o drivers/regulator/fixed.o drivers/regulator/virtual.o drivers/regulator/max8952n1.o drivers/regulator/max8907c-regulator.o 
