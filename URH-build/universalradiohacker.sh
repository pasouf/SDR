#!/bin/bash
# (v0.1) Universal Radio Hacker builder for Xubuntu 16.04 
# Deel - 2017 june 26th - <deel:A:pasouf.com>
# Source : https://github.com/pasouf/universalradiohacker
################################################################
cd ~
sudo apt install -y libairspy-dev libhackrf-dev librtlsdr-dev libuhd-dev
sudo apt install -y python3-numpy python3-psutil python3-zmq python3-pyqt5 g++ libpython3-dev python3-pip
sudo pip3 install --upgrade pip
sudo pip3 install urh
sudo pip3 install --upgrade urh
