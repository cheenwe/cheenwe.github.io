---
layout: post
title: 使用 Ansible 部署 Elasticsearch 集群
tags: elasticsearch ansible
category: elasticsearch 
---


## 使用 Ansible 部署 Elasticsearch 集群

### 1. 安装 ansible

```

sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible

```

###  2. 部署

- 基于官方推荐

https://github.com/elastic/ansible-elasticsearch

- 部署 3 个候选主节点也是数据节点


```
file=/etc/hosts
cp $file $file.bak
cat <<EOF >>$file

192.168.30.29 es_node1
192.168.30.51 es_node2
192.168.30.55 es_node3

EOF
cat $file

```

- hosts
master: 30.29, 支持跨域访问, 绑定 ip

```

file=hosts
cat <<EOF >>$file

[es_node1]
192.168.30.29

[es_node2]
192.168.30.55

[es_node3]
192.168.30.51

EOF
cat $file
```

- main.yml

```
- hosts: es_node1
  roles:
    - role: elastic.elasticsearch
  vars:
    es_data_dirs:
      - "/opt/elasticsearch"
    es_config:
      cluster.name: "EScluster"
      node.name: es_node1
      network.host: 192.168.30.55
      http.port: 9200
      discovery.seed_hosts: ["192.168.30.29", "192.168.30.55", "192.168.30.51"]
      cluster.initial_master_nodes: ["es_node3", "es_node1", "es_node2"]
      http.cors.enabled: true
      http.cors.allow-origin: "*"
      node.data: true
      node.master: true
      bootstrap.memory_lock: false 
 
- hosts: es_node2
  roles:
    - role: elastic.elasticsearch
  vars:
    es_data_dirs:
      - "/opt/elasticsearch"
    es_config:
      cluster.name: "EScluster"
      node.name: es_node2
      network.host: 192.168.30.51
      http.port: 9200
      discovery.seed_hosts: ["192.168.30.29", "192.168.30.55", "192.168.30.51"]
      cluster.initial_master_nodes: ["es_node3", "es_node1", "es_node2"]
      http.cors.enabled: true
      http.cors.allow-origin: "*"
      node.data: true
      node.master: true
      bootstrap.memory_lock: false

- hosts: es_node3
  roles:
    - role: elastic.elasticsearch
  vars:
    es_data_dirs:
      - "/opt/elasticsearch"
    es_config:
      cluster.name: "EScluster"
      node.name: es_node3
      network.host: 192.168.30.55
      http.port: 9200
      discovery.seed_hosts: ["192.168.30.29", "192.168.30.55", "192.168.30.51"]
      cluster.initial_master_nodes: ["es_node3", "es_node1", "es_node2"]
      http.cors.enabled: true
      http.cors.allow-origin: "*"
      node.data: true
      node.master: true
      bootstrap.memory_lock: false
```

- 运行


```
ansible-playbook -i hosts ./main.yml

```
