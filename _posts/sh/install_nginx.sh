#!/bin/bash

echo -n "安装nginx的依赖包"

sudo apt-get install libpcre3 libpcre3-dev zlib1g-dev libssl-dev build-essential openssl

echo -n "下载安装"
wget  http://nginx.org/download/nginx-1.9.9.tar.gz

sudo tar -zxvf nginx-1.9.9.tar.gz -C /usr/local/src/

cd /usr/local/src/nginx-1.9.9

sudo ./configure --prefix=/usr/local/nginx --with-openssl=/usr/include/openssl

sudo make && sudo make install
