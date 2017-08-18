sudo update-locale LC_ALL="en_US.utf8"

# Add PG sources
echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" | sudo tee -a /etc/apt/sources.list.d/pgdb.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Add Ruby sources
sudo add-apt-repository ppa:chris-lea/redis-server

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y apt-transport-https \
                        git \
                        redis-server \
                        imagemagick \
                        nodejs \
                        libpq-dev \
                        zlib1g-dev \
                        postgresql-9.5 \
                        ruby2.3 \
                        ruby2.3-dev\
                        g++  make  libreadline-dev build-essential patch


sudo service postgresql restart

# sudo su postgres -c "CREATE USER "root" WITH CREATEDB PASSWORD '123123123';"
sudo su postgres -c "createuser -d -R -S $USER"


gem sources --add https://ruby.taobao.org/ --remove https://rubygems.org/

sudo gem install bundler
bundle config mirror.https://rubygems.org https://ruby.taobao.org


echo "update  redis Configure"
echo "---------------------------------------------------------------------------"
sudo cp /etc/redis/redis.conf /etc/redis/redis.conf.orig
sudo sed 's/^port .*/port 0/' /etc/redis/redis.conf.orig | sudo tee /etc/redis/redis.conf
sudo echo 'unixsocket /var/run/redis/redis.sock' | sudo tee -a /etc/redis/redis.conf
sudo echo 'unixsocketperm 777' | sudo tee -a /etc/redis/redis.conf
sudo mkdir /var/run/redis
sudo chown redis:redis /var/run/redis
sudo chmod -R 777 /var/run/redis
if [ -d /etc/tmpfiles.d ]; then
  echo 'd  /var/run/redis  0777  redis  redis  10d  -' | sudo tee -a /etc/tmpfiles.d/redis.conf
fi
sudo service redis-server restart


echo "---------------------------------------------------------------------------"
echo "Install redis success"

echo "--------------------------------config-------------------------------------------"

echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

echo "--------------------------------config-------------------------------------------"