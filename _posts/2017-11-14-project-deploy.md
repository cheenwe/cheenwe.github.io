---
layout: post
title: 项目部署整理
tags:   deploy
category:   deploy
---

最近一段忙于在Centos下离线部署Rails应用程序, 闲下来把后续部署流程整理成脚本方便操作.

0.  更新包以软链接方式链接到指定目录，方便回滚版本
1.  上传文件，单独目录 /file ，方便后续扩容,　部署时链接到部署文件夹
2.  配置文件，全部以 .yum 结尾，放shared 下，更新后链接
3.  自动更新脚本


下载所需软件包，并复制到/home/deploy目录下。

## 安装mysql

cd  /home/deploy/soft_pagake/
tar -xf mysql-5.7.20-1.el7.x86_64.rpm-bundle.tar

解压mysql安装包

### 卸载mariadb

rpm -qa | grep mariadb   #查找是否存在mariadb包
sudo rpm -e --nodeps mariadb-libs-5.5.44-2.el7.x86_64

### 卸载mysql的残留文件
rm -rf /var/lib/mysql && rm -rf /var/lib/mysql/mysql

### 安装mysql
sudo rpm -ivh mysql-community-common-5.7.20-1.el7.x86_64.rpm
sudo rpm -ivh mysql-community-libs-5.7.20-1.el7.x86_64.rpm
sudo rpm -ivh mysql-community-client-5.7.20-1.el7.x86_64.rpm
sudo rpm -ivh mysql-community-server-5.7.20-1.el7.x86_64.rpm
sudo rpm -ivh mysql-community-libs-compat-5.7.20-1.el7.x86_64.rpm
sudo rpm -ivh mysql-community-devel-5.7.20-1.el7.x86_64.rpm
sudo rpm -ivh mysql-community-embedded-5.7.20-1.el7.x86_64.rpm
sudo rpm -ivh mysql-community-embedded-compat-5.7.20-1.el7.x86_64.rpm
sudo rpm -ivh mysql-community-embedded-devel-5.7.20-1.el7.x86_64.rpm

### 开启mysql服务
sudo service mysqld start

### 查找mysql中默认密码
sudo grep "password" /var/log/mysqld.log

### 更新root密码

mysql -uroot –p
set global validate_password_policy=0;
set global validate_password_length=1;
SET PASSWORD = PASSWORD('root');

```shell
## 安装zlib

tar -zxf zlib-1.2.11.tar.gz
cd zlib-1.2.11
sudo ./configure

make && sudo make install
cd ..

## 安装openssl

PACKAGE_NAME="openssl-1.1.0g"
tar -zxf $PACKAGE_NAME.tar.gz
cd $PACKAGE_NAME
./config -fPIC --prefix=/usr/local/openssl enable-shared
make && sudo make install
检查是否装成功
openssl version
cd ..
sudo rm -R $PACKAGE_NAME

## 安装openssl依赖包
sudo rpm -ivh openssl/openssl-1.0.2k-8.el7.x86_64.rpm openssl/openssl-libs-1.0.2k-8.el7.x86_64.rpm

## 安装libxml2
PACKAGE_NAME="libxml2-2.7.2"
tar -zxf $PACKAGE_NAME.tar.gz
cd $PACKAGE_NAME
./configure

make && sudo make install
cd ..
sudo rm -R $PACKAGE_NAME

## 安装pcre
PACKAGE_NAME="pcre-8.38"
tar -zxf $PACKAGE_NAME.tar.gz
cd $PACKAGE_NAME
./configure

make && sudo make install
cd ..
sudo rm -R $PACKAGE_NAME

## 安装redis
PACKAGE_NAME="redis-3.2.9"
tar -zxf $PACKAGE_NAME.tar.gz
cd $PACKAGE_NAME

make && sudo make install
cd ..
sudo rm -R $PACKAGE_NAME

## 安装nginx
PACKAGE_NAME="nginx-1.12.2"
tar -zxf $PACKAGE_NAME.tar.gz
cd $PACKAGE_NAME
./configure
make && sudo make install
cd ..
sudo rm -R $PACKAGE_NAME

## 修改nginx配置文件
sudo  vim /usr/local/nginx/conf/nginx.conf

            user  deploy;           //设置一个账户user  deploy;
            worker_processes 4;  //工作进程数
            gzip  on;            //开启gzip
            listen       8000;   //修改默认端口
            include /home/deploy/project/shared/config/nginx.yml; #文中最后一个括号内添加

## 安装ruby
PACKAGE_NAME="ruby-2.4.2"
tar -zxf $PACKAGE_NAME.tar.gz
cd $PACKAGE_NAME
./configure --disable-install-rdoc
make && sudo make prefix=/usr/local install

sudo chown deploy /usr/local/bin

#注意修改用户名 deploy   如果ruby没安装成功将会没有下面这些路径。
sudo chown -R deploy /usr/local/lib/ruby/gems/
#注意修改用户名rm
sudo chmod -R 777 /usr/local/lib/ruby/gems/2.4.0
## 移动activemq到project路径下
cd /home/deploy/soft_pakage
tar -zxf apache-activemq-5.15.0-bin.tar.gz
#在/home/deploy目录下创建project文件夹
mkdir -p /home/deploy/project
#将apache-activemq-5.15.0 重命名复制到/home/deploy/project/apache-activemq/
mv  apache-activemq-5.15.0 /home/deploy/project/apache-activemq/
#开启activemq
/home/deploy/project/apache-activemq/bin/activemq start
## 安装bundler
在线安装bundler
wget https://gems.ruby-china.org/downloads/bundler-1.16.0.gem
gem install --local bundler-1.16.0.gem




从 http://192.168.100.229/chenwei 处下载项目代码
    找到product,点击进去，选择最新的项目。
    复制粘贴在project下
    解压项目包文件 ，更换成下载的项目包名
    sudo tar -zxf web_server.tar.gz
    #将解压好的项目包改为web_server
    sudo mv web_server   /home/deploy/project/web_server（自己补全文件夹名）
    #到项目目录下执行该指令
cd /home/deploy/project/web_server
    离线安装bundle。
    gem install --local vendor/cache/bundler-1.16.0.gem --no-ri
    nohup bash bin/gs  &
    #安装项目依赖的所有gem包，也回报错的，按照下面的解决办法处理。

执行：bundle install
（如果第一次执行报错，请继续执行11.1）报错如下:

#/usr/local/lib/ruby/2.4.0/rubygems/core_ext/kernel_require.rb:55:in `require': cannot load such file -- openssl (LoadError
## 解决办法

#给软件包openssl 777权限

sudo chmod -R 777 /home/deploy/soft_pakage/ruby-2.4.2/ext/openssl/
d /home/deploy/soft_pakage/ruby-2.4.2/ext/openssl/
ruby extconf.rb --with-openssl-include=/usr/local/openssl/include/ --with-openssl-lib=/usr/local/openssl/lib

#注意用户名，增加软链接

sudo ln -s /home/deploy/soft_pakage/ruby-2.4.2/include/ /
make  &&    sudo make install
#再次执行 bundle install

```
## 初始部署
```shell
###  创建项目所需文件夹

mkdir -p /home/deploy/project/shared/uploads
mkdir -p /home/deploy/project/shared/config
mkdir -p /home/deploy/project/shared/log
mkdir -p /home/deploy/project/shared/tmp/pids
mkdir -p /home/deploy/project/shared/tmp/cache
mkdir  /home/deploy/project/update/

## 增加project路径权限
    sudo chmod -R 777  /home/deploy/project/
## 拷贝项目所需配置文件
cp /home/deploy/project/web_server/config/broker.yml.example /home/deploy/project/shared/config/broker.yml
cp /home/deploy/project/web_server/config/config.yml.example /home/deploy/project/shared/config/config.yml
cp /home/deploy/project/web_server/config/database.yml.example /home/deploy/project/shared/config/database.yml
cp /home/deploy/project/web_server/config/nginx.yml.example /home/deploy/project/shared/config/nginx.yml
cp /home/deploy/project/web_server/config/puma.yml.example /home/deploy/project/shared/config/puma.yml
cp /home/deploy/project/web_server/config/redis.yml.example /home/deploy/project/shared/config/redis.yml
cp /home/deploy/project/web_server/config/secrets.yml.example   /home/deploy/project/shared/config/secrets.yml
cp /home/deploy/project/web_server/config/config.js /home/deploy/project/shared/config/config.js
cp /home/deploy/project/web_server/bin/web /home/deploy/project/shared/web
cd /home/deploy/project
mv web_server/ update/
ln -s /home/deploy/project/update/web_server/ /home/deploy/project/web_server

## 修改配置文件ip以及项目路径
sudo vim /home/deploy/project/shared/config/nginx.yml  修改成web_server对应的路径
         #server unix:///home/share/deploy/project/web_server/tmp/puma.sock;
         #root /home/deploy/project/web_server/public;
#server_name 192.168.100.168; 修改成虚拟机IP

sudo vim /home/deploy/project/shared/config/config.yml  #修改成虚拟机的IP地址
        去掉端口号3000.
 # web_url: "服务器ip地址"
#download_web_url: "服务器ip地址"

sudo vi  /home/deploy/project/shared/config/config.js  #修改成虚拟机的IP地址
        #baseurl: 'http://192.168.100.141:3000', // 请求地址以及端口
        #websocket: 'ws://192.168.100.141:61614/stomp', // 消息队列地址
sudo vim /home/deploy/project/web_server/bin/web #修改成对应的web_server项目路径
        # sudo vim /home/deploy/project/shared/web
        编辑app_root路径
        app_root="/home/deploy/project/web_server"（此路径为你部署的项目路径）
        同时注释掉下面三行
#basepath=$(cd `dirname $0`; pwd)
#app_root=`dirname $basepath`
#app_root="/home/chenwei/workspace/ruby/bank_server"

##  增加软链接
sudo ln -s /home/deploy/project/update/$update_pkg_name/ /home/deploy/project/web_server
        ln -sf /home/deploy/project/shared/tmp/ /home/deploy/project/web_server/tmp
        ln -sf /home/deploy/project/shared/log/ /home/deploy/project/web_server/log
        ln -sf /home/deploy/project/shared/config/broker.yml /home/deploy/project/web_server/config/broker.yml
        ln -sf /home/deploy/project/shared/config/config.yml /home/deploy/project/web_server/config/config.yml
        ln -sf /home/deploy/project/shared/config/database.yml /home/deploy/project/web_server/config/database.yml
        ln -sf /home/deploy/project/shared/config/nginx.yml /home/deploy/project/web_server/config/nginx.yml
        ln -sf /home/deploy/project/shared/config/puma.yml /home/deploy/project/web_server/config/puma.yml
        ln -sf /home/deploy/project/shared/config/redis.yml /home/deploy/project/web_server/config/redis.yml
        ln -sf /home/deploy/project/shared/config/secrets.yml /home/deploy/project/web_server/config/secrets.yml
        ln -sf /home/deploy/project/shared/config/config.js /home/deploy/project/web_server/public/config.js
        ln -s /home/deploy/project/shared/uploads/ /home/deploy/project/web_server/public/uploads
##  创建数据库
cd /home/deploy/project/web_server
rails db:create db:migrate db:seed

## 服务器重启
## 更新会计准则
cd /home/deploy/project/web_server
rails item:init

## 项目重启
/home/deploy/project/web_server/bin/web start
/home/deploy/project/web_server/bin/web restart

## Nginx重启
sudo /usr/local/nginx/sbin/nginx
sudo /usr/local/nginx/sbin/nginx -s reload
```
## shell 脚本
```shell
可编写shell脚本来启动：
touch  binx
#!/bin/bash
APP_NAME='nginx'
app_path=/etc/init.d/nginx
app_pid=$(ps aux | grep $APP_NAME |  grep -v grep | awk '{print $2}')
case $1 in
   start)
          sudo $app_path start
    echo "$app_pid is start"
           ...
           ;;
    stop)
         sudo $app_path stop
    echo "$app_pid is stop"
           ...
           ;;
   restart)
        sudo $app_path restart
    echo "$app_pid is restart"
            ...
            ;;
     status)
        sudo $app_path status
     echo "$app_pid is status"
             ...
             ;;
          *) echo "$0 {start|stop|restart|status}"
             exit 4
             ;;
esac


## Activemq重启
sudo /home/deploy/project/apache-activemq/bin/activemq start
sudo /home/deploy/project/apache-activemq/bin/activemq restart
可编写shell脚本来启动：
#!/bin/bash
APP_NAME='activemq'
activemq_path=/home/deploy/project/apache-activemq/bin/activemq
app_pid=$(ps aux | grep $APP_NAME |  grep -v grep | awk '{print $2}')
case $1 in
   start)
          sudo $activemq_path start
      echo "$app_pid is running"
           ...
           ;;
    stop)
      sudo $activemq_path stop
          echo "$app_pid is stop"
           ...
           ;;
   restart)
     sudo $activemq_path restart
     echo "$app_pid is running"
            ...
            ;;
     status) # 查看状态需要做的步骤
             ...
             ;;
          *) echo "$0 {start|stop|restart|status}"
             exit 4
             ;;
esac
## 关闭防火墙
 关闭redhat防火墙
 systemctl stop firewalld
 最好也关闭windows防火墙
 键入服务器ip地址，查看是否能访问系统以及是否能注册。
 如果ok，部署则ok！

```

## 项目更新

公司内部更新方式
可将以下脚本信息写入/home/deploy/project/update/update文件中
然后进入目录直接执行 bash update

```shell
##修改版本号码
update_pkg_name=V0.2.2061

project_name=bank

 ##下载文件
echo 'downloading ..'
wget http://192.168.100.229/xx/bank/repository/archive.tar.gz?ref=$update_pkg_name -O $update_pkg_name.tar.gz

tar -zxf  $update_pkg_name.tar.gz  -C  /home/deploy/project/update/

mv /home/deploy/project/update/$project_name-$update_pkg_name-* /home/deploy/project/update/$update_pkg_name

echo 'stop old server'
/home/deploy/project/shared/web stop

rm /home/deploy/project/web_server

echo 'add soft link'

ln -sf /home/deploy/project/update/$update_pkg_name/ /home/deploy/project/web_server

ln -sf /home/deploy/project/shared/tmp/ /home/deploy/project/web_server/tmp
ln -sf /home/deploy/project/shared/log/ /home/deploy/project/web_server/log

ln -sf /home/deploy/project/shared/config/broker.yml /home/deploy/project/web_server/config/broker.yml
ln -sf /home/deploy/project/shared/config/config.yml /home/deploy/project/web_server/config/config.yml
ln -sf /home/deploy/project/shared/config/database.yml /home/deploy/project/web_server/config/database.yml
ln -sf /home/deploy/project/shared/config/nginx.yml /home/deploy/project/web_server/config/nginx.yml
ln -sf /home/deploy/project/shared/config/puma.yml /home/deploy/project/web_server/config/puma.yml
ln -sf /home/deploy/project/shared/config/redis.yml /home/deploy/project/web_server/config/redis.yml
ln -sf /home/deploy/project/shared/config/secrets.yml /home/deploy/project/web_server/config/secrets.yml
ln -sf /home/deploy/project/shared/config/config.js /home/deploy/project/web_server/public/config.js

ln -sf /file/uploads/ /home/deploy/project/web_server/public/uploads

echo 'start server'
#/home/deploy/project/web_server/bin/web start
/home/deploy/project/shared/web start
#/home/deploy/project/web_server/bin/web restart


#/usr/local/nginx/sbin/nginx

```
