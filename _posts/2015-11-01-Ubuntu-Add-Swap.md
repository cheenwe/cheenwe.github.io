---
layout: post
title: Ubuntu系统添加swap
tags: ubuntu swap
category: server
---

# Ubuntu系统添加swap

## 查看是否创建过swap:

    sudo swapon -s

##  键入以下命令来创建512MB交换文件（1024*512 MB=524288块的大小）：

    sudo dd if=/dev/zero of=/swapfile1 bs=1024 count=524288

## 通过创建一个Linux交换区准备交换文件：

    sudo mkswap /swapfile1

## 激活交换文件：

    sudo swapon /swapfile1


## 该文件将持续对VPS直到机器重新启动。您可以确保交换是永久性的将其添加到fstab文件。

打开 `sudo vim /etc/fstab` &并粘贴:

    /swapfile1       none    swap    sw      0       0

## 设置swappiness到10充当紧急缓冲区，防止外的存储器崩溃：

    echo 10 | sudo tee /proc/sys/vm/swappiness
    echo vm.swappiness = 10 | sudo tee -a /etc/sysctl.conf

## 最后，出于安全原因设置正确的文件权限，输入：

    sudo chown root:root /swapfile1
    sudo chmod 0600 /swapfile1
