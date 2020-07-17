---
layout: post
title: 安装pcl步骤
tags: pcl
category: 3d
---

## 安装pcl步骤

程序包连接

http://v.emdata.cn:3005/uploads/temp/file_share/link/273/ceres-solver.zip

http://v.emdata.cn:3005/uploads/temp/file_share/link/274/colmap.zip

http://v.emdata.cn:3005/uploads/temp/file_share/link/275/pcl-pcl-1.9.1.zip


1. 安装 pcl 依赖库

```bash
sudo apt-get install cmake
# google-glog + gflags
sudo apt-get install -y libgoogle-glog-dev
# BLAS & LAPACK
sudo apt-get install -y  libatlas-base-dev
# Eigen3
sudo apt-get install -y  libeigen3-dev
# SuiteSparse and CXSparse (optional)
# - If you want to build Ceres as a *static* library (the default)
#   you can use the SuiteSparse package in the main Ubuntu package
#   repository:
sudo apt-get install -y  libsuitesparse-dev
# - However, if you want to build Ceres as a *shared* library, you must
#   add the following PPA:
sudo add-apt-repository ppa:bzindovic/suitesparse-bugfix-1319687
sudo apt-get update
sudo apt-get install  -y libsuitesparse-dev


sudo apt install -y libfreeimage-dev libglew-dev



sudo apt install libvtk6.3 libvtk6-dev cmake g++ gcc libeigen3-dev libboost1.65-dev libboost1.65-tools-dev libboost1.65-all-dev
```

2. 分别编译： 
```
	a. ceres-solver 
	b. colmap 
	c. pcl  
```

注 ：a 和 b 的顺序可能需要调换

 
3. 编译步骤:

进入解压后代码目录：

```
mkdir build 

cmake ..

make -j 8

sudo make install

```