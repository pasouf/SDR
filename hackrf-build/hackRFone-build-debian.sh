#!/bin/bash
# (v0.1) HAckRF builder for Xubuntu 16.04 
# Deel - 2017 june 26th - <deel:A:pasouf.com>
# Source : https://github.com/pasouf/hackrfone
################################################################
sudo apt install -y libnewlib-arm-none-eabi cmake

cd ~
git clone https://github.com/mossmann/hackrf
basedir=~/hackrf
mkdir -p $basedir/host/build
cd $basedir/host/build
cmake ..
make
sudo make install
sudo ldconfig
cd $basedir
git submodule init
git submodule update
cd $basedir/firmware/libopencm3
make
mkdir -p $basedir/firmware/hackrf_usb/build
cd $basedir/firmware/hackrf_usb/build
cmake ..
make
sudo hackrf_info
sudo hackrf_spiflash -w hackrf_usb.bin
