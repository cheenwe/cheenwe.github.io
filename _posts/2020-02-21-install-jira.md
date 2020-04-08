---
layout: post
title: 安装 Jira 及 confluence
tags: jira
category:  pm 
---


- openjdk

```
sudo apt-get update
sudo apt-get install openjdk-8-jdk
java -version

```


## Jira 安装

https://d.pr/free/f/oULDqJ

### 卸载


```
sudo -i

userdel jira

rm -rf /opt/atlassian/jira
rm -rf /var/atlassian/application-data/jira

mysql -uroot -p
drop database jiradb;
drop database jira;
```

### 安装

- mysql 配置

sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf

```
[mysqld]
#
# * Basic Settings

## add by chenwei 20190821

default-storage-engine=INNODB
character_set_server=utf8mb4

innodb_large_prefix=ON
innodb_log_file_size=2G 

...

```

- 生成 jira 数据库

```
mysql -uroot -p

CREATE DATABASE jiradb CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER,INDEX on jiradb.* to 'jira'@'%' identified by 'jira';
flush privileges;

```

- install jira

```
wget  https://downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-8.2.1-x64.bin
chmod +x atlassian-jira-software-8.2.1-x64.bin
./atlassian-jira-software-8.2.1-x64.bin

o->2->2->

HTTP Port: 9001
RMI Port: 9010   


jira安装到了/opt/atlassian/jira和/var/atlassian/application-data/jira目录下，并且jira监听的端口是 9001 。

jira的主要配置文件，存放在/opt/atlassian/jira/conf/server.xml文件中


ps aux |grep jira  
```

- 破解
https://d.pr/free/f/0OZyjx

```
sudo cp mysql-connector-java-5.1.47-bin.jar /opt/atlassian/jira/atlassian-jira/WEB-INF/lib
sudo cp atlassian-extras-3.2.jar /opt/atlassian/jira/atlassian-jira/WEB-INF/lib
sudo cp atlassian-universal-plugin-manager-plugin-4.0.2.jar /opt/atlassian/jira/atlassian-jira/WEB-INF/lib/atlassian-universal-plugin-manager-plugin-4.0.2.jar

```

- 开启服务 

```
sh /opt/atlassian/jira/bin/stop-jira.sh
sh /opt/atlassian/jira/bin/start-jira.sh

tail -f /opt/atlassian/jira/logs/catalina.out
```

## confluence 

```
mysql -uroot -p
drop database confluence;
CREATE DATABASE confluence CHARACTER SET utf8 COLLATE utf8_bin;
GRANT ALL PRIVILEGES ON confluence.* TO 'confluenceuser'@'localhost' IDENTIFIED BY 'confluencepass';
```


### 下载

```
wget https://downloads.atlassian.com/software/confluence/downloads/atlassian-confluence-6.7.1-x64.bin -P /opt
```

### 安装

```
sudo bash atlassian-confluence-6.7.1-x64.bin


o->2->2->

HTTP Port: 9002
RMI Port: 9012


confluence 安装到了 /opt/atlassian/confluence 和 /var/atlassian/application-data/confluence 目录下，并且 confluence 监听的端口是 9002 。


Installation Directory: /opt/atlassian/confluence
Home Directory: /var/atlassian/application-data/confluence
HTTP Port: 8090
RMI Port: 8000
Install as service: Yes

<!-- 先不要开启服务 -->
```


###  破解

选择其中一个即可

1. 直接使用已破解的包

```
下载 https://d.pr/free/f/yn7zbs 并解压

sudo cp  *.jar /opt/atlassian/confluence/confluence/WEB-INF/lib/
```

2. 手动破解步骤
```
wget https://files.cnblogs.com/files/Javame/confluence%E7%A0%B4%E8%A7%A3%E5%B7%A5%E5%85%B7.rar


1. 下载 文件到本地: /opt/atlassian/confluence/confluence/WEB-INF/lib/atlassian-extras-decoder-v2-3.3.0.jar 并命名为: atlassian-extras-2.4.jar
2. 打开破解程序: java -jar confluence_keygen.jar
3.  点击.patch，选择atlassian-extras-2.4.jar文件，点击打开，jar文件破解成功
4. 上传破解后jar包到/opt/atlassian/confluence/confluence/WEB-INF/lib，并重命名atlassian-extras-decoder-v2-3.3.0.jar
5. 上传mysql驱动/opt/atlassian/confluence/confluence/WEB-INF/lib
```


### 重启服务

```
sudo /opt/atlassian/confluence/bin/stop-confluence.sh

sudo /opt/atlassian/confluence/bin/start-confluence.sh
```
 

### 卸载: 

```
drop database confluencedb;
CREATE DATABASE confluencedb CHARACTER SET utf8 COLLATE utf8_bin;
GRANT ALL PRIVILEGES ON confluencedb.* TO 'confluenceuser'@'localhost' IDENTIFIED BY 'confluencepass';

sudo userdel confluence
sudo userdel confluence1
sudo rm -rf /var/atlassian/application-data/confluence
sudo rm -rf /opt/atlassian/confluence/

```

### 解决中文乱码

配置文件备份: https://d.pr/free/f/fGO9wt

```
<property name="hibernate.connection.url">jdbc:mysql://localhost/confluence?&amp;useSSL=false&amp;useUnicode=true&amp;characterEncoding=utf8</property>
``` 


## hipchat安装破解

https://blog.csdn.net/sanfeng_2046/article/details/93711636

https://www.toutiao.com/i6760559050011705870/

