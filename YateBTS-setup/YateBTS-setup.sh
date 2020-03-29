#!/bin/bash
# (v0.5) YateBTS installer script for Xubuntu 16.04 
# Deel - 2017 june 15th - <deel:A:pasouf.com>
# Source : https://github.com/pasouf/USRP
# Source : https://randomkeystrokes.com/2016/07/01/installing-yatebts-on-a-clean-ubuntu-install-16-04-lts/
################################################################

# Prerequisites, prerequisites, prerequisites
sudo apt update && sudo apt upgrade -y
sudo apt install -y subversion autoconf libgsm1-dev libgusb-dev
mkdir ~/tools

# Yate  Install
cd ~/tools
svn checkout http://voip.null.ro/svn/yate/trunk yate
cd yate
./autogen.sh
./configure
sudo make install-noapi
sudo ldconfig
which -a yate-config 

# YateBTS Install
cd ~/tools
svn checkout http://voip.null.ro/svn/yatebts/trunk yatebts
cd yatebts
./autogen.sh
./configure
sudo make install
sudo ldconfig

# System staging
sudo addgroup yate
sudo usermod -a -G yate $(whoami)
sudo touch /usr/local/etc/yate/snmp_data.conf /usr/local/etc/yate/tmsidata.conf
sudo chown root:yate /usr/local/etc/yate/*.conf
sudo chmod g+w /usr/local/etc/yate/*.conf
sudo sed -i 's/Radio.Band=/Radio.Band=900/' /usr/local/etc/yate/ybts.conf
sudo sed -i 's/Radio.C0=/Radio.C0=0/' /usr/local/etc/yate/ybts.conf
sudo sed -i 's/;Identity.MCC/Identity.MCC/' /usr/local/etc/yate/ybts.conf
sudo sed -i 's/;port=161/port=20161/' /usr/local/etc/yate/ysnmpagent.conf
sudo sed -i 's/;remote_port=162/remote_port=20162/' /usr/local/etc/yate/ysnmpagent.conf
sudo sed -i 's/;country_code=/country_code=33/' /usr/local/etc/yate/subscribers.conf
# This last command allows everyone to bind to our BTS
sudo sed -i 's/;regexp=/regexp=/' /usr/local/etc/yate/subscribers.conf

# This has to be done manually
#Add "@yate hard nice -20" To /etc/security/limits.conf
#Add "@yate hard rtprio 99" To /etc/security/limits.conf

# Let's launch Yate and test
#yate
#telnet localhost 5038
#nib list registered (list registered devices)
#nib list rejected (list rejected devices)

#Try and connect to the “101” 2G network on your two test devices
#Take your two test IMSI numbers from nib list rejected and add regexp= to /usr/local/etc/yate/subscribers.conf
#Now you can make calls to each other with your allocated phone numbers (you will recieve an sms when you join the network) or text ELIZA questions on 35492
