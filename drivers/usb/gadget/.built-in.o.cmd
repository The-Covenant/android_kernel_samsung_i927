cmd_drivers/usb/gadget/built-in.o :=  /opt/toolchains/android-toolchain-eabi/bin/arm-eabi-ld -EL    -r -o drivers/usb/gadget/built-in.o drivers/usb/gadget/udc-core.o drivers/usb/gadget/fsl_usb2_udc.o drivers/usb/gadget/g_android.o drivers/usb/gadget/multi_config.o 
