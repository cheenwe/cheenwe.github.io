---
layout: post
title: ubuntu 禁止内核更新
tags: kernel
category: ubuntu
---



##  查看内核

```bash

sudo dpkg --get-selections | grep linux

```

##  　查看是正在使用内核

```bash

uname -a

```

##  　禁止内核更新

```bash

sudo apt-mark hold linux-image-4.4.0-21-generic
sudo apt-mark hold linux-modules-extra-4.4.0-21-generic
```

##  　重启内核更新

```bash


sudo apt-mark unhold linux-image-4.4.0-21-generic
sudo apt-mark unhold linux-modules-extra-4.4.0-21-generic
```
