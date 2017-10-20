---
layout: post
title: Redis 安装及配置 sockets 连接
tags: redis
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