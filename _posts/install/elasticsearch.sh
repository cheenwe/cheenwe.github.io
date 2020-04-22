# install elasticsearch


# Add Elasticsearch sources
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list


sudo apt-get update

sudo apt-get install elasticsearch

sudo service elasticsearch start










wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.6.2-amd64.deb

sudo dpkg -i elasticsearch-7.6.2-amd64.deb
