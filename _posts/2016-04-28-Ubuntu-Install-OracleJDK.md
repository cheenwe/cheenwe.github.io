---
layout: post
title: Ubuntu 下安装 Oracle JDK
tags: ubuntu install java sdk
category: java
---


# Ubuntu 下安装 Oracle JDK

- openjdk

```
sudo apt-get update
sudo apt install openjdk-11-jdk-headless 
java -version

```

- OracleJDK

先执行如下命令看是否安装了OpenJDK，如果已经安装，会显示java的信息。


>java -version

## 卸载OpenJDK

>sudo apt-get -y purge openjdk-\*

## 安装Oracle JDK

### 添加add-apt-repository工具

>sudo apt-get install -y software-properties-common

### 添加 PPA repository 到系统

>sudo add-apt-repository ppa:webupd8team/java

### 更新

>sudo apt-get update

### 下载安装 JDK

>sudo apt-get install oracle-java8-installer

### 设置为默认 （如果未安装其他版本 JDK，可跳过此步骤）
>sudo apt-get install oracle-java8-set-defaul

### 设置环境变量
#在/etc/profile文件末尾加入 JDK :
```
echo 'export JAVA_HOME=/usr/lib/jvm/java-8-oracle' >> /etc/profile
echo 'export JRE_HOME=${JAVA_HOME}/jre' >> /etc/profile
echo 'export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib' >> /etc/profile
echo 'export PATH=${JAVA_HOME}/bin:$PATH' >> /etc/profile
```

### 设置默认 JDK 版本

```
update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-8-oracle/bin/java 300
update-alternatives --config java
```




## 离线安装包

链接:https://pan.baidu.com/s/1q5Kci47f4sUQdhDpd0KUIQ  密码:3h7o


```

echo 'export JAVA_HOME=/root/jdk1.8.0_231' >> /etc/profile
echo 'export JRE_HOME=${JAVA_HOME}/jre' >> /etc/profile
echo 'export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib' >> /etc/profile
echo 'export PATH=${JAVA_HOME}/bin:$PATH' >> /etc/profile

```
