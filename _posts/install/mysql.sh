# install mysql

PACKAGE_NAME="mysql-5.7.20-1.el7.x86_64.rpm-bundle"

wget https://dev.mysql.com/get/Downloads/MySQL-5.7/$PACKAGE_NAME.tar

tar -ivf $PACKAGE_NAME.tar


rpm -qa | grep mariadb
  # if exists remove it
  #sudo rpm -e --nodeps mariadb-libs-5.5.44-2.el7.x86_64

## install
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

cd ..

sudo rm *.rpm

rm $PACKAGE_NAME.tar

　