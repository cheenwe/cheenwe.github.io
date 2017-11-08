# install ruby

PACKAGE_NAME="ruby-2.4.2"

wget https://cache.ruby-china.org/pub/ruby/2.4/$PACKAGE_NAME.tar.gz

tar -zxf $PACKAGE_NAME.tar.gz

cd $PACKAGE_NAME

./configure --disable-install-rdoc

make

sudo make prefix=/usr/local install

## make uninstall #remove
USER=(echo `whoami`)
sudo chown $USER /usr/local/bin #注意修改用户名

sudo chown -R $USER /usr/local/lib/ruby/gems/　#注意修改用户名

sudo chmod -R 777 /usr/local/lib/ruby/gems/2.4.0


## 编译　openssl
sudo chmod -R 777 ruby-2.4.2/ext/openssl/

cd ruby-2.4.2/ext/openssl/

ruby extconf.rb --with-openssl-include=/usr/local/openssl/include/ --with-openssl-lib=/usr/local/openssl/lib

## 注意用户名
sudo ln -s /home/em/ruby-2.4.2/include/ /