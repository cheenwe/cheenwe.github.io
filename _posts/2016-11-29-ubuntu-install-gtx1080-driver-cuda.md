---
layout: post
title: Ubuntu 安装NVDGTX1080驱动及CUDA
tags: ubuntu gtx1080 cuda
category:  nvidia
---

# ubuntu 16.04 gtx1080 配置 cuda caffee 环境


	# 全部安装文件在 smb://192.168.100.229/00.共享软件/00-2018-ubuntu-gt1080-install-cuda-caffe

	# 重装 N 次系统后经验总结。 注意安装系统版本，

	# 参考 https://blog.csdn.net/yhaolpz/article/details/71375762

	# - write by chenwei 20180724

## 1.安装依赖

		sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler liblapacke-dev checkinstall

		sudo apt-get install --no-install-recommends libboost-all-dev

		sudo apt-get install libopenblas-dev liblapack-dev libatlas-base-dev

		sudo apt-get install libgflags-dev libgoogle-glog-dev liblmdb-dev

		sudo apt-get install git cmake build-essential


## 2.禁用 nouveau

		sudo nano /etc/modprobe.d/blacklist-nouveau.conf

		# copy
			blacklist nouveau option nouveau modeset=0

		sudo update-initramfs -u

## 3.配置环境变量
 # 在文件 ~/.bashrc 最后加入以下两行内容：

		sudo echo 'export LD_LIBRARY_PATH=/usr/lib/
		x86_64-linux-gnu:$LD_LIBRARY_PATH' >> ~/.bashrc

		sudo echo 'export LD_LIBRARY_PATH=/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH' >> ~/.bashrc


## 安装 CUDA 8.0
		sudo service lightdm stop

		 # Ctrl + Alt + F1 进入文本模式，输入帐号密码登录

		sudo bash installcuda


		 #执行此命令约1分钟后会出现 0%信息，此时长按空格键让此百分比增长，直到100%，然后按照提示操作即可，先输入 accept ，然后让选择是否安装 nvidia 驱动，这里的选择对应第5步开头，若未安装则输入 “y”，若确保已安装正确驱动则输入“n”。

		 #剩下的选择则都输入“y”确认安装或确认默认路径安装，开始安装，此时若出现安装失败提示则可能为未关闭桌面服务或在已安装 nvidia 驱动的情况下重复再次安装 nvidia 驱动，安装完成后输入重启命令重启：

		 #确保安装后没有报错


 #在 ~/.bashrc 文件最后加入以下两行并保存：

		sudo echo 'export PATH=/usr/local/cuda-8.0/bin:$PATH' >> ~/.bashrc

		sudo echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc

		source ~/.bashrc

## 验证 CUDA 8.0 是否安装成功

		cd /usr/local/cuda-8.0/samples/1_Utilities/deviceQuery

		sudo make

		./deviceQuery


## 安装 cudnn
 #解压 cudnn-8.0-linux-x64-v6.0.tgz , 出现 cuda 目录

sudo cp cuda/include/cudnn.h /usr/local/cuda/include/ #复制头文件

sudo cp cuda/lib64/lib* /usr/local/cuda/lib64/

# 这里需要注意版本号
		cd /usr/local/cuda/lib64/ && sudo rm -rf libcudnn.so libcudnn.so.6 #删除原有动态文件

		sudo ln -s libcudnn.so.6.0.21 libcudnn.so.6

		sudo ln -s  libcudnn.so.6 libcudnn.so

		#sudo ln -s libcudnn.so.5.1.5 libcudnn.so.5 #生成软衔接

		locate libcudnn.so

		nvcc -V


## 安装opencv3.2
		 #解压并进入目录

		mkdir build # 创建编译的文件目录

		cd build

		cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..

		make -j64 #编译

		sudo make install #安装

		pkg-config --modversion opencv


## 安装 caffe
	#解压并进入目录


```
pip install pip -U
sudo pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

for req in $(cat requirements.txt); do sudo pip install $req; done
```

		sudo nano  /usr/local/cuda/include/host_config.h

 #将
		#error-- unsupported GNU version! gcc versions later than 5.0 are not supported!

 #改为
		//#error-- unsupported GNU version! gcc versions later than 5.0 are not supported!

		make all -j64


		make runtest -j8 #结果 pass 才成功

		sudo apt-get install ffmpeg

## 安装 pycaffe notebook 接口环境

		sudo apt-get install python-numpy python-pip python-dev   python-scipy  gfortran

		sudo make pycaffe -j8

		sudo echo export PYTHONPATH="~/caffe/python" >> ~/.bashrc

		 #进入 caffee 目录下 python 文件夹

		cd caffe/python

		sudo pip install ipython==3.2.1

		for req in $(cat requirements.txt); do sudo pip install $req; done

		sudo pip install -r requirements.txt

		 # 安装成功的，都会显示Requirement already satisfied, 没有安装成功的，先apt remove xxx 卸载,再安装。

		 #安装 jupyter ：#

		sudo pip install jupyter


		 # Cannot uninstall 'pyzmq'. It is

		sudo apt remove python-zmq


		 #安装完成后运行 notebook :

		jupyter notebook

		 # 或

		ipython notebook


## 安装cuda报错

### cuda missing recommended library libGLU.so

		sudo apt-get install freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libgl1-mesa-glx libglu1-mesa libglu1-mesa-dev


### ImportError: cannot import name main when running pip

		nano /usr/bin/pip


		from pip import __main__
		if __name__ == '__main__':
				sys.exit(__main__._main())






# install cuda9 cudnn7.0

		sudo ./cuda_9.0.176_384.81_linux.run --no-opengl-libs --override

		sudo echo 'export PATH=/usr/local/cuda-9.0/bin:$PATH' >> ~/.bashrc
		sudo echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc

		source ~/.bashrc

		sudo cp cudnn7.0/include/cudnn.h /usr/local/cuda/include/ #复制头文件
		sudo cp cudnn7.0/lib64/lib* /usr/local/cuda/lib64/

		cd /usr/local/cuda/lib64/ && sudo rm -rf libcudnn.so libcudnn.so.7 #删除原有动态文件
		sudo ln -s libcudnn.so.7.0.5   libcudnn.so.7
		sudo ln -s  libcudnn.so.7 libcudnn.so

		locate libcudnn.so

		nvcc -V



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

