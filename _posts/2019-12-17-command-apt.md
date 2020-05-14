---
layout: post
title: Ubuntu apt 命令
tags: ubuntu command
category: ubuntu
---

## 下载缓存路径

    /var/cache/apt/archives


##  下载安装包  

    sudo apt-get download  icu-devtools    

##  清理安装包  

    sudo  apt-get  clean

##  查看安装包的依赖

    sudo apt-cache depends libxml2

##  搜索某个安装包

    sudo apt-cache search libxml2 |grep development
