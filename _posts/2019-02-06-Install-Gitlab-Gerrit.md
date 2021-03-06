---
layout: post
title: gerrit gitlab 安装
tags:    gitlab   gerrit
category:   gitlab
---

# gerrit gitlab 安装

1.安装 gerrit 

    https://gerrit-releases.storage.googleapis.com/index.html
     
    选择 

    htpasswd -c /home/gerrit/review_site/etc/passwd gerrit


2.安装gitlab

## 参考

http://www.cnblogs.com/kevingrace/p/5624122.html

https://www.cnblogs.com/kevingrace/p/5651447.html

https://www.cnblogs.com/tesky0125/p/5973642.html

https://www.cnblogs.com/tesky0125/p/5973642.html


## 注意事项

安装 gerrit 默认使用 8080 端口， 此时 gitlab 有个服务也使用8080 端口，会冲突

gitlab 安装后会安装 nginx 服务， 使用 该服务代理 gerrit 即可， 可代理到90 端口

安装路径：


> cat /home/gerrit/review_site/etc/gerrit.config 


```
[gerrit]
  basePath = git
        canonicalWebUrl = http://192.168.50.69:90

[database]
  type = mysql
  hostname = localhost
  database = reviewdb
  username = root
[index]
  type = LUCENE
  url = localhost:9983
[auth]
  type = HTTP
[sendemail]
  smtpServer = smtp.em-data.com.cn
  smtpUser = project@em-data.com.cn
  from = project@em-data.com.cn
  smtpPass = Emdata@2017

[container]
  user = gerrit
  javaHome = /usr/lib/jvm/java-8-openjdk-amd64/jre
[sshd]
  listenAddress = *:29418
[httpd]
  listenUrl = http://*:8081/
[cache]
  directory = cache
[plugins]
    allowRemoteAdmin = true

```

> cat etc/replication.config 

```
[remote "chenwei/nb"]
projects = nb
url = git@192.168.50.69:chenwei/nb.git
push = +refs/heads/*:refs/heads/*
push = +refs/tags/*:refs/tags/*
push = +refs/changes/*:refs/changes/*
threads = 3
```

```

[remote "192.168.50.69"]
url = gerrit@192.168.50.69:/home/gerrit/review_site/git/${name}.git
push = +refs/heads/*:refs/heads/*
push = +refs/tags/*:refs/tags/*
mirror = true
threads = 3
replicationDelay = 15
```


- 配置命令

```
alias ssh-gerrit='ssh -p 29418 -i ~/.ssh/id_rsa 192.168.50.69 -l gerrit'


ssh -p 29418 gerrit@192.168.50.69 replication start --all


ssh -p 29418 gerrit@192.168.50.69 gerrit plugin reload replication


ssh -p 29418 gerrit@192.168.50.69 gerrit plugin install -n replication.jar - <~/replication.jar


ssh-gerrit gerrit plugin install -n replication.jar - <~/replication.jar

ssh -p 29418 gerrit@192.168.50.69 gerrit plugin ls


git push origin test-api:refs/for/master
```




### 安装gerrit replication插件

```
unzip gerrit.war
cp WEB-INF/plugins/replication.jar ~/temp/
ssh-gerrit gerrit plugin install -n replication.jar - <~/temp/replication.jar
```

```
报错：
fatal: remote installation is disabled
解决方法：Open YOUR_GERRIT_DIR/etc/gerrit.config file and add the following entry:

[plugins]
    allowRemoteAdmin = true
执行完成后或可执行：ssh ha gerrit plugin install -n replication.jar - <~/temp/replication.jar
ssh ha gerrit plugin ls
ssh-gerrit gerrit plugin ls
Name                           Version    Status   File
-------------------------------------------------------------------------------
replication                    v2.8       ENABLED  replication.jar

```

### 配置文件

```

[remote "chenwei/nb"]
projects = nb
url = git@192.168.50.69:chenwei/nb.git
push = +refs/heads/*:refs/heads/*
push = +refs/tags/*:refs/tags/*
push = +refs/changes/*:refs/changes/*
threads = 3
```

### 其他

```

设置gerrit用户的 ~/.ssh/config
[gerrit@ubuntu$ vim /home/gerrit/.ssh/config


Host *
    KexAlgorithms diffie-hellman-group1-sha1,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ec$

Host 192.168.50.69:
       IdentityFile ~/.ssh/id_rsa
       PreferredAuthentications publickey




在gerrit用户的~/.ssh/known_hosts 中，给192.168.50.69 添加 rsa 密钥


[gerrit@ubuntu$ sh -c "ssh-keyscan -t rsa 192.168.50.69 >> /home/gerrit/.ssh/known_hosts"
[gerrit@ubuntu$ sh -c "ssh-keygen -H -f /home/gerrit/.ssh/known_hosts"

----------------------------------------------特别注意----------------------------------------------
上面设置的~/.ssh/config文件的权限已定要设置成600
不然会报错：“Bad owner or permissions on .ssh/config“
----------------------------------------------------------------------------------------------------

重新启动 Gerrit 服务



pip3 install git-review



创建认证权限（也就是登陆的时候输入的权限）

注意：第一次加-c参数是为了创建密码文件，默认第一个用户是系统管理员

[root@ubuntu]#htpasswd -c /home/gerrit/review_site/etc/passwd  gerrit

New password:

Re-type new password:

Adding password for user gerrit

[root@ubuntu]#htpasswd /home/gerrit/review_site/etc/passwd user1

New password:

Re-type new password:

Adding password for user wangshibo

[root@ubuntu]#htpasswd /home/gerrit/review_site/etc/passwd jenkins

New password:

Re-type new password:

Adding password for user jenkins

查看下认证账号文件信息

[root@ubuntu]# cat /home/gerrit/review_site/etc/passwd

重启nginx服务

[root@ubuntu]# /usr/local/nginx/sbin/nginx -s reload


```



### 创建数据库

```
create database reviewdb;

use reviewdb;

CREATE TABLE account_group_by_id_aud (
added_by INT DEFAULT 0 NOT NULL,
removed_by INT,
removed_on TIMESTAMP NULL DEFAULT NULL,
group_id INT DEFAULT 0 NOT NULL,
include_uuid VARCHAR(255) BINARY DEFAULT '' NOT NULL,
added_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
,PRIMARY KEY(group_id,include_uuid,added_on)
);


CREATE TABLE account_group_members_audit (
added_by INT DEFAULT 0 NOT NULL,
removed_by INT,
removed_on TIMESTAMP NULL DEFAULT NULL,
account_id INT DEFAULT 0 NOT NULL,
group_id INT DEFAULT 0 NOT NULL,
added_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
,PRIMARY KEY(account_id,group_id,added_on)
);

CREATE TABLE changes (
change_key VARCHAR(60) BINARY DEFAULT '' NOT NULL,
created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
last_updated_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
sort_key VARCHAR(16) BINARY DEFAULT '' NOT NULL,
owner_account_id INT DEFAULT 0 NOT NULL,
dest_project_name VARCHAR(255) BINARY DEFAULT '' NOT NULL,
dest_branch_name VARCHAR(255) BINARY DEFAULT '' NOT NULL,
open CHAR(1) DEFAULT 'N' NOT NULL  CHECK (open IN ('Y','N')),
status CHAR(1) DEFAULT ' ' NOT NULL,
current_patch_set_id INT DEFAULT 0 NOT NULL,
subject VARCHAR(255) BINARY DEFAULT '' NOT NULL,
topic VARCHAR(255) BINARY,
last_sha1_merge_tested VARCHAR(40) BINARY,
mergeable CHAR(1) DEFAULT 'N' NOT NULL  CHECK (mergeable IN ('Y','N')),
row_version INT DEFAULT 0 NOT NULL,
change_id INT DEFAULT 0 NOT NULL
,PRIMARY KEY(change_id)
);
```
