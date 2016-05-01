#!/bin/bash

Jitsi是一个开源的，安全（ZRTP加密），高质量的SIP/XMPP视频通话、会议、聊天、桌面共享、文件传传输。可以安装在你喜欢的操作系统中并且支持多种IM网络。Jitsi是当最功能最完整的高级通信工具.

Jitsi Meet是基于ＷebRTC的JavaScript应用层程序，使用 Jitsi Videobridge 提供高质量，可拓展的视频会议，支持共享文档和在线编辑

# 安装 Jitsi Meet

echo 'deb http://download.jitsi.org/nightly/deb unstable/' >> /etc/apt/sources.list
wget -qO - https://download.jitsi.org/nightly/deb/unstable/archive.key | apt-key add -

apt-get install libc6

apt-get update

apt-get -y install jitsi-meet

 # apt-get install jitsi

# 卸载 jitsi
apt-get purge jigasi jitsi-meet jicofo jitsi-videobridge




Jitsi Meet 需要使用 Oracle JDK ， Open JDK 一直有报错，不知何因

# Ubuntu 下安装 Oracle JDK

 #先执行如下命令看是否安装了OpenJDK，如果已经安装，会显示java的信息。
java -version
## 卸载OpenJDK
sudo apt-get -y purge openjdk-\*

## 安装Oracle JDK
### 添加add-apt-repository工具

sudo apt-get install -y python-software-properties
sudo apt-get install -y software-properties-common

### 添加 PPA repository 到系统
sudo add-apt-repository ppa:webupd8team/java

### 更新
sudo apt-get update

### 下载安装 JDK
sudo apt-get install oracle-java7-installer

### 设置为默认 （如果未安装其他版本JDK，可跳过此步骤）
sudo apt-get install oracle-java7-set-defaul

### 设置环境变量
 #在/etc/profile文件末尾加入：

 #nano /etc/profile
 #在文件末尾加入
 #jdk

echo 'export JAVA_HOME=/usr/lib/jvm/java-7-oracle' >> /etc/profile
echo 'export JRE_HOME=${JAVA_HOME}/jre' >> /etc/profile
echo 'export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib' >> /etc/profile
echo 'export PATH=${JAVA_HOME}/bin:$PATH' >> /etc/profile

### 设置为默认JDK版本
update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-7-oracle/bin/java 300
update-alternatives --config java



