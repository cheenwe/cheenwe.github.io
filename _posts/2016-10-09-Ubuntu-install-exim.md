---
layout: post
title: Ubuntu下配置exim服务器
tags: mail
category: server
---

# Exim

Exim是一个MTA（Mail Transfer Agent，邮件传输代理）服务器软件，该软件基于GPL协议开发，是一款开源软件。该软件主要运行于类UNIX系统。
Exim4被设计成能高效地、不间断地在Internet上运行，而且能处理各种混合邮件。
Exim4 处理的每封邮件都以一个16位字符的名称标识，该标识由三部份组成，以"-"号分隔，如：1GS3YU-0000zG-Nd。这些字符是经过base编码 的，第一部份的原始信息是接收邮件的时间，第二部份的原始信息是接收邮件的进程id，第三部份的信息与配置文件中localhost_number的设置 相关。
Exim4通过基于TCP/IP的SMTP协议从其它主机收取邮件。 Exim4接收邮件后，会把邮件分成两个文件保存在spool目录。这两个文件的 命名规则是邮件标识后加-D和-H。以-D结尾的文件保存着邮件正文的信息，以-H结尾的文件保存邮件的头信息。

[参考](https://wiki.debian.org/Exim)

## 安装

```sh
sudo apt-get install exim4
```

## 配置

```sh
sudo dpkg-reconfigure exim4-config
```


- 1.选项选第一个，使用SMTP直接发信：internet site; mail is sent and received directly using SMTP

- 2.输入：你IP对应的DNS名称（发邮件时显示的@后缀), 如：

> cheenwe.cn
发件人会默认为: root@cheenwe.cn

- 后续几项全部选择默认即可


* 或者直接使用命令修改

```sh
# /etc/exim4/update-exim4.conf.conf

dc_eximconfig_configtype='internet' #对应方法1第一项

dc_other_hostnames='你IP对应的DNS名称'

# 然后重启exim服务：

sudo invoke-rc.d exim4 restart
```

## 测试发邮件

```sh
echo "这是内容" | mail -s "你好标题" 8695238@qq.com
```

## 查看邮件发送日志

```sh
tailf /var/log/exim4/mainlog
```

## 查看有多少发件进程

```sh
sudo exim -bpc
```

## 删除发件进程中的邮件

```sh
exim -bpru | awk {'print $3'} | xargs exim -Mrm

```

## 卸载方法

```sh
apt-get --purge remove exim4
apt-get --purge remove exim4-base
```