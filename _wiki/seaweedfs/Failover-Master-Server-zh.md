## Introduction

Some user will ask for no single point of failure. Although google runs its file system with a single master for years, no SPOF seems becoming a criteria for architects to pick solutions.

Luckily, it's not too difficult to enable Weed File System with failover master servers.

有些用户会要求没有单点故障。 尽管谷歌多年来一直使用单一主数据库管理其文件系统，但是没有SPOF似乎成为架构师选择解决方案的标准。

幸运的是，在故障转移主服务器上启用 Weed 文件系统并不困难。

## Cheat Sheet: Startup multiple servers
##备忘单：启动多个服务器

This section is a quick way to start 3 master servers and 3 volume servers. All done!

本部分是启动3个主服务器和3个卷服务器的快速方法。 全做完了！

```bash
weed server -master.port=9333 -dir=./1 -volume.port=8080 \ 
  -master.peers=localhost:9333,localhost:9334,localhost:9335
weed server -master.port=9334 -dir=./2 -volume.port=8081 \ 
  -master.peers=localhost:9333,localhost:9334,localhost:9335
weed server -master.port=9335 -dir=./3 -volume.port=8082 \ 
  -master.peers=localhost:9333,localhost:9334,localhost:9335
```

Or, you can use this "-peers" settings to add master servers one by one.

或者，您可以使用此“-peers”设置逐个添加主服务器。

```bash
> weed server -master.port=9333 -dir=./1 -volume.port=8080
> weed server -master.port=9334 -dir=./2 -volume.port=8081 -master.peers=localhost:9333
> weed server -master.port=9335 -dir=./3 -volume.port=8082 -master.peers=localhost:9334
```

## How it works
## 如何工作

The master servers are coordinated by Raft protocol, to elect a leader. The leader took over all the work to manage volumes, assign file ids. All other master servers just simply forward requests to the leader.

If the leader dies, another leader will be elected. And all the volume servers will send their heartbeat together with their volumes information to the new leader. The new leader will take the full responsibility.

During the transition, there could be moments where the new leader has partial information about all volume servers. This just means those yet-to-heartbeat volume servers will not be writable temporarily.

主服务器由Raft协议协调，选出一位领导。 领导接管了所有的工作来管理卷，分配文件ID。 所有其他主服务器只是简单地向领导转发请求。

如果领导人死亡，另一名领导人将被选举。 所有的卷服务器将把他们的心跳信息和卷信息一起发送给新的领导者。 新领导将全权负责。

在转换过程中，可能会有新的领导人有关于所有卷服务器的部分信息。 这只是意味着那些尚未完成的卷服务器将暂时不可写入。

## Startup multiple master servers
## 启动多个主服务器

Now let's start the master and volume servers separately, the usual way.

Usually you would start several (3 or 5) master servers, then start the volume servers:

现在让我们以通常的方式分别启动主服务器和卷服务器。

通常你会启动几个（3或5）主服务器，然后启动卷服务器：

```bash
weed master -port=9333 -mdir=./1
weed master -port=9334 -mdir=./2 -peers=localhost:9333
weed master -port=9335 -mdir=./3 -peers=localhost:9334
# now start the volume servers, specifying any one of the master server
# 现在启动卷服务器，指定任何一个主服务器
weed volume -dir=./1 -port=8080
weed volume -dir=./2 -port=8081 -mserver=localhost:9334
weed volume -dir=./3 -port=8082 -mserver=localhost:9335
```

These 6 commands will actually functioning the same as the previous 3 commands from the cheatsheet.

Even though we only specified one peer in "-peers" option to bootstrap, the master server will get to know all the other master servers in the cluster, and store these information in the local directory.

这6个命令实际上与前面的3个命令的功能相同。

即使我们只在“-peers”选项中指定了一个对等体进行引导，主服务器也会知道群集中的所有其他主服务器，并将这些信息存储在本地目录中。


# 配置　History

master 1: 192.168.100.117
master 2: 192.168.100.172
master 3: 192.168.100.2

主 1:
weed master -port=9333 -mdir=./1 -ip=192.168.100.117 
weed volume -dir=./1 -port=8080 -mserver=192.168.100.117:9333 -ip=192.168.100.117 

主 2:
weed master -port=9333 -mdir=./2 -peers=192.168.100.117:9333  -ip=192.168.100.172
weed volume -dir=./2 -port=8080 -mserver=192.168.100.172:9333 -ip=192.168.100.172

主 3:
weed master -port=9333 -mdir=./3 -peers=192.168.100.117:9333  -ip=192.168.100.2
weed volume -dir=./3 -port=8080 -mserver=192.168.100.2:9333 -ip=192.168.100.2

 
关闭　weed

kill -9 $(ps aux | grep weed |  grep -v grep | awk '{print $2}') #关闭进程标示为: weed 的服务


上传文件
curl -F file=@/tmp/1.jpg http://localhost:9333/submit


alias s1='ssh chenwei@192.168.100.172'
alias s2='ssh ubuntu@192.168.100.117'


ssh-copy-id chenwei@192.168.100.172
ssh-copy-id ubuntu@192.168.100.117

scp go1.9.2.linux-amd64.tar.gz ubuntu@192.168.100.117:~/
　