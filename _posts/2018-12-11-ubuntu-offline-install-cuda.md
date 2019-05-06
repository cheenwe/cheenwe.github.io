---
layout: post
title: ubuntu16.04 离线配置算法环境
tags:    cuda  
category:   ubuntu
---


## 挂载硬盘
```
sudo fdisk -l

sudo mount /dev/sdd1 /mnt
``` 

 

##  1.离线下载安装包

```
# packages="libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler libopenblas-dev liblapack-dev libatlas-base-dev libgflags-dev libgoogle-glog-dev liblmdb-dev git cmake build-essential"

# opencv_pkgs="libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev"

# sudo apt-get  -d install --no-install-recommends libboost-all-dev
# 
opencv_pkgs="liblapacke-dev checkinstall "


j=0
for pkg in $opencv_pkgs 
do  
    j=$(($j+1))
    folder_name="${j}_${pkg}"
    echo $folder_name

    sudo apt -d install $pkg
    mkdir -p $folder_name
    sudo mv /var/cache/apt/archives/*.deb $folder_name
done

```

##2.离线安装

```
#!bin/sh
for file in ./*
do
    sudo dpkg -i $file/*

    echo ""
    echo ""
    echo "================== ${file} install success!"
    echo ""
    echo ""
    # if test -f $file
    # then
    #     echo $file 是文件
    # fi
    # if test -d $file
    # then
    #     echo $file 是目录
    # fi
done

```


## 3. install nvd driver

##  4. install cuda

sudo ./cuda_8.0.61_375.26_linux.run --no-opengl-libs --override 

```

sudo nano /etc/profile 

# copy this two lines

export PATH=/usr/local/cuda-8.0/bin:$PATH   
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH   

source  /etc/profile #加载环境

# install cudnn

sudo cp cuda/include/cudnn.h /usr/local/cuda/include/ #复制头文件
sudo cp cuda/lib64/lib* /usr/local/cuda/lib64/

cd /usr/local/cuda/lib64/ && sudo rm -rf libcudnn.so libcudnn.so.7 #删除原有动态文件

sudo ln -s libcudnn.so.6.0.21   libcudnn.so.6
sudo ln -s  libcudnn.so.6 libcudnn.so

sudo ldconfig

locate libcudnn.so

nvcc -V 
```

## others

```
查看 CUDA 版本：

 cat /usr/local/cuda/version.txt

查看 CUDNN 版本：

 cat /usr/local/cuda/include/cudnn.h | grep CUDNN_MAJOR -A 2

查看 显卡驱动 版本：

  cat /proc/driver/nvidia/version 

```

## install opencv 

```

mkdir -p build/3rdparty

tar zxf ippicv.tar
mv ippicv  build/3rdparty/

cd build
cmake -D CMAKE_BUILD_TYPE=Release -D WITH_CUDA=OFF  ..

make -j64 #编译

sudo make install #安装opencv


sudo ldconfig

pkg-config --modversion opencv
```

