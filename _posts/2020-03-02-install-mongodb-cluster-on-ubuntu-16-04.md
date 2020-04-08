---
layout: post
title: MongoDB 安装,集群搭建及基础命令
tags: MongoDB Cluster
category: MongoDB
---

介绍安装 MongoDB副本集搭建及基础使用命令


## 安装 MongoDB 4.2

参考:  https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/#

- 官方安装

```
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
sudo apt-get install gnupg 

echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list # 1804


# echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list # 1604

sudo apt-get update

sudo apt-get install -y mongodb-org
```


- 国内源

https://mirrors.tuna.tsinghua.edu.cn/help/mongodb/


## 重启命令

```
sudo systemctl start mongod

sudo systemctl status mongod

sudo systemctl enable mongod #开机启动
```

## usage

> mongo




## 卸载

```
sudo apt-get purge mongodb-org*
sudo rm -r /var/log/mongodb
sudo rm -r /var/lib/mongodb
```


## 集群简介


mongodb集群搭建有三种方式。

1. Master-Slave模式
2. Replica-Set方式
3. Sharding方式

官方推荐副本集和分片的方式, 下面使用副本集方式搭建 mongodb 集群.


## 部署集群


- 在单台 PC 上 操作

- 3 个 mongo服务 开启端口分别:27010, 27011, 27012: 

- hostname 为 n1, 可以改成对应的 ip


### 部署复制集


```
path=/home/chenwei

mkdir master slaver arbiter


cat <<EOF >>master.conf

dbpath=/home/chenwei/master
logpath=/home/chenwei/master.log
pidfilepath=/home/chenwei/master.pid
directoryperdb=true
logappend=true
replSet=HPC
bind_ip=0.0.0.0
port=27010
oplogSize=10000
fork=true

EOF


cat <<EOF >>slaver.conf

dbpath=/home/chenwei/slaver
logpath=/home/chenwei/slaver.log
pidfilepath=/home/chenwei/slaver.pid
directoryperdb=true
logappend=true
replSet=HPC
bind_ip=0.0.0.0
port=27011
oplogSize=10000
fork=true

EOF

cat <<EOF >>arbiter.conf

dbpath=/home/chenwei/arbiter
logpath=/home/chenwei/arbiter.log
pidfilepath=/home/chenwei/arbiter.pid
directoryperdb=true
logappend=true
replSet=HPC
bind_ip=0.0.0.0
port=27012
oplogSize=10000
fork=true

EOF

mongod -f master.conf
mongod -f slaver.conf
mongod -f arbiter.conf

```


初始化复制集：

mongo -p 27010
```

use admin

rs.initiate( {
   _id : "HPC",
   members: [
      { _id: 0, host: "n1:27010" },
      { _id: 1, host: "n1:27011"},
      { _id: 2, host: "n1:27012" }
   ]
})

```

查看配置情况

```

rs.conf()

rs.status()
```

显示如下

```
{
  "set" : "HPC",
  "date" : ISODate("2020-03-03T08:04:54.714Z"),
  "myState" : 1,
  "term" : NumberLong(1),
  "syncingTo" : "",
  "syncSourceHost" : "",
  "syncSourceId" : -1,
  "heartbeatIntervalMillis" : NumberLong(2000),
  "majorityVoteCount" : 2,
  "writeMajorityCount" : 2,
  "optimes" : {
    "lastCommittedOpTime" : {
      "ts" : Timestamp(0, 0),
      "t" : NumberLong(-1)
    },
    "lastCommittedWallTime" : ISODate("1970-01-01T00:00:00Z"),
    "appliedOpTime" : {
      "ts" : Timestamp(1583222693, 5),
      "t" : NumberLong(1)
    },
    "durableOpTime" : {
      "ts" : Timestamp(1583222693, 5),
      "t" : NumberLong(1)
    },
    "lastAppliedWallTime" : ISODate("2020-03-03T08:04:53.892Z"),
    "lastDurableWallTime" : ISODate("2020-03-03T08:04:53.892Z")
  },
  "lastStableRecoveryTimestamp" : Timestamp(0, 0),
  "lastStableCheckpointTimestamp" : Timestamp(0, 0),
  "electionCandidateMetrics" : {
    "lastElectionReason" : "electionTimeout",
    "lastElectionDate" : ISODate("2020-03-03T08:04:53.108Z"),
    "electionTerm" : NumberLong(1),
    "lastCommittedOpTimeAtElection" : {
      "ts" : Timestamp(0, 0),
      "t" : NumberLong(-1)
    },
    "lastSeenOpTimeAtElection" : {
      "ts" : Timestamp(1583222682, 1),
      "t" : NumberLong(-1)
    },
    "numVotesNeeded" : 2,
    "priorityAtElection" : 1,
    "electionTimeoutMillis" : NumberLong(10000),
    "numCatchUpOps" : NumberLong(0),
    "newTermStartDate" : ISODate("2020-03-03T08:04:53.834Z")
  },
  "members" : [
    {
      "_id" : 0,
      "name" : "n1:27010",
      "health" : 1,
      "state" : 1,
      "stateStr" : "PRIMARY",
      "uptime" : 267,
      "optime" : {
        "ts" : Timestamp(1583222693, 5),
        "t" : NumberLong(1)
      },
      "optimeDate" : ISODate("2020-03-03T08:04:53Z"),
      "syncingTo" : "",
      "syncSourceHost" : "",
      "syncSourceId" : -1,
      "infoMessage" : "could not find member to sync from",
      "electionTime" : Timestamp(1583222693, 1),
      "electionDate" : ISODate("2020-03-03T08:04:53Z"),
      "configVersion" : 1,
      "self" : true,
      "lastHeartbeatMessage" : ""
    },
    {
      "_id" : 1,
      "name" : "n1:27011",
      "health" : 1,
      "state" : 2,
      "stateStr" : "SECONDARY",
      "uptime" : 12,
      "optime" : {
        "ts" : Timestamp(1583222682, 1),
        "t" : NumberLong(-1)
      },
      "optimeDurable" : {
        "ts" : Timestamp(1583222682, 1),
        "t" : NumberLong(-1)
      },
      "optimeDate" : ISODate("2020-03-03T08:04:42Z"),
      "optimeDurableDate" : ISODate("2020-03-03T08:04:42Z"),
      "lastHeartbeat" : ISODate("2020-03-03T08:04:53.122Z"),
      "lastHeartbeatRecv" : ISODate("2020-03-03T08:04:54.237Z"),
      "pingMs" : NumberLong(0),
      "lastHeartbeatMessage" : "",
      "syncingTo" : "",
      "syncSourceHost" : "",
      "syncSourceId" : -1,
      "infoMessage" : "",
      "configVersion" : 1
    },
    {
      "_id" : 2,
      "name" : "n1:27012",
      "health" : 1,
      "state" : 2,
      "stateStr" : "SECONDARY",
      "uptime" : 12,
      "optime" : {
        "ts" : Timestamp(1583222682, 1),
        "t" : NumberLong(-1)
      },
      "optimeDurable" : {
        "ts" : Timestamp(1583222682, 1),
        "t" : NumberLong(-1)
      },
      "optimeDate" : ISODate("2020-03-03T08:04:42Z"),
      "optimeDurableDate" : ISODate("2020-03-03T08:04:42Z"),
      "lastHeartbeat" : ISODate("2020-03-03T08:04:53.124Z"),
      "lastHeartbeatRecv" : ISODate("2020-03-03T08:04:54.319Z"),
      "pingMs" : NumberLong(0),
      "lastHeartbeatMessage" : "",
      "syncingTo" : "",
      "syncSourceHost" : "",
      "syncSourceId" : -1,
      "infoMessage" : "",
      "configVersion" : 1
    }
  ],
  "ok" : 1,
  "$clusterTime" : {
    "clusterTime" : Timestamp(1583222693, 5),
    "signature" : {
      "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
      "keyId" : NumberLong(0)
    }
  },
  "operationTime" : Timestamp(1583222693, 5)
}
```

1台为PRIMARY，其他2台为SECONDARY。



### 分片复制集

TODO


## 基本命令用法


### 创建数据库

```
use demo

#如果数据库不存在，则创建数据库，否则切换到指定数据库。

db.dropDatabase()
# 删除


show dbs
# 查看数据库

```

### 增删改查

```
db.demo.insert({"name":"test"})
db.demo.insert({'title':'MongoDB 教程'})
db.demo.find()
db.demo.remove({'title':'MongoDB 教程'})
db.demo.find()

db.demo.update({'name':'test'},{$set:{'title':'MongoDB test'}})

```

### 集合

```

db.createCollection("co_users")

db.co_users.insert({"name" : "cw"})

db.co_users.find()

show collections

db.createCollection("mycol", { capped : true, autoIndexId : true, size : 6142800, max : 10000 } )

# 创建固定集合 mycol，整个集合空间大小 6142800 KB, 文档最大个数为 10000 个。


db.mycol.drop()
```





## 报错解决

### not master and slaveOk=false

因为SECONDARY是不允许读写的， 在写多读少的应用中，使用Replica Sets来实现读写分离。通过在连接时指定或者在主库指定slaveOk，由Secondary来分担读的压力，Primary只承担写操作。
对于replica set 中的secondary 节点默认是不可读的，

- 解决方法: 

在主库上设置 slaveok=ok

>db.getMongo().setSlaveOk();
