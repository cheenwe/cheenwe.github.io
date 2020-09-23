## 环境变量
cat ~/.bashrc
```
export PATH=/usr/local/cuda-10.2/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH



#export PATH=/root/.local/bin:$PATH


export LD_LIBRARY_PATH=/root/caffe/build/install/lib:/usr/local/lib:/usr/lib/x86_64-linux-gnu/hdf5/serial:/usr/local/cuda-10.2/lib64:$LD_LIBRARY_PATH

export PYTHONPATH=/root/caffe/python:$PYTHONPATH
```
### python
echo $PYTHONPATH
python -c "import sys; print(sys.path)"

问题, 全部安装完成,启动时提示
ImportError: numpy.core.multiarray failed to import
网上说是 numpy 版本过低, 升级后提示 caffe_root 找不到.




Name: numpy
Version: 1.14.0

numpy-1.16.5

pip install --upgrade numpy
pip install numpy --upgrade --force


## ImportError: cannot import name '_validate_lengths'

pip install --upgrade scikit-image



#Ubuntu更新附加驱动Nvidia源


sudo add-apt-repository ppa:graphics-drivers/ppa && sudo apt update
 apt install nvidia-driver-430

## DIGITS

DIGITS_ROOT=~/digits
git clone https://github.com/NVIDIA/DIGITS.git $DIGITS_ROOT


sudo apt-get install --no-install-recommends git graphviz python-dev python-flask python-flaskext.wtf python-gevent python-h5py python-numpy python-pil python-pip python-scipy python-tk


pip install --upgrade pip

```
#!/usr/bin/python
# GENERATED BY DEBIAN

import sys

# Run the main entry point, similarly to how setuptools does it, but because
# we didn't install the actual entry point from setup.py, don't use the
# pkg_resources API.
from pip import __main__
if __name__ == '__main__':
    sys.exit(__main__._main())
```

pip install setuptools

 sudo pip install -r $DIGITS_ROOT/requirements.txt

sudo pip install -e $DIGITS_ROOT



## install cuda
# https://developer.nvidia.com/cuda-downloads
wget http://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_440.33.01_linux.run

sudo sh cuda_10.2.89_440.33.01_linux.run

### Environment
1. Add an entry to /etc/ld.so.conf.d/.
* This requires sudo privileges. echo "/usr/local/cuda/lib64" | sudo tee /etc/ld.so.conf.d/cuda64.conf
* sudo ldconfig
* 
2. Edit LD_LIBRARY_PATH.
* This does not require sudo privileges. 
* The exact formula required depends on which shell you are using and how you login to your machine. # Login shell
* echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64" >> ~/.profile && source ~/.profile
*
* # Non-login interactive shell (bash)
* echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64" >> ~/.bashrc && source ~/.bashrc  
* Further reading on setting persistent environment variables:
    * http://unix.stackexchange.com/q/117467/99570
    * http://askubuntu.com/q/210884/336440


Please make sure that
 -   PATH includes /usr/local/cuda-10.2/bin
 -   LD_LIBRARY_PATH includes /usr/local/cuda-10.2/lib64, or, add /usr/local/cuda-10.2/lib64 to /etc/ld.so.conf and run ldconfig as root

To uninstall the CUDA Toolkit, run cuda-uninstaller in /usr/local/cuda-10.2/bin


##cuDNN

https://developer.download.nvidia.cn/compute/machine-learning/cudnn/secure/v7.3.0/prod/9.0_2018920/Ubuntu16_04-x64/libcudnn7_7.3.0.29-1%2Bcuda9.0_amd64.deb

https://developer.nvidia.com/compute/machine-learning/cudnn/secure/7.6.5.32/Production/10.2_20191118/Ubuntu18_04-x64/libcudnn7-dev_7.6.5.32-1%2Bcuda10.2_amd64.deb

sudo dpkg -I *.deb


## protobuf3

sudo apt-get install autoconf automake libtool curl make g++ git python-dev python-setuptools unzip

export PROTOBUF_ROOT=~/protobuf
git clone https://github.com/google/protobuf.git $PROTOBUF_ROOT -b '3.2.x'

cd $PROTOBUF_ROOT
./autogen.sh
./configure
make "-j$(nproc)"
make install
ldconfig
cd python
python setup.py install --cpp_implementation


## CAFFE
https://github.com/NVIDIA/DIGITS/blob/master/docs/BuildCaffe.md

#Libturbojpeg library is used since 0.16.5. It has a packaging bug. Please execute the following (required for Makefile, optional for CMake):
sudo apt-get install libturbojpeg
sudo ln -s /usr/lib/x86_64-linux-gnu/libturbojpeg.so.0.1.0 /usr/lib/x86_64-linux-gnu/libturbojpeg.so


sudo apt-get install --no-install-recommends build-essential cmake git gfortran libatlas-base-dev libboost-filesystem-dev libboost-python-dev libboost-system-dev libboost-thread-dev libgflags-dev libgoogle-glog-dev libhdf5-serial-dev libleveldb-dev liblmdb-dev libopencv-dev libsnappy-dev python-all-dev python-dev python-h5py python-matplotlib python-numpy python-opencv python-pil python-pip python-pydot python-scipy python-skimage python-sklearn libssl-dev



export CAFFE_ROOT=~/caffe
git clone https://github.com/NVIDIA/caffe.git $CAFFE_ROOT -b 'caffe-0.15'

sudo pip install -r $CAFFE_ROOT/python/requirements.txt

cat $CAFFE_ROOT/python/requirements.txt | xargs -n1 sudo pip install


cd $CAFFE_ROOT
mkdir build
cd build
cmake ..
make -j"$(nproc)"
make install
 make pycaffe


## Torch with cuda10

## install cmake
apt install openssl libssl-dev

$ sudo apt-get purge cmake
$ git clone https://github.com/Kitware/CMake.git
$ cd CMake
$ ./bootstrap; make; sudo make install


$ cd ~/torch
$ rm -fr cmake/3.6/Modules/FindCUDA*

https://github.com/torch/cutorch/issues/834





export TORCH_ROOT=~/torch

git clone https://github.com/torch/distro.git $TORCH_ROOT --recursive
cd $TORCH_ROOT
./install-deps #修改修改 install-deps

./install.sh -b
source ~/.bashrc


./clean.sh

export TORCH_NVCC_FLAGS="-D__CUDA_NO_HALF_OPERATORS__"
./install.sh



**** Installing (Lua)Torch on Ubuntu 16.04.5 LTS (Updated as 27/12/2018)
This is a tutorial to installing Torch on Ubuntu 16.04 for use with the new NVIDIA RTX20x0 GPUs (older GPUs such as GTX10x0 shall be supported as well). This tutorial addresses the problem of Torch being in mainteinance mode, officially not being able to run on RTX GPUs due to a complex chain of dependencies (look at this thread for more information #834). This tutorial will guide you from installing the NVIDIA kernel drivers to getting a working Torch version on RTX NVIDIA GPUs. Notice that GCC v 5 or 6 is assumed to be the default compiler; if not, use update-alternatives to set the correct GCC/G++ pair version (see https://askubuntu.com/questions/26498/how-to-choose-the-default-gcc-and-g-version).
* I recommend disabling automatic package update to prevent NVIDIA kernel module to be updated (see also https://www.garron.me/en/linux/turn-off-stop-ubuntu-automatic-update.html) Using your favorite editor open the file /etc/apt/apt.conf.d/10periodic and change: APT::Periodic::Update-Package-Lists "1"; To: APT::Periodic::Update-Package-Lists "0"; 
* Install lates drivers from NVIDIA (410.78 in Nov 2018) supporting RTX GPUs as debs from NVIDIA website (see also http://www.linuxandubuntu.com/home/how-to-install-latest-nvidia-drivers-in-linux) sudo apt-get purge nvidia* sudo add-apt-repository ppa:graphics-drivers sudo apt-get update sudo apt-get install nvidia-410 
* Reboot your computer or load the NVIDIA drivers sudo modprobe nvidia 
* Download the CUDA metapackage that will add to your APT sources CUDA 8.0 -> 10.0 (repo key addition may be needed) and install CUDA 10.0 $wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-10-0_10.0.130-1_amd64.deb sudo dpkg -i cuda-10-0_10.0.130-1_amd64.deb sudo apt update sudo apt install cuda-10-0 
* If needed, link the cuda 10.0 version in /usr/local: cd /usr/local; sudo ln -s cuda-10.0/ cuda 
* Verify that the CUDA compiler has been installed successfully: /usr/local/cuda/bin/nvcc --version nvcc: NVIDIA (R) Cuda compiler driver Copyright (c) 2005-2018 NVIDIA Corporation Built on Sat_Aug_25_21:08:01_CDT_2018 Cuda compilation tools, release 10.0, V10.0.130 
* If behind a proxy, tell git to use the HTTPS protocol in place of GIT: git config --global url."https://github.com/".insteadOf git@github.com: git config --global url."https://".insteadOf git:// 
* Optionally install libblas3 to avoid torch checking out and building its own copy of the BLAS library sudo apt install libblas3 
* Checkout Nagadomi's Torch branch with the patched cunn for cuda 10 support (see also the standard torch building procedure as documented in http://torch.ch/docs/getting-started.html): git clone https://github.com/nagadomi/distro.git ~/torch --recursive cd ~/torch; bash install-deps; ./install.sh 
* Download from the NVIDIA developers FTP server the latest libcudnn for cuda 10 (libcudnn7_7.4.1.5-1+cuda10.0_amd64.deb at the moment of the writing of this document), save it and install it sudo dpkg -i libcudnn7_7.4.1.5-1+cuda10.0_amd64.deb 
* Check out in a separate position Soumith's patched cudnn for libcudnn7: git clone https://github.com/soumith/cudnn.torch.git -b R7 && cd cudnn.torch && luarocks make cudnn-scm-1.rockspec 
* That's it, now login and logout and test if everything works correctly: th th> require 'cudnn' 



apt install luarocks

## TensorFlow

pip install tensorflow-gpu==1.2.1




测试安装正常:
python -c "import tensorflow as tf; print(tf.reduce_sum(tf.random.normal([1000, 1000])))"

如有报错安装新版:

pip install tensorflow-gpu==1.15

### Protobuf 3

sudo apt-get install autoconf automake libtool curl make g++ git python-dev python-setuptools unzip


# example location - can be customized
export PROTOBUF_ROOT=~/protobuf
git clone https://github.com/google/protobuf.git $PROTOBUF_ROOT -b '3.2.x'
cd $PROTOBUF_ROOT
./autogen.sh
./configure
make "-j$(nproc)"
make install
ldconfig
cd python
sudo python setup.py install --cpp_implementation








https://github.com/NVIDIA/DIGITS/blob/master/docs/BuildDigits.md

# Building DIGITS

The following instructions will walk you through building the latest version of DIGITS from source.
**These instructions are for installation on Ubuntu 14.04 and 16.04.**

Alternatively, see [this guide](BuildDigitsWindows.md) for setting up DIGITS and Caffe on Windows machines.

Other platforms are not officially supported, but users have successfully installed DIGITS on Ubuntu 12.04, CentOS, OSX, and possibly more.
Since DIGITS itself is a pure Python project, installation is usually pretty trivial regardless of the platform.
The difficulty comes from installing all the required dependencies for Caffe, Torch7 , Tensorflow, and configuring the builds.
Doing so is your own adventure.

## Prerequisites

You need an NVIDIA driver ([details and instructions](InstallCuda.md#driver)).

Run the following commands to get access to some package repositories:
```sh
# For Ubuntu 14.04
CUDA_REPO_PKG=http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/cuda-repo-ubuntu1404_8.0.61-1_amd64.deb
ML_REPO_PKG=http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1404/x86_64/nvidia-machine-learning-repo-ubuntu1404_4.0-2_amd64.deb

# For Ubuntu 16.04
CUDA_REPO_PKG=http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
ML_REPO_PKG=http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb

# Install repo packages
wget "$CUDA_REPO_PKG" -O /tmp/cuda-repo.deb && sudo dpkg -i /tmp/cuda-repo.deb && rm -f /tmp/cuda-repo.deb
wget "$ML_REPO_PKG" -O /tmp/ml-repo.deb && sudo dpkg -i /tmp/ml-repo.deb && rm -f /tmp/ml-repo.deb

# Download new list of packages
sudo apt-get update
```

## Dependencies

Install some dependencies with Deb packages:
```sh
sudo apt-get install --no-install-recommends git graphviz python-dev python-flask python-flaskext.wtf python-gevent python-h5py python-numpy python-pil python-pip python-scipy python-tk
```

Follow [these instructions](BuildCaffe.md) to build Caffe (**required**).

Follow [these instructions](BuildTorch.md) to build Torch7 (*suggested*).

Follow [these instructions](BuildTensorflow.md) to build Tensorflow (*suggseted*).

## Download source

```sh
# example location - can be customized
DIGITS_ROOT=~/digits
git clone https://github.com/NVIDIA/DIGITS.git $DIGITS_ROOT
```

Throughout the docs, we'll refer to your install location as `DIGITS_ROOT` (`~/digits` in this case), though you don't need to actually set that environment variable.

## Python packages

Several PyPI packages need to be installed:
```sh
sudo pip install -r $DIGITS_ROOT/requirements.txt
```

# [Optional] Enable support for plug-ins

DIGITS needs to be installed to enable loading data and visualization plug-ins:
```
sudo pip install -e $DIGITS_ROOT
```

# Starting the server

```sh
./digits-devserver
```

Starts a server at `http://localhost:5000/`.
```
$ ./digits-devserver --help
usage: __main__.py [-h] [-p PORT] [-d] [--version]

DIGITS development server

optional arguments:
  -h, --help            show this help message and exit
  -p PORT, --port PORT  Port to run app on (default 5000)
  -d, --debug           Run the application in debug mode (reloads when the
                        source changes and gives more detailed error messages)
  --version             Print the version number and exit
```

# Getting started

Now that you're up and running, check out the [Getting Started Guide](GettingStarted.md).

# Development

If you are interested in developing for DIGITS or work with its source code, check out the [Development Setup Guide](DevelopmentSetup.md)

## Troubleshooting

Most configuration options should have appropriate defaults.
Read [this doc](Configuration.md) for information about how to set a custom configuration for your server.