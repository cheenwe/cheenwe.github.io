---
layout: post
title: ubuntu解压zip文件乱码问题
tags: ubuntu unzip
category:  ubuntu
---


在网上下载的文件中有中文，解压后文件名乱码，以前遇到很多次，只是解决了，每次遇到都需要重新找方法，记录如下.

## 通过unzip行命令解压，指定字符集

>unzip -O CP936 xxx.zip

- 用GBK, GB18030也可以

unzip --help对这个参数有一行简单的说明。