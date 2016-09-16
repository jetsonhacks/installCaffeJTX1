# installCaffeJTX1
Scripts to install Caffe and dependencies on the NVIDIA Jetson TX1 Development Kit.
This script is for L4T 24.2 (Ubuntu 16.04). Look in 'Tags' for earlier versions.

To install, run the installCaffe.sh script
$ ./installCaffe.sh

To maximize the performance of the Jetson TX1, you can use the jetson_clocks.sh script which enables all CPU cores, and maximizes clock speeds on the CPUs and GPU.

For best results, on the Jetson TX1 you should have installed:

L4T 24.2 (Ubuntu 16.04)
OpenCV4Tegra
CUDA 8.0
cuDNN v5.1

Last tested with last Github Caffe commit: 80f44100e19fd371ff55beb3ec2ad5919fb6ac43

