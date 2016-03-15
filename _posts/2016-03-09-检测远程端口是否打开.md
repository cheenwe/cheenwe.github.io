---
layout: post
title: 检测远程端口是否打开
tags: server port
categories: server
---

# 检查远程端口是否打开

## telnet
>telnet 110.101.101.101 80

## nmap
>nmap ip -p port 测试端口 #指定端口

>nmap ip 测试端口 #显示全部打开的端口

## nc
> nc -v host port  #端口未打开返回状态为非0