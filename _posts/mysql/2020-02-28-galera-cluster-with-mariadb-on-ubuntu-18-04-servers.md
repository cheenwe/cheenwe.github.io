---
layout: post
title: Ubuntu 1804 使用 MariaDB 配置 Galera 群集
tags: MariaDB  Galera Cluster
categories: mysql
---



>本文简要介绍 MariaDB Galera集群,并提供在 Ubuntu1804 上完整的搭建集群的操作步骤


[MariaDB](https://downloads.mariadb.org/mariadb/repositories/#mirror=heanet-ltd) 是一个开源的关系数据库系统，与流行的MySQL RDBMS系统完全兼容。

[Galera](https://galeracluster.com/)是一种数据库集群解决方案，使您可以使用同步复制设置多主集群。 Galera自动处理保持不同节点上的数据同步，同时允许您向集群中的任何节点发送读写查询。
 

##  集群配置

群集通过将更改分发到不同的服务器来为数据库添加高可用性。 如果其中一个实例失败，其他实例可以快速继续提供服务。

集群有两种常规配置， 主动 - 被动和主动 - 主动 。 

- 在主动 - 被动群集中，所有写入都在单个活动服务器上完成，然后复制到一个或多个被动服务器，这些服务器只有在活动服务器发生故障时才能接管。 一些主动 - 被动群集还允许在被动节点上进行SELECT操作。

- 在主动 - 主动群集中，每个节点都是读写的，对一个节点的更改将复制到所有节点。

##  Galera集群的特点

1. 同步复制
2. 多个主服务器的拓扑结构
3. 可以在任意节点上进行读写
4. 自动控制成员
5. 自动删除故障节点
6. 自动加入节点
7. 真正给予行级别的并发复制
8. 调度客户连接
9. 没有Slave延迟
10. 不会丢失数据
11. 读取和写入的可扩展性
12. 客户端延迟较小


##  搭建Galera集群的先决条件

应该在群集中放置多少个节点？

    没有上限，但你应该总是选择一个奇数：3,5,7等等，以防止相关问题，Galera集群至少需要3个节点才能安全防范. 
    
为什么至少要三个节点呢？
    
    因为如果只有两个节点，一旦出现数据不统一，会发生脑裂现象，也就是系统并不知道到底以哪一个节点的结果为正确
    的结果，引入第三个节点，提供一个仲裁功能，确保了数据的准确性和统一性参考性。
 


## 实操

- 准备 3 台虚拟机分别为 n1, n2, n3 并保证能正常联网
- 如无特殊说明,以下所有命令均需在 3 台机器上执行
- 建议切换到 root 账户下操作

>sudo -i


### 配置 hosts


```
cat <<EOF >>/etc/hosts

192.168.10.155 n1
192.168.10.153 n3
192.168.10.150 n2

EOF
cat /etc/hosts

```


###  使用清华源安装

```
sudo apt-get install -y software-properties-common libmysqlclient20 rsync

sudo apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
sudo add-apt-repository 'deb [arch=amd64,arm64,ppc64el] http://mirrors.tuna.tsinghua.edu.cn/mariadb/repo/10.4/ubuntu bionic main'

sudo apt install -y mariadb-server

```

### 设置 MariaDB 密码

从MariaDB版本10.4开始，默认情况下根 MariaDB用户没有密码。 要为root用户设置密码，请首先登录MariaDB：

```
sudo mysql -uroot

set password = password("root");
```





### 配置 
#### n1

```
cat <<EOF >>/etc/mysql/conf.d/galera.cnf

[mysqld]
binlog_format=ROW
default-storage-engine=innodb
innodb_autoinc_lock_mode=2
bind-address=0.0.0.0

# Galera Provider Configuration
wsrep_on=ON
wsrep_provider=/usr/lib/galera/libgalera_smm.so

# Galera Cluster Configuration
wsrep_cluster_name="test_cluster"
wsrep_cluster_address="gcomm://n1,n2,n3"

# Galera Synchronization Configuration
wsrep_sst_method=rsync

# Galera Node Configuration
wsrep_node_address="n1"
wsrep_node_name="M1"

EOF
cat /etc/mysql/conf.d/galera.cnf
```




#### n2

```
cat <<EOF >>/etc/mysql/conf.d/galera.cnf

[mysqld]
binlog_format=ROW
default-storage-engine=innodb
innodb_autoinc_lock_mode=2
bind-address=0.0.0.0

# Galera Provider Configuration
wsrep_on=ON
wsrep_provider=/usr/lib/galera/libgalera_smm.so

# Galera Cluster Configuration
wsrep_cluster_name="test_cluster"
wsrep_cluster_address="gcomm://n1,n2,n3"

# Galera Synchronization Configuration
wsrep_sst_method=rsync

# Galera Node Configuration
wsrep_node_address="n2"
wsrep_node_name="M2"

EOF
cat /etc/mysql/conf.d/galera.cnf

```




#### n3


```
cat <<EOF >>/etc/mysql/conf.d/galera.cnf

[mysqld]
binlog_format=ROW
default-storage-engine=innodb
innodb_autoinc_lock_mode=2
bind-address=0.0.0.0

# Galera Provider Configuration
wsrep_on=ON
wsrep_provider=/usr/lib/galera/libgalera_smm.so

# Galera Cluster Configuration
wsrep_cluster_name="test_cluster"
wsrep_cluster_address="gcomm://n1,n2,n3"

# Galera Synchronization Configuration
wsrep_sst_method=rsync

# Galera Node Configuration
wsrep_node_address="n3"
wsrep_node_name="M3"

EOF
cat /etc/mysql/conf.d/galera.cnf

```



- 第一部分修改或重新声明将允许群集正常运行的MariaDB / MySQL设置。 例如，Galera不能与MyISAM或类似的非事务性存储引擎一起使用，并且mysqld不能绑定到localhost的IP地址。 

- “Galera Provider Configuration” 部分配置提供WriteSet复制API的MariaDB组件。 这意味着Galera在您的情况下，因为Galera是一个wsrep （WriteSet复制）提供程序。 您可以指定用于配置初始复制环境的常规参数。 

- “Galera Cluster Configuration” 部分定义群集，通过IP地址或可解析的域名标识群集成员，并为群集创建名称以确保成员加入正确的群组。 您可以将wsrep_cluster_name更改为比test_cluster更有意义的test_cluster或保持原样，但必须使用三台服务器的专用IP地址更新wsrep_cluster_address 。

- “Galera Synchronization Configuration” 部分定义了集群如何在成员之间进行通信和同步数据。 这仅用于节点联机时发生的状态转移。 对于初始设置，您使用的是rsync ，因为它通常可用并且可以完成您现在需要的操作。

- “Galera Node Configuration” 部分阐明了IP地址和当前服务器的名称。 在尝试诊断日志中的问题以及以多种方式引用每个服务器时，这很有用。 wsrep_node_address必须与您所在机器的地址匹配，但您可以选择所需的任何名称，以帮助您识别日志文件中的节点。
 
### 配置防火墙

```
sudo ufw status
service  ufw status
sudo ufw allow 3306,4567,4568,4444/tcp
sudo ufw allow 4567/udp
sudo ufw start
sudo ufw enable 
sudo ufw status
```



Galera可以使用四个端口：

- 3306对于使用mysqldump方法的MySQL客户端连接和状态快照传输。
- 4567对于Galera Cluster复制流量。 多播复制在此端口上同时使用UDP传输和TCP。
- 4568增量国家转移。
- 4444用于所有其他状态快照转移。

### 启动集群


启动MariaDB群集前先，需要停止正在运行的MariaDB服务，以便可以使群集联机。

```
sudo systemctl stop mysql
sudo systemctl status mysql

```

#### 打开第一个节点 n1

```
sudo galera_new_cluster

mysql -u root -p -e "SHOW STATUS LIKE 'wsrep_cluster_size'"
```

此处应该输出一个节点

```
+--------------------+-------+
| Variable_name      | Value |
+--------------------+-------+
| wsrep_cluster_size | 1     |
+--------------------+-------+
```


#### 打开第二个节点 n2
现在您可以调出第二个节点。 启动mysql 

```
sudo systemctl start mysql
mysql -u root -p -e "SHOW STATUS LIKE 'wsrep_cluster_size'"
```
您将看到以下输出，指示第二个节点已加入群集，并且总共有两个节点。

```
+--------------------+-------+
| Variable_name      | Value |
+--------------------+-------+
| wsrep_cluster_size | 2     |
+--------------------+-------+

```
#### 打开第三个节点 n3

```
sudo systemctl start mysql
mysql -u root -p -e "SHOW STATUS LIKE 'wsrep_cluster_size'"
```
您将看到以下输出，指示第二个节点已加入群集，并且总共有两个节点。

```
+--------------------+-------+
| Variable_name      | Value |
+--------------------+-------+
| wsrep_cluster_size | 3     |
+--------------------+-------+

```

整个群集已联机并成功通信


### 测试集群


#### 第一个节点 n1

```
mysql -u root -p -e 'CREATE DATABASE playground;
CREATE TABLE playground.equipment ( id INT NOT NULL AUTO_INCREMENT, type VARCHAR(50), quant INT, color VARCHAR(25), PRIMARY KEY(id));
INSERT INTO playground.equipment (type, quant, color) VALUES ("slide", 2, "blue");'
```

#### 第二个节点 n2

```
mysql -u root -p -e 'SELECT * FROM playground.equipment;'

mysql -u root -p -e 'INSERT INTO playground.equipment (type, quant, color) VALUES ("swing", 10, "yellow");'

```

#### 第三个节点 n3

```
mysql -u root -p -e 'SELECT * FROM playground.equipment;'

mysql -u root -p -e 'INSERT INTO playground.equipment (type, quant, color) VALUES ("seesaw", 3, "green");'

```

#### 任一节点执行

```
mysql -u root -p -e 'SELECT * FROM playground.equipment;'
```

将看到有 3 条记录输出


如果在生产环境中使用Galera集群，建议不少于五个节点开始。
