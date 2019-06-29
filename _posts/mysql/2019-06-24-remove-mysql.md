---
layout: post
title: ubuntu彻底卸载mysql
tags: MySQL 
categories: mysql
---


## 卸载 MySQL

```
sudo apt-get remove mysql-server mysql-client-5.7  mysql-client-core-5.7 mysql-common   mysql-server-core-5.7 

#sudo apt-get remove mysql-*

dpkg -l |grep ^rc|awk '{print $2}' |sudo xargs dpkg -P
# select Yes


sudo rm -rf /etc/mysql/ /var/lib/mysql
sudo apt autoremove
sudo apt autoclean

```


## 安装mariadb
```

sudo apt install mariadb-server mariadb-client mariadb-server-10         
sudo mysql #切换 MySQL
```
