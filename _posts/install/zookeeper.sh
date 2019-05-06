#  install zookeeper

wget http://mirrors.hust.edu.cn/apache/zookeeper/zookeeper-3.4.13/zookeeper-3.4.13.tar.gz


sudo tar -xzvf zookeeper-3.4.13.tar.gz -C /usr/local

cd /usr/local/zookeeper-3.4.13/conf

sudo cp zoo_sample.cfg zoo.cfg


cd /usr/local/zookeeper-3.4.13/bin

sudo bash  zkServer.sh start


ps -ef|grep zookeeper
