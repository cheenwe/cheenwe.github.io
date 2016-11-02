---
layout: post
title: 安装GitLab
tags:
  - gitlab
  - 服务器
category: gitlab
---

# CentOS及Ubuntu安装GitLab
安装方式有软件包安装和源代码安装 , 由于 GitLab 使用 Ruby 开发 , 从学习的角度上建议使用源代码安装 .

- [软件包安装](https://about.gitlab.com/downloads/)

- [源代码安装](https://gitlab.com/gitlab-org/gitlab-ee/blob/8-5-stable-ee/doc/install/installation.md)

## Ubuntu 软件包安装


### 安装关联软件　
    sudo apt-get install curl openssh-server ca-certificates postfix

### 下载安装包　
    curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash sudo apt-get install gitlab-ce

### 配置　
    sudo gitlab-ctl reconfigure

### 登陆
Username: root
Password: 5iveL!fe

## CentOS安装步骤

### 安装ruby

```console
yum install ruby-2.0.0-p353
```

### 安装关联软件

```console
sudo yum install openssh-server  postfix cronie git.x86_64  openssh-server sshd
```

###  下载安装gitlab

```console
curl -O https://downloads-packages.s3.amazonaws.com/centos-6.6/gitlab-7.5.1_omnibus.5.2.0.ci-1.el6.x86_64.rpm
sudo rpm -i gitlab-7.5.1_omnibus.5.2.0.ci-1.el6.x86_64.rpm
```


### 配置

#### 配置ip

编辑 /etc/gitlab/gitlab.rb 文件
把第一行的
>external_url 'hostname'
改为
>external_url='你的服务器ip地址'

```console
nano /etc/gitlab/gitlab.rb
```

#### 配置gitlab

```console
sudo gitlab-ctl reconfigure
```
如果不报错,一直按enter键到最后

### 登陆及查看状态
默认密码

```console
Username: root
Password: 5iveL!fe
```
查看运行状态

```console
sudo gitlab-ctl status;
```

## 常见错误

### Error executing action
```console
Error executing action `create` on resource 'user[git]'”
```
git用户已经存在,删除git 用户
```console
userdel git
```

### URI::InvalidURIError

```console
 URI::InvalidURIError
--------------------
bad URI(is not URI?): ${external_url}
Cookbook Trace:
```
是因为/etc/gitlab/gitlab.rb文件中的内容是：

```console
external_url 'hostname1'
```
将其修改为：

```console
external_url='192.168.1.49'
```
