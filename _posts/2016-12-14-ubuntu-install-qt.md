---
layout: post
title: Ubuntu 安装QT报错解决
tags: ubuntu qt
category:  ubuntu
---

1. 安装qt linux 出现错误You are missing the OpenGL include files. Install the mesa-common-dev package，
../../Qt5.1.0/5.1.0/gcc_64/include/QtGui/qopengl.h:110:21: fatal error: GL/gl.h: No such file or directory

执行

>sudo apt-get install mesa-common-dev

2. 出现下面提示：/usr/bin/ld: cannot find -lGL

执行下面命令解决：

> sudo apt-get install libgl1-mesa-dev libglu1-mesa-dev

3. qt 依赖gcc g++库

4. qt 学习网站 https://www.devbean.net
