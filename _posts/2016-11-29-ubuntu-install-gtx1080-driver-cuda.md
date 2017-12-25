---
layout: post
title: Ubuntu 安装NVDGTX1080驱动及CUDA
tags: mysql
category:  mysql windows
---

安装步骤

参考：

http://yangcha.github.io/GTX-1080/

http://www.voidcn.com/blog/autocyz/article/p-6172072.html

>sudo apt-get install build-essential  cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev cmake-gui


把文件全部拷贝到 主目录下

1.  安装 NVIAID 驱动


pressing Ctrl + Alt + F1


>sudo service lightdm stop


>sudo nano /etc/modprobe.d/disable-nouveau.conf

copy this

```
blacklist nouveau optiond nouveau modeset=0
```

then run

>sudo update-initramfs -u

after reboot and your computer start with lower display

>sudo chmod a+x NVIDIA-Linux-x86_64-367.44.run

>sudo ./NVIDIA-Linux-x86_64-367.44.run



2. 安装  cuda_8.0.27_linux.run

>sudo ./cuda_8.0.27_linux.run --override  --tmpdir=/tmp/cuda


 ！！ 提示是否重新安装 NVIDIA  → 否



3. 安装 opencv 3.1

>sudo cmake-gui

选择opencv 源代码 解压的目录

选中左下角 config 按钮 → finsh

下载  ippicv_linux_20151201.tgz  会很慢， 需要拷贝到   /opencv-3.1.0/3rdparty/ippicv/downloads/

>cp  ippicv_linux_20151201.tgz  opencv-3.1.0/3rdparty/ippicv/downloads/linux-808b791a6eac9ed78d32a7666804320e/ippicv_linux_20151201.tgz
>sudo chmod 777 opencv-3.1.0/3rdparty/ippicv/downloads/linux-808b791a6eac9ed78d32a7666804320e/ippicv_linux_20151201.tgz

记得选中 WITH_FFMPEG

>cd builds
>sudo make -j32
>sudo make install -j32



4. 安装 caffe

sudo apt-get install -y build-essential cmake git pkg-config  libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler  libatlas-base-dev libboost-all-dev  libgflags-dev libgoogle-glog-dev liblmdb-dev   python-pip  sudo  python-dev  python-numpy python-scipy


>git clone https://github.com/BVLC/caffe.git  //从github上git caffecd caffe //打开到刚刚git下来的caffe
>sudo cp Makefile.config.example Makefile.config   //将Makefile.config.example的内容复制到Makefile.config


Makefile.config config

```
## Refer to http://caffe.berkeleyvision.org/installation.html
# Contributions simplifying and improving our build system are welcome!

# cuDNN acceleration switch (uncomment to build with cuDNN).
# USE_CUDNN := 1

# CPU-only switch (uncomment to build without GPU support).
# CPU_ONLY := 1

# uncomment to disable IO dependencies and corresponding data layers
# USE_OPENCV := 0
# USE_LEVELDB := 0
# USE_LMDB := 0

# uncomment to allow MDB_NOLOCK when reading LMDB files (only if necessary)
# You should not set this flag if you will be reading LMDBs with any
# possibility of simultaneous read and write
# ALLOW_LMDB_NOLOCK := 1

# Uncomment if you're using OpenCV 3
 OPENCV_VERSION := 3

# To customize your choice of compiler, uncomment and set the following.
# N.B. the default for Linux is g++ and the default for OSX is clang++
# CUSTOM_CXX := g++

# CUDA directory contains bin/ and lib/ directories that we need.
CUDA_DIR := /usr/local/cuda
# On Ubuntu 14.04, if cuda tools are installed via
# "sudo apt-get install nvidia-cuda-toolkit" then use this instead:
# CUDA_DIR := /usr

# CUDA architecture setting: going with all of them.
# For CUDA < 6.0, comment the *_50 lines for compatibility.
CUDA_ARCH := -gencode arch=compute_20,code=sm_20 \
    -gencode arch=compute_20,code=sm_21 \
    -gencode arch=compute_30,code=sm_30 \
    -gencode arch=compute_35,code=sm_35 \
    -gencode arch=compute_50,code=sm_50 \
    -gencode arch=compute_50,code=compute_50

# BLAS choice:
# atlas for ATLAS (default)
# mkl for MKL
# open for OpenBlas
BLAS := atlas
# Custom (MKL/ATLAS/OpenBLAS) include and lib directories.
# Leave commented to accept the defaults for your choice of BLAS
# (which should work)!
# BLAS_INCLUDE := /path/to/your/blas
# BLAS_LIB := /path/to/your/blas

# Homebrew puts openblas in a directory that is not on the standard search path
# BLAS_INCLUDE := $(shell brew --prefix openblas)/include
# BLAS_LIB := $(shell brew --prefix openblas)/lib

# This is required only if you will compile the matlab interface.
# MATLAB directory should contain the mex binary in /bin.
# MATLAB_DIR := /usr/local
# MATLAB_DIR := /Applications/MATLAB_R2012b.app

# NOTE: this is required only if you will compile the python interface.
# We need to be able to find Python.h and numpy/arrayobject.h.
PYTHON_INCLUDE := /usr/include/python2.7 \
    /usr/lib/python2.7/dist-packages/numpy/core/include
# Anaconda Python distribution is quite popular. Include path:
# Verify anaconda location, sometimes it's in root.
# ANACONDA_HOME := $(HOME)/anaconda
# PYTHON_INCLUDE := $(ANACONDA_HOME)/include \
    # $(ANACONDA_HOME)/include/python2.7 \
    # $(ANACONDA_HOME)/lib/python2.7/site-packages/numpy/core/include \

# Uncomment to use Python 3 (default is Python 2)
# PYTHON_LIBRARIES := boost_python3 python3.5m
# PYTHON_INCLUDE := /usr/include/python3.5m \
#                 /usr/lib/python3.5/dist-packages/numpy/core/include

# We need to be able to find libpythonX.X.so or .dylib.
PYTHON_LIB := /usr/lib
# PYTHON_LIB := $(ANACONDA_HOME)/lib

# Homebrew installs numpy in a non standard path (keg only)
# PYTHON_INCLUDE += $(dir $(shell python -c 'import numpy.core; print(numpy.core.__file__)'))/include
# PYTHON_LIB += $(shell brew --prefix numpy)/lib

# Uncomment to support layers written in Python (will link against Python libs)
# WITH_PYTHON_LAYER := 1

# Whatever else you find you need goes here.
INCLUDE_DIRS := $(PYTHON_INCLUDE) /usr/local/include /usr/include/hdf5/serial
LIBRARY_DIRS := $(PYTHON_LIB) /usr/local/lib /usr/lib /usr/lib/x86_64-linux-gnu/hdf5/serial

# If Homebrew is installed at a non standard location (for example your home directory) and you use it for general dependencies
# INCLUDE_DIRS += $(shell brew --prefix)/include
# LIBRARY_DIRS += $(shell brew --prefix)/lib

# Uncomment to use `pkg-config` to specify OpenCV library paths.
# (Usually not necessary -- OpenCV libraries are normally installed in one of the above $LIBRARY_DIRS.)
# USE_PKG_CONFIG := 1

# N.B. both build and distribute dirs are cleared on `make clean`
BUILD_DIR := build
DISTRIBUTE_DIR := distribute

# Uncomment for debugging. Does not work on OSX due to https://github.com/BVLC/caffe/issues/171
# DEBUG := 1

# The ID of the GPU that 'make runtest' will use to run unit tests.
TEST_GPUID := 0

# enable pretty build (comment to see full commands)
Q ?= @
```








- other

sudo updatedb
locate  hdf5.h


## install fcitx
>sudo apt-get install fcitx fcitx-googlepinyin fcitx-ui-classic fcitx-module-kimpanel




ERROR: The Nouveau kernel driver is currently in use by your system. This

  driver is incompatible with the NVIDIA driver……”之类的错误。


　Nouveau是由第三方为NVIDIA显卡开发的一个开源3D驱动，也没能得到NVIDIA的认可与支持。虽然Nouveau Gallium3D在游戏速度上还远远无法和NVIDIA官方私有驱动相提并论，不过确让Linux更容易的应对各种复杂的NVIDIA显卡环境，让用户安装完系统即可进入桌面并且有不错的显示效果，所以，很多Linux发行版默认集成了Nouveau驱动，在遇到NVIDIA显卡时默认安装。企业版的Linux更是如此，几乎所有支持图形界面的企业Linux发行版都将Nouveau收入其中。


　　不过对于个人桌面用户来说，处于成长阶段的Nouveau并不完美，与企业版不一样，个人用户除了想让正常显示图形界面外很多时候还需要一些3D特效，Nouveau多数时候并不能完成，而用户在安装NVIDIA官方私有驱动的时候Nouveau又成为了阻碍，不干掉Nouveau安装时总是报错。报错提示见文第一段。


------


blacklist nouveau
blacklist lbm-nouveau
blacklist nvidia-173
blacklist nvidia-96
blacklist nvidia-current
blacklist nvidia-173-updates
blacklist nvidia-96-updates
alias nvidia nvidia_current_updates
alias nouveau off
alias lbm-nouveau off







## 更新完显卡驱动后登录界面进入死循环, 输入密码无法登录…

```sh
CTRL+ALT+F1

sudo apt remove nvidia-*
sudo apt autoremove
sudo nvidia-uninstall
sudo reboot
#重新安装显卡驱动

```
