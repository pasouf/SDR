#!/bin/bash
# (v0.1) UHD building script for Xubuntu 16.04 
# Deel - 2017 june 9st - <deel:A:pasouf.com>
# Source : https://github.com/pasouf/USRP
################################################################

basedir=~
sudo apt install -y libboost-all-dev libusb-1.0-0-dev 
sudo apt install -y python-mako doxygen python-docutils cmake build-essential
sudo apt install -y python-requests python-pkgconfig libgps22 libgps-dev libudev-dev libncurses5-dev
cd $basedir
git clone --recursive git://github.com/EttusResearch/uhd.git
cd $basedir/uhd
git submodule init
git submodule update
cd $basedir/uhd/host
mkdir build
cd $basedir/uhd/host/build

# Addition options are required for E100 and E300 support, I only needed GPSD
cmake ../ -DENABLE_GPSD=ON
make
make test
sudo make install
