## 安装 slurm

安装前必须保证软件源一致，建议使用 清华软件源；
```
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse

```

配置好 hostname ,定义好节点名称, 然后在主节点安装 mysql 及对应的 slurm 管理节点软件, 在各个节点安装 slurm 软件

## 主节点

1. 安装MUNGE
安装MUNGE进行身份验证。确保集群中的所有节点具有相同的munge.key。确保Munge的守护程序munged在Slurm的守护进程之前启动。
sudo apt-get install munge  # 安装munge
sudo /usr/sbin/create-munge-key # 生成munge密钥


scp  /etc/munge/munge.key compute03:/etc/munge/ #同步 key

 #安装软件

sudo apt-get remove slurmctld  slurmdbd slurmd




#
 #卸载
dpkg -l |grep ^rc|awk '{print $2}' |sudo xargs dpkg -P


apt-cache search slurm*

mysql

sudo apt-get install slurmdbd slurmctld slurmd


管理节点:  slurmdbd slurmctld slurmd

节点:  slurmd

sudo systemctl restart slurmdbd.service

systemctl status slurmdbd.service

sudo tailf /var/log/slurm/slurmdbd.log

mkdir /var/run/mysqld -p

mkdir -p /var/log/slurm/

chown -R slurm:slurm /var/log/slurm/


## 节点

sudo apt-get install slurmd
mkdir -p /var/spool/slurm-llnl/ctld
mkdir -p /var/spool/slurm-llnl/d
mkdir -p /var/spool/slurmd
chown -R slurm:slurm /var/spool/slurm-llnl/
chown -R slurm:slurm  /var/spool/slurmd

systemctl start slurmd
systemctl status slurmd


## install mysql
use mysql;
create user 'slurm'@'%' identified by 'slurm';

GRANT ALL PRIVILEGES ON *.* TO 'slurm'@'%' IDENTIFIED BY 'slurm' WITH GRANT OPTION;

# sudo service  mysql restart
# grant all privileges  on *.* to slurm@localhost identified by "slurm";
flush privileges;


mysql -uslurm -p -h192.168.30.32 -P3306

mysql -uslurm -p -h192.168.30.32 -P3306


2. 安装SLURM
sudo apt-get install slurm-llnl

3. 配置SLURM
进入etc/slurm-llnl/下，创建slurm.conf，可自定义配置

4. 启动MUNGE
systemctl start munge
systemctl restart munge
systemctl status munge
systemctl enable munge

5. 测试slurmd配置
slurmd -C

6. 开启slurmctld服务
systemctl restart slurmctld
systemctl start slurmctld
systemctl status slurmctld
systemctl enable slurmctld

7.测试命令

scontrol show nodes
sinfo
## 命令

# scontrol show config
# scontrol show partition
# scontrol show node
# scontrol show jobs

#设置某台节点停掉
# scontrol update nodename=compute01 state=down

# 提交作业
srun hostname

srun -N 3 -l hostname

srun sleep 60 &

#查询作业
squeue -a

# 取消作业
scancel <job_id>

Slurm 使用调度系统运行 Docker 镜像
srun —gres=gpu:2 -N1 /mnt/lustre/share/docker_images/srun_docker snesenet-caffe:latest -v /mnt/lustre/val:/mnt/val/ -v /,nt/lustre/train/:/mnt/train/ bash &

srun —gres=gpu:7 -Ncompute03 192.168.30.31:80/train-face/caffempi-ocr-combine:latest   bash &



### munge

```
munge -n
munge -n |unmunge
munge -n |ssh 3.buhpc.com unmunge
munge -n |ssh compute02 unmunge
munge -n |ssh headnode unmunge
remunge
```




sacctmgr modify account set Description=aiaaaa where Names=ai




sacctmgr modify account set Description=aiaaaa where Names=ai

sacctmgr modify user set Partitions=v100 where Names=yaoguang



Partitions=

modify account     - (set options) DefaultQOS=, Description=,       
                            Fairshare=, GrpTRESMins=, GrpTRESRunMins=,       
                            GrpTRES=, GrpJobs=, GrpMemory=, GrpNodes=,     
                            GrpSubmitJob=, GrpWall=, MaxTRESMins=, MaxTRES=,
                            MaxJobs=, MaxNodes=, MaxSubmitJobs=, MaxWall=, 
                            Names=, Organization=, Parent=, and QosLevel=  
                            RawUsage= (with admin privileges only)         
                            (where options) Clusters=, DefaultQOS=,        
                            Descriptions=, Names=, Organizations=,         
                            Parent=,Priority= and QosLevel=               




 modify user        - (set options) AdminLevel=, DefaultAccount=,    
                            DefaultQOS=, DefaultWCKey=, Fairshare=,        
                            MaxTRESMins=, MaxTRES=, MaxJobs=, MaxNodes=,   
                            MaxSubmitJobs=, MaxWall=, NewName=,            
                            and QosLevel=,                                 
                            RawUsage= (with admin privileges only)         
                            (where options) Accounts=, AdminLevel=,        
                            Clusters=, DefaultAccount=, Names=,            
                            Partitions=, Priority= and QosLevel= 





## error 报错

### fatal: Can not recover assoc_usage state, incompatible version, got 8704 need >= 7680 <= 8192, start with '-i' to ignore this


遇到版本不一致， 以前装的版本和现在不一致。以前的版本停止的地方，会在 StateSaveLocation 对应的目录生成历史， 删除该目录中文件即可