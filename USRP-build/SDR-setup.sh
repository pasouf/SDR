#!/bin/bash
# (v0.3) USRP system environment installer script for Xubuntu 16.04 
# Deel - 2017 june 1st - <deel:A:pasouf.com>
# Source : https://github.com/pasouf/USRP
################################################################
$basedir=~
sudo apt update && sudo apt upgrade

# Required dependencies
sudo apt install -y libuhd-dev libuhd003 uhd-host
sudo apt install -y gqrx-sdr gnuradio libgnuradio*
sudo apt-get clean

# Recommended for performance 
sudo apt install -y libvolk1.1 libvolk1-bin libvolk1-dev
volk_profile

#Specific setup gor gnuradio-companion
if [ -d ~/.gnuradio ]; then
  echo xterm_executable = $(which xterm) >> ~/.gnuradio/config.conf
else
  mkdir ~/.gnuradio
  echo xterm_executable = $(which xterm) >> ~/.gnuradio/config.conf
fi

# Get UHD images for B210
sudo uhd_images_downloader
