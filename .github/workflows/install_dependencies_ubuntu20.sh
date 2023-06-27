#!/bin/bash    
        
sudo apt-get update
sudo apt-get install -y llvm 
sudo apt-get install -y libpcre3 
sudo apt-get install -y libpcre3-dev 
sudo apt-get install -y automake
sudo apt-get install -y build-essential
sudo apt-get install -y libgl1-mesa-dev
sudo apt-get install -y libglu1-mesa-dev
sudo apt-get install -y libxcb-render0-dev
sudo apt-get install -y libdbus-1-dev libnss3-dev
sudo apt-get install -y libxcb-xfixes0-dev
sudo apt-get install -y gperf
sudo apt-get install -y bison flex
sudo apt-get install -y byacc
sudo apt-get install -y libxi-dev libxcomposite-dev libxcursor-dev libxtst-dev 
sudo apt-get install -y libatspi2.0-dev
sudo apt-get install -y libx11-xcb-dev libxcb-util0-dev libxcb-keysyms1-dev libxcb-image0-dev libxcb-shm0-dev libxcb-icccm4-dev libxcb-sync-dev libxcb-render-util0-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev
sudo apt-get install -y libxcomposite-dev
sudo apt-get install -y libdrm-dev
sudo apt-get install -y libxdamage-dev
sudo apt-get install -y libxrandr-dev

# this one is to install numpy using numpy
sudo apt-get install -y libssl-dev

# qt webengine requires python2
sudo apt-get install -y python2
# this is needed because aliasing python=python2 is not enough
sudo apt-get install python-is-python