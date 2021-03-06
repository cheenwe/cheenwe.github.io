---
layout: post
title: Redis 安装及配置 sockets 连接
tags: redis socket config
category: redis
---

# Redis 安装及配置 sockets 连接
Ububtu 14.04操作

## 安装命令

```sh
sudo apt-get install redis-server
```

## 配置使用 sockets


```sh
sudo cp /etc/redis/redis.conf /etc/redis/redis.conf.orig
sed 's/^port .*/port 0/' /etc/redis/redis.conf.orig | sudo tee /etc/redis/redis.conf

echo 'unixsocket /var/run/redis/redis.sock' | sudo tee -a /etc/redis/redis.conf

echo 'unixsocketperm 777' | sudo tee -a /etc/redis/redis.conf

mkdir /var/run/redis
chown redis:redis /var/run/redis
chmod 777 /var/run/redis

if [ -d /etc/tmpfiles.d ]; then
  echo 'd  /var/run/redis  0755  redis  redis  10d  -' | sudo tee -a /etc/tmpfiles.d/redis.conf
fi

sudo service redis-server restart

```

## Rails Connect to redis by unix socket

```ruby
# Rails cache_store

config.cache_store = :redis_store, { path: '/var/run/redis/redis.sock', db: 1}, { expires_in: 90.minutes }

# Rails session_store

config.session_store :redis_store, { servers: { path: '/var/run/redis/redis.sock', db: 1 } }
```


## 连接

```sh
redis-cli -s /var/run/redis/redis.sock

del cache:gitlab:rack::attack:allow2ban:ban:ip #删除 gitlab  Rack_Attack blacklist ip
```

## 设置密码

1. 初始化Redis密码：

编辑redis.conf配置文件，找到requirepass参数，这个就是配置redis访问密码的参数:

    # requirepass foobared  

    去掉注释修改为 requirepass redis123；

   （Ps:需重启Redis才能生效）

2. 不重启Redis设置密码（临时的，当服务器重启了密码必须重设）：

```sh

redis-cli 
config set requirepass Password #密码 Password
# OK

```

## 取消密码

```sh
# 验证密码,
auth Password
# 取消密码
config set requirepass ""
```


## 部署操作步骤

```


1. 输入:  locate redis.conf
显示出具体 redis.conf 位置, 如: /etc/redis/redis.conf
2. 修改配置文件:  vi /etc/redis/redis.conf
3. 输入: /rename-command 
4. 输入 i
5. 将 该行前面的 # 删除
6. 按 esc 键
7. 输入 /requirepass 找到 # requirepass foobared  
8. 输入 i
9. 去掉 # 
9. 将该行修改为 requirepass Rpa2019 
10. 重启 redis 服务,  输入: ps aux |grep redis  
 会显示: redis     1408  ... (1408 为进程号, 以实际为准)
11. 输入: kill -9 1408 

12. 开启服务: /usr/local/bin/redis-server ./redis.conf  &

```


## 关闭写硬盘


```
#save 900 1
#save 300 10
#save 60 10000


save ''         
```
