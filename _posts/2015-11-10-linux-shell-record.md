---
layout: post
title: linux 命令记录
tags: shell linux
category: linux
---

# 需求
日常使用过程中各种命令记录

## 使用time计算命令执行的时间

    /usr/bin/time -f "time: %E" echo "mypasswd" | cap production deploy

## 文件查找与打印文件列表命令find

### 在/home目录下查找以.rb结尾的文件名
    find /home -name "*.rb"
同上，但忽略大小写

    find /home -iname "*.rb"

### 在/home目录下查找不是以.rb结尾的文件名
    find /home ! -name "*.rb"

### 搜索指定目录下特定字符串并高亮显示匹配关键词
    find ./ -name "*" | xargs grep --color=auto "mysql"

### 当前目录及子目录下查找所有以.rb和.md结尾的文件
    find . -name "*.rb" -o -name "*.md"

### 基于目录深度搜索
    find . -maxdepth 3 -type f

### 根据文件时间戳进行搜索
    find . -type f -atime -7

    find . -type f 时间戳
    UNIX/Linux文件系统每个文件都有三种时间戳：

    访问时间（-atime/天，-amin/分钟）：用户最近一次访问时间。
    修改时间（-mtime/天，-mmin/分钟）：文件最后一次修改时间。
    变化时间（-ctime/天，-cmin/分钟）：文件数据元（例如权限等）最后一次修改时间。


### 删除当前目录下所有.tmp文件

    find . -type f -name "*.tmp" -delete

### 根据文件权限/所有权进行匹配
    当前目录下搜索出权限为777的文件
    find . -type f -perm 777

    找出当前目录下权限不是644的php文件
    find . -type f -name "*.php" ! -perm 644

    找出当前目录用户tom拥有的所有文件
    find . -type f -user tom

    找出当前目录用户组sunk拥有的所有文件
    find . -type f -group sunk

### 借助-exec选项与其他命令结合使用

    找出当前目录下所有root的文件，并把所有权更改为用户tom
    find .-type f -user root -exec chown tom {} \;

    上例中，{} 用于与-exec选项结合使用来匹配所有文件，然后会被替换为相应的文件名。

    找出自己目录下所有的.yml文件并删除
    find $HOME/. -name "*.yml" -ok rm {} \;

    上例中，-ok和-exec行为一样，不过它会给出提示，是否执行相应的操作。

    查找当前目录下所有.yml文件并把他们拼接起来写入到all.yml文件中
    find . -type f -name "*.yml" -exec cat {} \;> all.yml

    将30天前的.log文件移动到old目录中
    find . -type f -mtime +30 -name "*.log" -exec cp {} old \;

    找出当前目录下所有.yml文件并以“File:文件名”的形式打印出来
    find . -type f -name "*.yml" -exec printf "File: %s\n" {} \;

    因为单行命令中-exec参数中无法使用多个命令，以下方法可以实现在-exec之后接受多条命令
    -exec ./text.sh {} \;


## 设置定时执行
  crontab -e

设置为凌晨 1 点执行：

0 1 * * * /home/root/mysqlbackup.sh


每分钟执行一次
    */1 * * * * /usr/local/nginx/html/backup_db.sh


## 设置开机启动脚本执行
  Ubuntu开机之后会执行/etc/rc.local文件中的脚本

  将脚本复制或者软连接到/etc/init.d/目录下
  然后用：update-rc.d xxx defaults NN命令(NN为启动顺序)，
  将脚本添加到初始化执行的队列中去。
  注意如果脚本需要用到网络，则NN需设置一个比较大的数字, 如:101

## 启动脚本及顺序
    rc.0 .. x 系统级调用启动, 按数据大小顺序启动
    rc.local 不登录系统即可调用启动, 最后调用
    .bashrc  当前用户登录启动
    /etc/profile 全部用户登录时启动



## nohup与&的区别

nohup是让命令忽略SIGHUP命令而已，退出终端后可以继续运行；&则让命令在后台运行，至于该命令是否能在退出终端后继续执行则要看进程是否是守护进程，如果不是，则需要nohup来帮忙。

nohup命令及其输出文件nohup命令：如果你正在运行一个进程，而且你觉得在退出帐户时该进程还不会结束，那么可以使用nohup命令。该命令可以在你退出帐户/关闭终端之后继续运行相应的进程。nohup就是不挂起的意思( nohang up)。

该命令的一般形式为：nohup command &使用nohup命令提交作业如果使用nohup命令提交作业，那么在缺省情况下该作业的所有输出都被重定向到一个名为nohup.out的文件中，除非另外指定了输出文件：nohup command > myout.log  2>&1 &在上面的例子中，输出被重定向到 myout.log 文件中。

## 检查系统某项服务是否开启, : ps
>ps -aux |grep mysql

## 检查端口是否被占用, :netstat
>netstat -ap | grep 3000

## 检查端口是否被占用及端口的连接情况, :lsof
>lsof -i TCP:3000

## 关闭某个端口的进程
>sudo kill `sudo lsof -t -i:3000`

## 使用指定端口连接远程 主机
>ssh -p 220 ubuntu@192.168.10.5


## 查看磁盘空间大小命令
Df命令是linux系统以磁盘分区为单位查看文件系统，可以加上参数查看磁盘剩余空间信息，命令格式：

>df -hl #查看磁盘剩余空间
>df -h #查看每个根路径的分区大小
>du -sh [目录名] #返回该目录的大小
>du -sm [文件夹] #返回该文件夹总M数


>du -h --max-depth=1 /user #max-depth参数表示指定深入目录的层数,很重要，不指定的话，会显示所有层次目录

## grep 搜索字符串

>grep -b user app/models/*.rb
在models 目录下搜索包含user 的位置并显示



## nl 给输出的每一行添加行号
>nl app/models/account.rb


## 文件同步

>rsync -avz --progress ubuntu@192.168.100.9:/var/www/web_server .

rsync -avz --progress chenwei@192.168.30.40:/data1/dataset/ .

rsync -avz --progress chenwei@192.168.100.229:/home/ubuntu/projects/  .


sudo apt-get install rsync

## 删除大量小文件

rsync --delete-before -d -a -H -v --progress --stats /tmp /your_need_delete_files

or

rsync --delete-before -d /tmp /your_need_delete_files
 

## 删除大件

rsync  --delete-before -d --progess --stats /tmp /your_need_delete_folder


## 同步文件

rsync -avz top20 ubuntu@192.168.70.122:/data/public/testtop20/




源文件夹  目的文件夹

## 通过ifconfig获取所有的IP地址*
>ifconfig | awk -F':| +' '/ddr:/{print $4}'


## 命令行执行 enter/yes
>echo -e "\n"

>echo yes|install.sh

## 命令行读取输入
```
read -p "Input: " num
echo $num
```

## 命令行输入密码
```
echo '============= redis-server '============='
sudo -S apt-get -y install redis-server << EOF
123
EOF
```

## 复制目录

>sudo scp -r ubuntu@192.168.100.1:/opt/jdk1.8.0_131/ /opt/


## 获取执行文件相对路径

>basepath=$(cd `dirname $0`; pwd)

1.dirname $0，取得当前执行的脚本文件的父目录
2.cd dirname $0，进入这个目录（切换当前工作目录）
3.pwd，显示当前工作目录（cd执行后的）

## 获取软连接相对路径
BASE_DIR=dirname $(readlink $0)



## ./configure: error: SSL modules require the OpenSSL library.
```
#ubuntu下解决办法:

apt-get install openssl libssl-dev


# centos
yum -y install openssl openssl-devel
```


## 查看网络io
> nload  -DH


## 设置 dns 地址

    sudo nano /etc/resolv.conf

-add this

    nameserver 114.114.114.114


## 查看当前文件夹下文件夹大小

    sudo du -h --max-depth=1


## ubuntu Trash ‘s location

    ~/.local/share/Trash/

## 一键杀死多个进程

    run_app='dashboard'
    ps aux |grep $run_app |awk '{print $2}'|xargs kill -s 9


## 批量替换当前目录下文件中账户和密码

      #修改 real_user 为你数据库 用户
    real_user=root
      #修改 real_password 为你数据库 密码
    real_password=root

    grep -Ilr 3306  ./ | xargs -n1 -- sed -i 's/root:@/$real_user:$real_password@/g'

##  按文件大小排序 

    ll -Sh 
 

## 按文件修改时间排序显示

    ll -rt 


    ls -lt  #时间最近的在前面



##  设置ls -l命令中显示的日期格式

修改/etc/profile文件，在文件内容末尾加入

    export TIME_STYLE='+%Y-%m-%d %H:%M:%S'

执行如下命令，使你修改后的/etc/profile文件配置内容生效





## 文件读写个数限制 

>echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p


## 快速修改服务器账户密码

```
user='user'
password="123456"
echo -e "$password\n$password" |sudo passwd  $user  

```



## 禁用及解禁账号


```
sudo usermod -L username 
sudo usermod -U username #解禁 

```


## 将目录下文件生成list

>find "/data/suanfa/result/0/img/" -name "*.jpg" >1.list     



## 文件读写个数限制

>echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p


## 挂载glusterfs 

> sudo mount -t glusterfs -o xlator-option=*dht.use-readdirp=no,use-readdirp=no,xlator-option=*md-cache.force-readdirp=no node1:/data1 /home/data_beifen/



## 解决pip install 时locale.Error: unsupported locale setting


    export LC_ALL=C
    locale

## 配置时区
    
    dpkg-reconfigure tzdata



## 重启 vmware docker

    for i in docker ps -a|grep vmware|awk '{print $1}'; do docker restart $i; done


## 判断目录存在

```
path='/home'
if [ -d ${path} ];then
  echo "exist!"
else
  echo "not exist!"
fi
```

## 判断文件存在

```
file="/tmp/1.txt"
if [ -f ${file} ];then
  echo 'exist!'
else
  echo 'not exist!'
fi

```

    -eq   等于/ -ne    不等于/ -gt    大于/ -lt    小于/ -le    小于等于/ -ge   大于等于/ -z    空串/ =    两个字符相等/ !=    两个字符不等/ -n    非空串
