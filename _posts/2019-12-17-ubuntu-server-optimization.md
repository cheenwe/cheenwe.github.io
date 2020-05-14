---
layout: post
title: Ubuntu 服务器优化
tags: ubuntu
category: ubuntu
---


## 更换镜像源

```
mv /etc/apt/sources.list /etc/apt/sources.list_bak

echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse" >>  /etc/apt/sources.list
echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse">>  /etc/apt/sources.list
echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse">>  /etc/apt/sources.list
echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse">>  /etc/apt/sources.list
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable">>  /etc/apt/sources.list

apt-get update 
```



## 自定义系统服务

/lib/systemd/system/slurmdbd.service


systemctl daemon-reload



## ulimit -a 用来显示当前的各种用户进程限制

ulimit -a 用来显示当前的各种用户进程限制

Linux对于每个用户，系统限制其最大进程数，为提高性能，可以根据设备资源情况，

设置个Linux用户的最大进程数，一些需要设置为无限制：

数据段长度：ulimit -d unlimited

最大内存大小：ulimit -m unlimited

堆栈大小：ulimit -s unlimited

我们在用这个命令的时候主要是为了产生core文件，就是程序运行发行段错误时的文件：

ulimit -c unlimited   

生成core文件,


## 内存占用过高，缓存不释放导致死机处理方案




> nano /etc/sysctl.conf

```
#添加

vm.min_free_kbytes = 2097152

#（命令意义：设置最小剩余内存，单位KB，这里设置2G）
```

sysctl  -p



## 定时清理缓存

> nano /root/shell/shell/clear_cache

```
#!/bin/bash
# 每一小时清除一次缓存
echo "开始清除缓存"
sync;sync;sync #写入硬盘，防止数据丢失
sleep 10 #延迟10秒
echo 3 > /proc/sys/vm/drop_caches
```

> contab -e 

    0 *  *   *   *     bash /root/shell/shell/clear_cache


### No MTA installed, discarding output

        sudo apt-get install -y postfix

## 开启 crontab 日志

进入配置文件中，

```
sudo vim /etc/rsyslog.d/50-default.conf

#将cron的日志注释去掉
cron.*  /var/log/cron.log #将cron前面的注释符去掉

#重启rsyslog
sudo  service rsyslog  restart 

#查看crontab日志
tail -f /var/log/cron.log   
```


## 限制普通用户内存

> nano /etc/security/limits.conf

```
#max virtual memory size for "users" group ::
@users           hard    as               4000000
#max memory size for "users" group  ::
@users           hard    rss             21000000
```

or

```
* hard core 0 
* hard rss 5000 
* hard nproc 20 
```

这里的“*”代表除了Root的所有用户，(* hard core 0) 是禁止core files“core 0”，(* hard rss 5000) 是限制内存使用为5MB“rss 5000”, (* hard nproc 20 )是限制进程数为“nproc 50“。可以根据自己系统内存大小进行合理配置。

## 如何限制用户的磁盘空间

apt install quota

磁盘配额的使用限制

仅针对整个分区：磁盘配额实际运行时，是针对“整个分区”进行限制的，例如，如果/dev/hda5载入在/home下，那么，在/home下面的所有目录都会受到限制。
 
核心必须支持磁盘配额：Linux系统核心必须支持磁盘配额模块。
 
磁盘配额的记录文件：使用的Kernel 2.6.XX的核心版本，这个核心版本支持新的磁盘配额模块，使用的默认文件（aquota.user、aquota.group）将不同于旧版本的quota.user和quota.group。旧版本的磁盘配额可以通过convertquota程序来转换
 

### 磁盘配额程序对硬盘配额的限制

最低限制（ soft ）：这是最低限制容量。用户在宽限期间之内，它的容量可以超过最低限制，但必须在宽限时间之内将磁盘容量降低到最低限制的容量限制范围之内。 
 
最高限制（ hard ）：这是“绝对不能超过”的容量。通常最高限制会比最低限制高。 
 
宽限时间：宽限之间是指当用户使用的空间超过了最低限制，却还没有到最高限制时，在这个“宽限时间”内，就必须请用户将使用的磁盘空间降低到最低限制之下，否则则不允许在写入。反之，则宽限时间取消


### 设置分区的文件系统支持磁盘配额参数

```
 #vi /etc/fstab
 UUID=***     ext3     defaults,usrquota,grpquota     1 2    
```

- 生成磁盘配额的配置文件

```
 quotacheck –cugm /home 生成磁盘配额的配置文件
```

在/home下生成aquota.user和aquota.group文档

a 检查任何起用了配额的在本地挂载的文档系统

b 在检查配额过程中显示周详的状态信息

u 检查用户磁盘配额信息

g 检查组群磁盘配额信息

这样就加入了磁盘配额的磁盘格式了。不过，由于真正的磁盘配额在读取时时读取/etc/mtab文件，这个文件需要重启之后才能用/etc/fstab的新数据，所以这个时候可以选择 重新启动 或者

    #mount -o remount /data


### 编辑磁盘配额限制值数据

> edquota -u test    

改为:

```
Quotas for user test:
/dev/hdax: blocks in use: 14, limits (soft=10204, hard=10204)
inodes in use: 12, limits (soft=100, hard=100)
```

其中：blocks in use:用户已使用块的大小，单位是KB。inodes in use: 用户现有文档的大小。这两项都是系统自动给出，不必改变。

### 设置一个预警期

    edquota -t 

可以把预警期设置为1天，也可以使用分钟或秒。默认软限制是7天。


### 将已配置限额的用户设置复制到其他用户

    edquota -u test1 -p test

### 给用户组配置磁盘配额限制

    edquota -g usergroup 

### 设置启动时启动磁盘配额 

    vi /etc/rc.d/rc.local /sbin/quotaon -avug


### 生成磁盘配额结果报告 

    repquota /home 


### 打开磁盘配额

```
#quotaon -a 
repquota -a[-vug]
repquota -av                           //查看所有具有磁盘配额文件系统的限制值
repquota -avu    username       //查看用户的磁盘配额限制值
repquota /dev/sdb1 //查看系统中所有用户的磁盘空间配额
```



## 解决 ssh 登录不执行 .bashrc 

login shell 和 no-login shell
“login shell” 代表用户登入, 比如使用 “su -“ 命令, 或者用 ssh 连接到某一个服务器上, 都会使用该用户默认 shell 启动 login shell 模式.

该模式下的 shell 会去自动执行 /etc/profile 和 ~/.profile 文件, 但不会执行任何的 bashrc 文件, 所以一般再 /etc/profile 或者 ~/.profile 里我们会手动去 source bashrc 文件.

而 no-login shell 的情况是我们在终端下直接输入 bash 或者 bash -c “CMD” 来启动的 shell.

该模式下是不会自动去运行任何的 profile 文件.

参考 ~/.profile:
```
# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022
 
 
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
 
 
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
```
