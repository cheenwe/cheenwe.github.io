---
layout: post
title: Elasticsearch入门
tags: elasticsearch
category: elasticsearch
---


## Elasticsearch入门

### 1. 安装 Elasticsearch

```

# Add Elasticsearch sources
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list


sudo apt-get update

sudo apt-get install elasticsearch

sudo service elasticsearch start
```

### Elasticsearch 安装 Head 插件

- 安装nodejs

```
# install node v8.x
curl --location https://deb.nodesource.com/setup_8.x | bash -
sudo apt-get install -y nodejs

```

- Head

```
git clone https://github.com/mobz/elasticsearch-head

# 安装插件；由于需要下载一些数据，所以可能会比较慢。
npm install
# 启动插件；如果需要后台启动，可以使用 nohup，具体用法请自行百度
npm run start
```

访问: localhost:9001 即可.


- 跨域问题解决

```
#nano nano /etc/elasticsearch/elasticsearch.yml

http.cors.enabled: true
http.cors.allow-origin: "*"
```
