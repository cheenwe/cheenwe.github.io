#!/bin/bash
VERSION="stable"

curl -O http://download.redis.io/releases/redis-$VERSION.tar.gz
tar zxf redis-$VERSION.tar.gz
cd redis-$VERSION
make && sudo make install

sudo cp redis-server /etc/init.d/redis-server
sudo chmod +x /etc/init.d/redis-server
sudo cp redis.conf /usr/local/etc/redis.conf

sudo useradd redis
sudo mkdir -p /var/lib/redis
sudo mkdir -p /var/log/redis
sudo chown redis.redis /var/lib/redis
sudo chown redis.redis /var/log/redis

sudo /etc/init.d/redis-server start

cd ..
sudo rm -R redis-$VERSION
rm redis-$VERSION.tar.gz


# or>>>>>>>>



sudo apt-get install redis-server


sudo cp /etc/redis/redis.conf /etc/redis/redis.conf.orig

sed 's/^port .*/port 0/' /etc/redis/redis.conf.orig | sudo tee /etc/redis/redis.conf

echo 'unixsocket /var/run/redis/redis.sock' | sudo tee -a /etc/redis/redis.conf

echo 'unixsocketperm 770' | sudo tee -a /etc/redis/redis.conf

# Create the directory which contains the socket
sudo mkdir /var/run/redis
sudo chown redis:redis /var/run/redis
sudo chmod 755 /var/run/redis

# Persist the directory which contains the socket, if applicable
if [ -d /etc/tmpfiles.d ]; then
  echo 'd  /var/run/redis  0755  redis  redis  10d  -' | sudo tee -a /etc/tmpfiles.d/redis.conf
fi

# Activate the changes to redis.conf
sudo service redis-server restart
