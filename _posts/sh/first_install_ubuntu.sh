#!/bin/bash

sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


# echo "安装 oh my zsh "
# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

## 修改阿里云PIP源
echo "修改阿里云PIP源"

mkdir ~/.pip
cat > ~/.pip/pip.conf << EOF

[global]
trusted-host=mirrors.aliyun.com
index-url=https://mirrors.aliyun.com/pypi/simple/

EOF

## 修改阿里云软件源
echo "修改阿里云软件源"

mv /etc/apt/sources.list /etc/apt/sources.list.bak

cat >/etc/apt/sources.list << EOF

deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse

EOF


sudo apt-get update
