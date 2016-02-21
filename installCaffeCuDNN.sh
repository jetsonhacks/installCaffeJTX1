#!/bin/sh
# Script for installing Caffe with cuDNN support on Jetson TX1 Development Kitls
# 2-21-16 JetsonHacks.com
# MIT License
# Install and compile Caffe on NVIDIA Jetson TX1 Development Kit
# Prerequisites (which can be installed with JetPack 2):
# OpenCV4Tegra
# cuDNN v4
sudo add-apt-repository universe
sudo apt-get update -y
/bin/echo -e "\e[1;32mLoading Caffe Dependencies.\e[0m"
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
/bin/echo -e "\e[1;32mCloning Caffe into the home directory\e[0m"
# Place caffe in the home directory
cd ~/
# Git clone Caffe
git clone https://github.com/BVLC/caffe.git
cd caffe 
cp Makefile.config.example Makefile.config
# Enable cuDNN usage
sudo sed -i 's/# USE_CUDNN := 1/USE_CUDNN := 1/' Makefile.config
# Dec. 7, 2015; This only appears in once place currently
# This is a 32 bit OS LMDB_MAP_SIZE needs to be reduced from
# 1099511627776 to 536870912
git grep -lz 1099511627776 | xargs -0 sed -i 's/1099511627776/536870912/g'
# Change the comment too
git grep -lz "// 1TB" | xargs -0 sed -i 's:// 1TB:// 1/2TB:g'
# Use only 3 cores on L4T 23.1 install ; 
# 4 cores hangs system
/bin/echo -e "\e[1;32mCompiling Caffe\e[0m"
make -j 3 all
# Run the tests to make sure everything works
/bin/echo -e "\e[1;32mRunning Caffe Tests\e[0m"
make -j 3 runtest
# The following is a quick timing test ...
# build/tools/caffe time --model=models/bvlc_alexnet/deploy.prototxt --gpu=0
