---
layout: post
title: Ubuntu 下安装 Oracle JDK
tags: java sdk
category: java
---


# Ubuntu 下安装 Oracle JDK
先执行如下命令看是否安装了OpenJDK，如果已经安装，会显示java的信息。

>java -version

## 卸载OpenJDK

>sudo apt-get -y purge openjdk-\*

## 安装Oracle JDK

### 添加add-apt-repository工具

>sudo apt-get install -y python-software-properties software-properties-common

### 添加 PPA repository 到系统

>sudo add-apt-repository ppa:webupd8team/java

### 更新

>sudo apt-get update

### 下载安装 JDK

>sudo apt-get install oracle-java7-installer

### 设置为默认 （如果未安装其他版本 JDK，可跳过此步骤）
>sudo apt-get install oracle-java7-set-defaul

### 设置环境变量
#在/etc/profile文件末尾加入 JDK :
```
echo 'export JAVA_HOME=/usr/lib/jvm/java-7-oracle' >> /etc/profile
echo 'export JRE_HOME=${JAVA_HOME}/jre' >> /etc/profile
echo 'export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib' >> /etc/profile
echo 'export PATH=${JAVA_HOME}/bin:$PATH' >> /etc/profile
```

### 设置默认 JDK 版本

```
update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-7-oracle/bin/java 300
update-alternatives --config java
```




