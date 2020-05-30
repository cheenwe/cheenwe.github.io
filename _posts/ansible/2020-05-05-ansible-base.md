---
layout: post
title: Ansible 基础
tags: ansible
category: ansible
---


## Ansible 基础

### 1. 安装 Ansible

## install 

```

sudo -i

apt install python python-pip 


### 1.upgrade pip

pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pip -U

pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

pip install ansible

``` 

###  2.change root password

```
username=root
password=root
echo -e "$password\n$password" |passwd $username
 
```

### 3.allow root login

```
ssh_file="/etc/ssh/sshd_config"

echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

service ssh restart


```

### 4.change ansible host 


```
cat <<EOF >>/etc/ansible/hosts
192.168.30.29
192.168.30.51
EOF

```

### 5.generate ssh key

```
ssh-keygen 


 #其他主机需要先执行步骤 2 / 3 

ssh-copy-id 127.0.0.1
ssh-copy-id 192.168.30.51

```

### 6.test ping

```
ansible all -m ping


# with other account, need add key first

ansible all -m ping -u chenwei

```
### 7. run a command

```
ansible all -a 'df -h'

```


## 文件传输



###  文件复制

```
ansible all -m copy -a "src=/etc/ansible/hosts dest=/tmp/hosts  mode=600" #

ansible all -m file -a "dest=/tmp/hosts mode=600 owner=chenwei group=chenwei" #修改其权限

```

### 创建目录

与执行 mkdir -p 

```
ansible all -m file -a "dest=/tmp/chenwei mode=755 owner=chenwei group=chenwei state=directory"

```

### 删除目录

(递归的删除)和删除文件

```
ansible all -m file -a "dest=/tmp/chenwei  state=absent
```



## 用户


```
ansible all -m user -a "name=demo password=123" # 添加

ansible all -m user -a "name=demo state=absent" # 删除
```

## 部署代码

```
ansible webservers -m git -a "repo=git://foo.example.org/repo.git dest=/srv/myapp version=HEAD"
```


## ansible-galaxy

https://github.com/manala


```
ansible-galaxy install manala.zsh 

```
