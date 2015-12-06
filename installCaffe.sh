#!/bin/sh
# Install and compile Caffe on NVIDIA Jetson TX1 Development Kit
# OpenCV4Tegra should already be installed
sudo add-apt-repository universe
sudo apt-get update -y

sudo apt-get install cmake -y
# General Dependencies
sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev \
libhdf5-serial-dev protobuf-compiler -y
sudo apt-get install --no-install-recommends libboost-all-dev -y
# BLAS
sudo apt-get install libatlas-base-dev -y
# Remaining Dependencies
sudo apt-get install libgflags-dev libgoogle-glog-dev liblmdb-dev -y


sudo usermod -a -G video $USER

# Place caffe in the home directory
cd ~/
# Git clone Caffe
git clone https://github.com/BVLC/caffe.git
cd caffe 
cp Makefile.config.example Makefile.config

# Use only 3 cores on L4T 23.1 install ; 
# 4 cores hangs system
make -j 3 all
# Run the tests to make sure everything works
make -j 3 runtest
# The following is a quick timing test ...
build/tools/caffe time --model=models/bvlc_alexnet/deploy.prototxt --gpu=0
