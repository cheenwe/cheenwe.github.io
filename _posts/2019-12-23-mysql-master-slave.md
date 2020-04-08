---
layout: post
title: MySQL 自从配置
tags:  mysql
category:  mysql
---

使用相同的软件源安装 mysql , 保证安装到的版本一致

环境: 

    master 192.168.10.1

    slave 192.168.10.20

同步数据库名:  db_crm ;

### master 节点配置

1. 创建数据库和表

2. 停止数据库

    service mysql stop

3. 编辑配置文件

    nano /etc/mysql/mysql.conf.d/mysqld.cnf

```
# 在 mysqld 下添加
[mysqld]
log-bin=mysql-bin-master          #启用二进制日志
server-id=1                       #本机数据库ID 标示
binlog-do-db=db_crm               #可以被从服务器复制的库, 二进制需要同步的数据库名
binlog-ignore-db=mysql            #不可以被从服务器复制的库
```

4. 重启服务

    service mysql restart   

5. 创建同步用户并授权

    grant replication slave on *.* to slave@'%'  identified by "slave";
    show master status; 

6. 查看二进制文件
    
    ls -l /var/lib/mysql/

7. 查看主服务器上状态
    
    show processlist\G 

### slave 节点配置

确保两台数据库服务器mysql版本要一致

1. 测试能否连接到主数据库

    mysql -uslave -pslave -h 192.168.10.1

2. 编辑配置文件

    nano /etc/mysql/mysql.conf.d/mysqld.cnf

```
# 在 mysqld 下添加
[mysqld]
server-id=2 
#从服务器ID号，不要和主ID相同 ，如果设置多个从服务器，每个从服务器必须有一个唯一的server-id值，必须与主服务器的以及其它从服务器的不相同。可以认为server-id值类似于IP地址：这些ID值能唯一识别复制服务器群集中的每个服务器实例。
```

    service mysql restart   

3. 配置从机

```
#进入从机数据库
mysql -uroot -p


stop slave;

change master to master_host='192.168.10.1',master_user='slave',master_password='slave';

start slave;

show slave status\G

#出现以下即可
#             Slave_IO_Running: Yes            #负责与主机的io通信
#            Slave_SQL_Running: Yes            #负责自己的slave mysql进程
```

4. 可以在主节点上创建表及数据, 在从节点上查看同步状态


### 主从不同步修复

从库同步状态异常。主从同步已停止，报以下错误： Client requested master to start replication from position > file size

解决： 

1. 切换到主库的日志目录下

    cd /data/mysql/data/

找到最后一个 bin log, 查看文件日志
 
    mysqlbinlog master-bin.000008 > masterbin000008.log

    tail -f masterbin000008.log

    #191223 14:16:38 server id 1  end_log_pos 94193 CRC32 0x2c12ce4a    Xid = 2439

#171206  8:54:08 server id 1  end_log_pos 601220873 CRC32 0x2ebaec99    Xid = 2190302874

end_log_pos 94193 比 报错提示的 2439 大很多，直接从 94193 开始重新配置主从


执行命令：

```
stop slave;
change master to master_log_file='mysql-bin-master.000008',master_log_pos=94193;
start slave;
show slave status\G #查看从库状态，发现主从同步已恢复
```

判断主从完全同步方式：
首先Master_Log_File和Relay_Master_Log_File所指向的文件必须一致。
其次Relay_Log_Pos和Exec_Master_Log_Pos的为止也要一致才行。
