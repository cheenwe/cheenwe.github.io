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
