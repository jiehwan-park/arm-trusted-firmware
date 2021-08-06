#!/bin/bash

GREEN="\033[1;32m"
NC="\033[0m"

make PLAT=rpi3 clean
# make PLAT=rpi3 fip all 
export CROSS_COMPILE=aarch64-linux-gnu-
make PLAT=rpi3 RPI3_PRELOADED_DTB_BASE=0x10000 PRELOADED_BL33_BASE=0x30000 SUPPORT_VFP=1 RPI3_USE_UEFI_MAP=1 DEBUG=0 LEO_BL33_SECURE=0 fip all

# add this so we can find the resulting image in the next step
# export ATF_BUILD_DIR=$(pwd)/build/rpi3/release
echo -e "\n\n${GREEN}POST : Copy Result files to RPi3 git folder${NC}\n"
sha256sum build/rpi3/release/bl1.bin
sha256sum build/rpi3/release/fip.bin
cp -v build/rpi3/release/bl1.bin ../RPi3/edk2-non-osi/Platform/RaspberryPi/RPi3/TrustedFirmware/
cp -v build/rpi3/release/fip.bin ../RPi3/edk2-non-osi/Platform/RaspberryPi/RPi3/TrustedFirmware/