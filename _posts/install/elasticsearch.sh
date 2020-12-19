# install elasticsearch


# Add Elasticsearch sources
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list


sudo apt-get update

sudo apt-get install elasticsearch

sudo service elasticsearch start









- hosts: 192.168.30.41
  become: yes
  tasks:
  - name: preinstall jmespath
    command: "apt-get install python-jmespath"



wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.6.2-amd64.deb

sudo dpkg -i /tmp/elasticsearch-7.6.2-amd64.deb





## ansible


apt-get install python-jmespath


ansible-galaxy install elastic.elasticsearch,7.6.2

ansible-playbook 1.yml


ansible-playbook -i hosts ./main.yml



- hosts: es_master
  roles:
    - role: elastic.elasticsearch
  vars:
    es_heap_size: "1g"
    es_config:
      cluster.name: "EScluster"
      cluster.initial_master_nodes: "elastic02"
      discovery.seed_hosts: "elastic02:9300"
      http.port: 9200
      node.data: false
      node.master: true
      bootstrap.memory_lock: false
    # es_plugins:
    #  - plugin: ingest-attachment

- hosts: es_node1
  roles:
    - role: elastic.elasticsearch
  vars:
    es_data_dirs:
      - "/opt/elasticsearch"
    es_config:
      cluster.name: "EScluster"
      cluster.initial_master_nodes: "elastic02"
      discovery.seed_hosts: "elastic02:9300"
      http.port: 9200
      node.data: true
      node.master: false
      bootstrap.memory_lock: false
    # es_plugins:
    #   - plugin: ingest-attachment

- hosts: es_node2
  roles:
    - role: elastic.elasticsearch
  vars:
    es_config:
      cluster.name: "EScluster"
      discovery.seed_hosts: "elastic02:9300"
      http.port: 9200
      node.data: true
      node.master: false
      bootstrap.memory_lock: false
    # es_plugins:
    #   - plugin: ingest-attachment

- hosts: es_node3
  roles:
    - role: elastic.elasticsearch
  vars:
    es_config:
      cluster.name: "EScluster"
      discovery.seed_hosts: "elastic02:9300"
      http.port: 9200
      node.data: true
      node.master: false
      bootstrap.memory_lock: false
    # es_plugins:
    #   - plugin: ingest-attachment









### docker-compose

sysctl -w vm.max_map_count=262144

cd /data/elasticsearch


- 编写docker-compose.yml文件

```
version: '2.2'
services:
  es01:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.10.0
    container_name: es01
    environment:
      - node.name=es01
      - cluster.name=es-docker-cluster
      - discovery.seed_hosts=es02,es03
      - cluster.initial_master_nodes=es01,es02,es03
      - bootstrap.memory_lock=true
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - data01:/usr/share/elasticsearch/data
    ports:
      - 9200:9200
    networks:
      - elastic
  es02:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.10.0
    container_name: es02
    environment:
      - node.name=es02
      - cluster.name=es-docker-cluster
      - discovery.seed_hosts=es01,es03
      - cluster.initial_master_nodes=es01,es02,es03
      - bootstrap.memory_lock=true
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - data02:/usr/share/elasticsearch/data
    networks:
      - elastic
  es03:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.10.0
    container_name: es03
    environment:
      - node.name=es03
      - cluster.name=es-docker-cluster
      - discovery.seed_hosts=es01,es02
      - cluster.initial_master_nodes=es01,es02,es03
      - bootstrap.memory_lock=true
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - data03:/usr/share/elasticsearch/data
    networks:
      - elastic

volumes:
  data01:
    driver: local
  data02:
    driver: local
  data03:
    driver: local

networks:
  elastic:
    driver: bridge
```

- 启动

docker-compose up -d


参考：

https://www.elastic.co/guide/en/elasticsearch/reference/7.10/docker.html#docker
