---

layout: post
title: 在Ubuntu 16.04上安装Ceph存储集群
tags: MariaDB  Galera Cluster
categories: ceph
---


>本文简要介绍在Ubuntu 16.04服务器上安装和构建Ceph集群。

## 介绍

[Ceph](http://docs.ceph.org.cn/)是一个开源的存储平台，它提供高性能，可靠性和可扩展性。 它是一个免费的分布式存储系统，提供对象，块和文件级存储的接口，并且可以在没有单点故障的情况下运行。 Ceph 的强大可以改变您公司的 IT 基础架构和海量数据管理能力。

### CEPH 对象存储

- REST 风格的接口
- 与 S3 和 Swift 兼容的 API
- S3 风格的子域
- 统一的 S3/Swift 命名空间
- 用户管理
- 利用率跟踪
- 条带化对象
- 云解决方案集成
- 多站点部署
- 灾难恢复
 

### CEPH 块设备

- 瘦接口支持
- 映像尺寸最大 16EB
- 条带化可定制
- 内存缓存
- 快照
- 写时复制克隆
- 支持内核级驱动
- 支持 KVM 和 libvirt
- 可作为云解决方案的后端
- 增量备份  

### CEPH 文件系统

- 与 POSIX 兼容的语义
- 元数据独立于数据
- 动态重均衡
- 子目录快照
- 可配置的条带化
- 有内核驱动支持
- 有用户空间驱动支持
- 可作为 NFS/CIFS 部署
- 可用于 Hadoop （取代 HDFS ） 

* CephFS 还缺乏健壮得像 ‘fsck’ 这样的检查和修复功能。存储重要数据时需小心使用，因为灾难恢复工具还没开发完。

##  Ceph集群

Ceph集群由以下组件组成：

- Ceph OSD（osd） - 处理数据存储，数据复制和恢复。 Ceph集群至少需要两个Ceph OSD服务器。 我们将在此设置中使用三台Ubuntu 16.04服务器。

- Ceph监视器（mon） - 监视集群状态并运行OSD映射和CRUSH映射。 我们将在这里使用一台服务器。

- Ceph Meta数据服务器（mds） - 如果要使用Ceph作为文件系统，则需要这样做。

### 准备

- 系统, 安装了Ubuntu 16.04服务器的6个服务器节点,并配置到 192.168.10.0 网段， 信息如下


```
192.168.10.147 admin
192.168.10.148 node1 
192.168.10.160 node2 
192.168.10.161 node3
```

- 修改镜像源

```

file=/etc/apt/sources.list

mv $file $file.bak

cat <<EOF >>$file

deb http://mirrors.ustc.edu.cn/ubuntu/ bionic main restricted
deb http://mirrors.ustc.edu.cn/ubuntu/ bionic-updates main restricted
deb http://mirrors.ustc.edu.cn/ubuntu/ bionic universe
deb http://mirrors.ustc.edu.cn/ubuntu/ bionic-updates universe
deb http://mirrors.ustc.edu.cn/ubuntu/ bionic multiverse
deb http://mirrors.ustc.edu.cn/ubuntu/ bionic-updates multiverse
deb http://mirrors.ustc.edu.cn/ubuntu/ bionic-security main restricted
deb http://mirrors.ustc.edu.cn/ubuntu/ bionic-security universe
deb http://mirrors.ustc.edu.cn/ubuntu/ bionic-security multiverse

EOF
cat $file


```

- 创建Ceph用户

账户名: cephuser

创建一个名为' cephuser '的新用户, 并配置cephuser以获取无密码的sudo权限

```
user=cephuser
useradd -m -s /bin/bash $user
echo -e "$user\n$user" |passwd $user
echo "$user ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$user
chmod 0440 /etc/sudoers.d/$user
sed -i s'/Defaults requiretty/#Defaults requiretty'/g /etc/sudoers
```


- 安装和配置NTP

安装NTP以在所有节点上同步日期和时间。 运行ntpdate命令通过NTP设置日期和时间。 我们将使用阿里云的NTP池服务器。 然后启动并启用NTP服务器在引导时运行。

```
sudo apt-get install -y ntp ntpdate ntp-doc
ntpdate -u ntp2.aliyun.com
hwclock --systohc
systemctl enable ntp
systemctl start ntp
```

- 安装 Open-vm-tools 

在运行VMware内的所有节点，则需要安装此虚拟化实用程序。

```
sudo apt-get install -y open-vm-tools
```

- 安装Python

```
sudo apt-get install -y python python-pip parted
```

- 配置主机文件

```

 
file=/etc/hosts
mv $file $file.bak
cat <<EOF >>$file

192.168.10.147 admin
192.168.10.148 node1
192.168.10.160 node2
192.168.10.161 node3

EOF
cat $file
```

- 修改主机 hostname

分别执行以下命令

```
hostnamectl set-hostname admin
hostnamectl set-hostname node1
...

```

## 配置ssh

我们将配置ceph -admin节点 。 管理节点用于配置监控节点和osd节点。 登录到ceph -admin节点并访问' cephuser '。

```
ssh root@admin
su - cephuser
```

管理节点用于安装和配置所有集群节点，因此admin节点上的用户必须具有连接到没有密码的所有节点的权限。 我们需要在'admin'节点上为'cephuser'配置无密码的SSH访问。

```
ssh-keygen
```

为ssh配置创建一个配置文件。


```
file=~/.ssh/config
cat <<EOF >>$file

Host admin
        Hostname admin
        User cephuser
 
Host node1
        Hostname node1
        User cephuser
 
Host node2
        Hostname node2
        User cephuser
 
Host node3
        Hostname node3
        User cephuser

EOF
cat $file

```

将配置文件的权限更改为644。

```
chmod 644 ~/.ssh/config
```

现在使用ssh-copy-id命令将密钥添加到所有节点。

```
ssh-keyscan node1 node2 node3 client mon1 >> ~/.ssh/known_hosts
ssh-copy-id node1
ssh-copy-id node2
ssh-copy-id node3

```

现在尝试从admin节点访问node1服务器，以测试无密码登录是否工作。

```
ssh node1
sudo apt update
```


## 配置Ubuntu防火墙

出于安全考虑，我们需要打开服务器上的防火墙。 最好使用Ufw（简单防火墙），这是默认的Ubuntu防火墙来保护系统。
我们将在所有节点上启用ufw，然后打开admin，mon和osd所需的端口。
 
 
###  管理节点/admin


ssh root@admin

```
sudo apt-get install -y ufw
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 2003/tcp
sudo ufw allow 4505:4506/tcp
sudo ufw enable
```

###  监视器节点/node1

登录到监视器节点'node1'并安装ufw。

ssh node1

```
sudo apt-get install -y ufw

sudo ufw allow 22/tcp
sudo ufw allow 6789/tcp
sudo ufw enable

```

### 存储节点/node1,node2,node3


1. 在每个osd节点上打开这些端口：node1，node2和node3

- 端口6800-7300。

```
sudo apt-get install -y ufw
sudo ufw allow 22/tcp
sudo ufw allow 6800:7300/tcp
sudo ufw enable
```

ufw防火墙配置完成。


## 配置Ceph OSD节点

- 文件系统背景知识

* XFS 、 btrfs 和 ext4 相比较 ext3 而言，在高伸缩性数据存储方面有几个优势。

* XFS 、 btrfs 和 ext4 都是日志文件系统，这使得在崩溃、断电后恢复时更健壮，因为这些文件系统在写入数据前会先记录所有变更。

* xfs 由 Silicon Graphics 开发，是一个成熟、稳定的文件系统。相反， btrfs 是相对年轻的文件系统，它致力于实现系统管理员梦寐以求的大规模数据存储基础，和其他 Linux 文件系统相比它有独一无二的功能和优势。

* btrfs 是写时复制（ copy-on-write ， cow ）文件系统，它支持文件创建时间戳和校验和（可校验元数据完整性）功能，所以它能探测到数据坏副本，并且用好副本修复。写时复制功能是说 btrfs 支持可写文件系统快照。 btrfs 也支持透明压缩和其他功能。

* btrfs 也集成了多设备管理功能，据此可以在底层支持异质硬盘存储，和数据分配策略。未来开发社区还会提供 fsck 、拆分、数据加密功能，这些诱人的功能正是 Ceph 集群的理想选择。



我们有3个OSD节点，每个节点都有两个硬盘分区。

```
/dev/sda 为系统分区
/dev/sdb 是空分区 - 20GB
```

使用 /dev/sdb 作为ceph磁盘。 

从admin节点登录到所有OSD节点，并使用XFS文件系统格式化 /dev/sdb 分区。

```
ssh node1
ssh node2
ssh node3
```

```
sudo fdisk -l /dev/sdb
```

通过使用parted命令，使用XFS文件系统和GPT分区表格式化 /dev/sdb 分区。
	
	
```
sudo parted -s /dev/sdb mklabel gpt mkpart primary xfs 0% 100%
```

使用mkfs命令格式化XFS格式的分区。

```
sudo apt install -y xfsprogs

sudo mkfs.xfs -f /dev/sdb
```

现在检查分区，你会看到一个XFS  /dev/sdb 分区。

```
 
sudo fdisk -s /dev/sdb
sudo blkid -o value -s TYPE /dev/sdb
```



## 构建Ceph群集

集群架构： 

![](https://docs.ceph.com/docs/master/_images/ditaa-b490c5d9d3bb6984503b59681d08337aff62e992.png)

我们将在admin的节点上安装Ceph

```
ssh root@admin
su - cephuser
```

在admin节点上安装ceph-deploy

我们已经在系统上安装了python和python-pip。 现在我们需要从pypi python存储库安装Ceph部署工具'ceph-deploy '。

使用pip命令在ceph-admin节点上安装ceph-deploy。

```
sudo pip  install -i https://pypi.tuna.tsinghua.edu.cn/simple ceph-deploy
```



安装ceph-deploy工具后，为Ceph群集配置创建一个新目录。

### 创建一个新的集群

创建一个新的集群目录。

```
mkdir cluster
cd cluster/

```
 

接下来，通过定义监视节点' node1 '，使用' ceph-deploy '命令创建一个新的集群。

```
ceph-deploy new node1

```

该命令将在集群目录中生成Ceph集群配置文件'ceph.conf'。

在[global]块下，粘贴以下配置。


nano ceph.conf

```
# Your network address
public network = 192.168.10.0/24
```


### 在所有节点上安装Ceph

现在使用单个命令从 admin节点的所有节点安装Ceph。

```
ceph-deploy install  node1 node2 node3

```

该命令将自动在所有节点上安装Ceph：node1-3  安装将需要一些时间。


在admin上执行,部署监视器节点，收集密钥。

```
ceph-deploy mon create-initial
```



该命令将创建一个监视器密钥，使用此ceph命令检查密钥。

```
ceph-deploy gatherkeys mon1

```


拷贝配置文件及管理密钥

```
ceph-deploy admin node1 node2 node3
```


部署管理节点

```
ceph-deploy mgr create node1 
```



添加 OSD磁盘

```
ceph-deploy osd create --data /dev/sdb node1
ceph-deploy osd create --data /dev/sdb node2
ceph-deploy osd create --data /dev/sdb node3
```

检查集群状态


```
ssh mon1 sudo ceph health
ssh mon1 sudo ceph -s
```



添加监控节点

```
ceph-deploy mon add node2 node3

```


添加管理节点

```
ceph-deploy mgr create node2 node3
ssh node1 sudo ceph -s

```

添加CEPH对象网关

要使用Ceph的CEPH对象网关组件，必须部署RGW实例。执行以下操作以创建新的RGW实例：

```
ceph-deploy rgw create node1
```

默认情况下，RGW实例将监听端口7480。这可以通过在运行RGW的节点上编辑ceph.conf进行更改，如下所示：

```
[client]
rgw frontends = civetweb port=80
```


存储/检索对象数据

要在Ceph存储集群中存储对象数据，Ceph客户端必须：

1. 设置对象名称
2. 指定池

Ceph客户端检索最新的集群映射，CRUSH算法计算如何将对象映射到放置组，然后计算如何动态地将放置组分配给Ceph OSD守护进程。要查找对象位置，只需要对象名和池名。例如：

```
ceph osd map {poolname} {object-name}

#As an exercise, lets create an object. Specify an object name, a path to a test file containing some object data and a pool name using the rados put command on the command line. For example:

echo {Test-data} > testfile.txt
ceph osd pool create mytest
rados put {object-name} {file-path} --pool=mytest
rados put test-object-1 testfile.txt --pool=mytest

# To verify that the Ceph Storage Cluster stored the object, 
rados -p mytest ls

#  identify the object location:

ceph osd map {pool-name} {object-name}
ceph osd map mytest test-object-1

# To remove the test object
rados rm test-object-1 --pool=mytest

#To delete the mytest pool:
ceph osd pool rm mytest


```

## 其他

### 将OSDS添加到群集

在所有节点上安装Ceph之后，现在我们可以将OSD守护程序添加到集群中。 OSD守护进程将在磁盘 /dev/sdb 上创建数据和日志分区。

检查所有osd节点上的可用磁盘 /dev/sdb 。

```
ceph-deploy disk list  osd1 osd2 osd3

```


显示如下：

```
[ceph_deploy.conf][DEBUG ] found configuration file at: /home/cephuser/.cephdeploy.conf
[ceph_deploy.cli][INFO  ] Invoked (2.0.1): /usr/local/bin/ceph-deploy disk list osd1 osd2 osd3
[ceph_deploy.cli][INFO  ] ceph-deploy options:
[ceph_deploy.cli][INFO  ]  username                      : None
[ceph_deploy.cli][INFO  ]  verbose                       : False
[ceph_deploy.cli][INFO  ]  debug                         : False
[ceph_deploy.cli][INFO  ]  overwrite_conf                : False
[ceph_deploy.cli][INFO  ]  subcommand                    : list
[ceph_deploy.cli][INFO  ]  quiet                         : False
[ceph_deploy.cli][INFO  ]  cd_conf                       : <ceph_deploy.conf.cephdeploy.Conf instance at 0x7fb6a25a35f0>
[ceph_deploy.cli][INFO  ]  cluster                       : ceph
[ceph_deploy.cli][INFO  ]  host                          : ['osd1', 'osd2', 'osd3']
[ceph_deploy.cli][INFO  ]  func                          : <function disk at 0x7fb6a2a77ad0>
[ceph_deploy.cli][INFO  ]  ceph_conf                     : None
[ceph_deploy.cli][INFO  ]  default_release               : False
[osd1][DEBUG ] connection detected need for sudo
[osd1][DEBUG ] connected to host: osd1
[osd1][DEBUG ] detect platform information from remote host
[osd1][DEBUG ] detect machine type
[osd1][DEBUG ] find the location of an executable
[osd1][INFO  ] Running command: sudo fdisk -l
[osd1][INFO  ] Disk /dev/sda: 20 GiB, 21474836480 bytes, 41943040 sectors
[osd1][INFO  ] Disk /dev/sdb: 20 GiB, 21474836480 bytes, 41943040 sectors
[osd2][DEBUG ] connection detected need for sudo
[osd2][DEBUG ] connected to host: osd2
[osd2][DEBUG ] detect platform information from remote host
[osd2][DEBUG ] detect machine type
[osd2][DEBUG ] find the location of an executable
[osd2][INFO  ] Running command: sudo fdisk -l
[osd2][INFO  ] Disk /dev/sda: 20 GiB, 21474836480 bytes, 41943040 sectors
[osd2][INFO  ] Disk /dev/sdb: 20 GiB, 21474836480 bytes, 41943040 sectors
[osd3][DEBUG ] connection detected need for sudo
[osd3][DEBUG ] connected to host: osd3
[osd3][DEBUG ] detect platform information from remote host
[osd3][DEBUG ] detect machine type
[osd3][DEBUG ] find the location of an executable
[osd3][INFO  ] Running command: sudo fdisk -l
[osd3][INFO  ] Disk /dev/sdb: 20 GiB, 21474836480 bytes, 41943040 sectors
[osd3][INFO  ] Disk /dev/sda: 20 GiB, 21474836480 bytes, 41943040 sectors

```


接下来，使用zap选项删除所有节点上的分区表。

```
ceph-deploy disk zap osd1 /dev/sdb 
ceph-deploy disk zap osd2 /dev/sdb 
ceph-deploy disk zap osd3 /dev/sdb 
```


该命令将删除Ceph OSD节点上/dev/sdb上的所有数据。
 

初始化 osd 节点上的sdb磁盘
 
```

# 省略db 与wal的说明，只指定data则为 (创建于同一个盘)

ceph-deploy  --overwrite-conf  osd create --data /dev/sdb osd1
ceph-deploy  --overwrite-conf  osd create --data /dev/sdb osd2
ceph-deploy  --overwrite-conf  osd create --data /dev/sdb osd3

# 数据日志存在不同的盘符
# ceph-deploy osd create node1 --data /dev/sde --block-db /dev/sdf1 --block-wal /dev/sdf2

```

现在可以再次检查OSDS节点上的sdb磁盘。

```
ceph-deploy disk list osd1 osd2 osd3
```


结果是/dev/sdb现在有两个分区：

1. /dev/sdb1 - Ceph数据
2. /dev/sdb2 - Ceph Journal

或者您直接在OSD节点上查看。

``` 
ssh osd1
sudo fdisk -l /dev/sdb
```

接下来，将管理密钥部署到所有关联的节点。

```
ceph-deploy admin admin mon1 osd1 osd2 osd3
```

通过在所有节点上运行以下命令来更改密钥文件的权限。

```
sudo chmod 644 /etc/ceph/ceph.client.admin.keyring
```

## 测试Ceph

从admin节点登录到Ceph监视服务器 ' mon1 '

```
ssh mon1
```

运行以下命令以检查群集运行状况。

```
sudo ceph health
```

现在检查集群状态。

```
sudo ceph -s
```

您可以看到以下结果：


确保Ceph健康状况正常 ，并且有一个监视器节点' mon1 '，IP地址为“ 192.168.10.148 ”。 

有3台OSD服务器，所有这些都是启动和运行的，应该有可用的磁盘空间为45GB - 3x15GB Ceph Data OSD分区。

至此已成功构建了一个新的Ceph集群。

 
 

## 卸载

```
ceph-deploy purge  admin mon1 osd1 osd2 osd3
ceph-deploy purgedata   admin mon1 osd1 osd2 osd3
ceph-deploy forgetkeys
rm ceph.*
```

## 命令记录

###   重启osd服务

```
systemctl status ceph-osd.target

vi /etc/systemd/system/ceph-osd.target.wants/ceph-osd@0.service

systemctl daemon-reload

systemctl restart ceph-osd.target
```


## 问题

###  monclient: ERROR: missing keyring, cannot use cephx for authentication



https://blog.csdn.net/don_chiang709/article/details/93620825


http://www.tang-lei.com/tags/ceph/



###  pip 报错

```
	apt-get remove python-pip python3-pip
	wget https://bootstrap.pypa.io/get-pip.py
	python get-pip.py
	python3 get-pip.py


	#sudo python -m pip install --upgrade --force pip
	pip install pip -U
	pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```
