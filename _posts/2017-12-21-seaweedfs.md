---
layout: post
title:  seaweedfs
tags:   server filesystem
category:   server filesystem
---

# seaweedfs

## install go
wget https://dl.gocn.io/golang/1.9.2/go1.9.2.linux-amd64.tar.gz
sudo tar -C /usr/local -zxvf go1.9.2.linux-amd64.tar.gz

mkdir -p ~/go/src
echo "export GOPATH=$HOME/go" >> ~/.bashrc
echo "export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin" >> ~/.bashrc
source ~/.bashrc
go version

## install  mercurial

sudo apt install git mercurial unzip

go get github.com/chrislusf/seaweedfs/go/weed

wget  https://bintray.com/artifact/download/chrislusf/seaweedfs/weed_0.70beta_linux_amd64.tar.gz

sudo mkdir /home/data/

sudo chmod -R 777  /home/data/

./weed master

./weed volume -dir="/home/data/" -max=5 -mserver="192.168.100.117:9333" -port=9080

# 提交一个存储请求，这个时候weed先要分配一个全局的文件ID

curl -X POST http://192.168.100.117:9333/dir/assign

# 存储一张图片

curl -X PUT -F file=@/tmp/1.jpg http://192.168.100.117:9080/6,04f00144db

curl -X PUT -F file=@/tmp/1.jpg http://192.168.100.172:9080/1,04f00144db
















curl "http://192.168.100.117:9080/6/?pretty=y"



alias s1='ssh chenwei@192.168.100.172'
alias s2='ssh ubuntu@192.168.100.117'


ssh-copy-id chenwei@192.168.100.172
ssh-copy-id ubuntu@192.168.100.117




## Install Go

sudo apt-get install golang


wget https://dl.gocn.io/golang/1.9.2/go1.9.2.linux-amd64.tar.gz


scp chenwei@192.168.100.172:~/go1.9.2.linux-amd64.tar.gz .

scp go1.9.2.linux-amd64.tar.gz ubuntu@192.168.100.117:~/



http://blog.csdn.net/Anumbrella/article/details/78585937?locationNum=9&fps=1