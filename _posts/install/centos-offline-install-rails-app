# CentOS　部署应用程序

 默认所有安装包都下载

rsync  -aSz  . em@192.168.100.168:~/

```
## install
cd
tar -xf mysql-5.7.20-1.el7.x86_64.rpm-bundle.tar
rpm -qa | grep mariadb
  # if exists remove it
sudo rpm -e --nodeps mariadb-libs-5.5.44-2.el7.x86_64
sudo rpm -ivh mysql-community-common-5.7.20-1.el7.x86_64.rpm
sudo rpm -ivh mysql-community-libs-5.7.20-1.el7.x86_64.rpm
sudo rpm -ivh mysql-community-client-5.7.20-1.el7.x86_64.rpm
sudo rpm -ivh mysql-community-server-5.7.20-1.el7.x86_64.rpm
sudo rpm -ivh mysql-community-libs-compat-5.7.20-1.el7.x86_64.rpm
sudo rpm -ivh mysql-community-devel-5.7.20-1.el7.x86_64.rpm

sudo rpm -ivh mysql-community-embedded-5.7.20-1.el7.x86_64.rpm
sudo rpm -ivh mysql-community-embedded-compat-5.7.20-1.el7.x86_64.rpm
sudo rpm -ivh mysql-community-embedded-devel-5.7.20-1.el7.x86_64.rpm

sudo service mysqld start

## find default password
grep "password" /var/log/mysqld.log

## update mysql password


mysql -uroot -p

set global validate_password_policy=0;
set global validate_password_length=1;
SET PASSWORD = PASSWORD('root');
```

```
# install zlib
tar -zxf zlib-1.2.11.tar.gz
cd zlib-1.2.11
./configure
make && sudo make install

cd ..
sudo rm -R $PACKAGE_NAME

# install libxml2
PACKAGE_NAME="openssl-1.1.0g"
tar -zxf $PACKAGE_NAME.tar.gz
cd $PACKAGE_NAME
./config -fPIC --prefix=/usr/local/openssl enable-shared
make && sudo make install
openssl version
cd ..
sudo rm -R $PACKAGE_NAME

sudo rpm -ivh openssl/openssl-1.0.2k-8.el7.x86_64.rpm openssl/openssl-libs-1.0.2k-8.el7.x86_64.rpm

# install libxml2
PACKAGE_NAME="libxml2-2.7.2"
tar -zxf $PACKAGE_NAME.tar.gz
cd $PACKAGE_NAME
./configure
make && sudo make install
cd ..
sudo rm -R $PACKAGE_NAME

# install pcre
PACKAGE_NAME="pcre-8.38"
tar -zxf $PACKAGE_NAME.tar.gz
cd $PACKAGE_NAME
./configure
make && sudo make install
cd ..
sudo rm -R $PACKAGE_NAME

# install redis
PACKAGE_NAME="redis-3.2.9"
tar -zxf $PACKAGE_NAME.tar.gz
cd $PACKAGE_NAME
./configure
make && sudo make install
cd ..
sudo rm -R $PACKAGE_NAME

# install nginx
PACKAGE_NAME="nginx-1.12.2"
tar -zxf $PACKAGE_NAME.tar.gz
cd $PACKAGE_NAME
./configure
make && sudo make install
cd ..
sudo rm -R $PACKAGE_NAME

# install ruby
PACKAGE_NAME="ruby-2.4.2"
tar -zxf $PACKAGE_NAME.tar.gz
cd $PACKAGE_NAME
./configure --disable-install-rdoc
make
sudo make prefix=/usr/local install

# make uninstall #remove
#USER=(echo `whoami`)
sudo chown em /usr/local/bin
#注意修改用户名em
sudo chown -R em /usr/local/lib/ruby/gems/
#注意修改用户名rm
sudo chmod -R 777 /usr/local/lib/ruby/gems/2.4.0


# install bundler
cd ..
#wget https://gems.ruby-china.org/downloads/bundler-1.16.0.gem
gem install --local bundler-1.16.0.gem

＃deploy project
tar -zxf web_server.tar.gz
#自己补全文件名
sudo mkdir -p /home/deploy/project/
sudo chmod -R 777  /home/deploy/project/
sudo mv web_server-   /home/deploy/project/web_server
#自己补全文件夹名
cd /home/deploy/project/web_server

gem install --local vendor/cache/bundler-1.16.0.gem --no-ri

cd /home/deploy/project/web_server

nohup bash bin/gs  &
# 打开新终端

cd /home/deploy/project/web_server

bundle install

rails db:create db:migrate db:seed

# activemq
tar -zxf apache-activemq-5.15.0-bin.tar.gz
mv  apache-activemq-5.15.0 /home/deploy/apache-activemq/
 ＃bin/activemq start
nohup bash bash /home/deploy/apache-activemq/bin/activemq start  &
```


＃　bundle 报错
cd
sudo chmod -R 777 ruby-2.4.2/ext/openssl/

cd ruby-2.4.2/ext/openssl/

ruby extconf.rb --with-openssl-include=/usr/local/openssl/include/ --with-openssl-lib=/usr/local/openssl/lib

## 注意用户名
sudo ln -s /home/em/ruby-2.4.2/include/ /

make  &

sudo make install

## 继续执行　


cd /home/deploy/project/web_server

bundle install

cp /home/deploy/project/web_server/config/database.yml.example /home/deploy/project/web_server/config/database.yml

rails db:create db:migrate db:seed



## 重启脚本
