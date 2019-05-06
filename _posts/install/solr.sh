# install solr

wget http://archive.apache.org/dist/lucene/solr/6.3.0/solr-6.3.0.tgz

cd /usr/local/

sudo  tar zxvf solr-6.3.0.tgz solr-6.3.0/bin/install_solr_service.sh --strip-components=2


sudo bash ./install_solr_service.sh solr-6.3.0.tgz

sudo service solr status
