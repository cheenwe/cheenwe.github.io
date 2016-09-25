---
layout: post
title: Ubuntu 安装 SIP 服务器
tags: sip
category: server
---


# 简介
会话发起协议（Session Initiation Protocol，缩写SIP）是一个由IETF MMUSIC工作组开发的协议，作为标准被提议用于创建，修改和终止包括视频，语音，即时通信，在线游戏和虚拟现实等多种多媒体元素在内的交互式用户会话。2000年11月，SIP被正式批准成为3GPP信号协议之一，并成为IMS体系结构的一个永久单元。SIP与H.323一样，是用于VoIP最主要的信令协议之一。

SIP网络单元
用户代理（User Agent）
SIP用户代理是一个SIP逻辑网络端点，用于创建、发送、接收SIP消息并管理一个SIP会话。SIP用户代理又可分为用户代理客户端UAC（User Agent Client）和用户代理服务端UAS（User Agent Server）。UAC创建并发送SIP请求，UAS接收处理SIP请求，发送SIP响应。

代理服务器（Proxy）
SIP代理服务器（PROXY）在网络上位于SIP UAC和UAS之间，用于帮助UAC和UAS间的消息路由。PROXY也可以执行路由策略控制（比如，检查SIP消息的合法性，确认消息是否允许被路由）。PROXY在转发SIP消息时，可能根据需要修改SIP消息的某些部分。

注册服务器（Register）
SIP注册服务器用于接收SIP注册请求，并保存发送注册请求的UA的位置信息。


#   安装步骤

## 安装关联软件包

>sudo apt-get install perl libdbi-perl libdbd-MySQL-perl libdbd-pg-perl libfrontier-rpc-perl libterm-readline-gnu-perl libberkeleydb-perl libncurses5-dev

## 下载源码
[地址:](http://opensips.org/pub/opensips/)

>wget http://opensips.org/pub/opensips/2.1.2/opensips-2.1.2.tar.gz

解压 :

>tar zxf opensips-2.1.2.tar.gz

## 编译安装

>make && make install

## 修改配置

>nano etc/opensips.cfg

将: listen=udp:127.0.0.1:5060   # CUSTOMIZE ME
修改为: listen=udp:*IP*:5060   #这里的的IP以本机实际IP为准

## 启动服务
>opensipsctl start

## 查看用户注册情况
>opensipsctl ul show