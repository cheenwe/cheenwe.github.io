
# root account install
apt  install software-properties-common
# Add Ruby sources
add-apt-repository ppa:brightbox/ruby-ng
add-apt-repository ppa:chris-lea/redis-server
# add-apt-repository ppa:openjdk-r/ppa

apt-get update

apt-get install -y  redis-server \
                    libmysqlclient-dev \
                    nodejs \
                    ruby2.5 \
                    mysql-server \
                    nginx \
                    ruby2.5-dev\
                    libxml2-dev


gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/

chmod -R 777   /var/lib/gems/
chown $USER:$USER  /usr/local/bin/

gem install bundler

bundle config mirror.https://rubygems.org https://gems.ruby-china.com



# other account install
sudo apt-get install software-properties-common

# Add Ruby sources
sudo add-apt-repository ppa:brightbox/ruby-ng
sudo add-apt-repository ppa:chris-lea/redis-server
# sudo add-apt-repository ppa:openjdk-r/ppa

sudo apt-get update

sudo apt-get install -y  redis-server \
                    libmysqlclient-dev \
                    nodejs \
                    ruby2.5 \
                    mysql-server \
                    nginx \
                    ruby2.5-dev\
                    libxml2-dev


sudo gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/

sudo chmod -R 777   /var/lib/gems/
sudo chown $USER:$USER  /usr/local/bin/

gem install bundler

bundle config mirror.https://rubygems.org https://gems.ruby-china.com




## install yarn

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get update && sudo apt-get install yarn




apt install apt-transport-https cmake cmake-data curl git git-core libarchive13 libasn1-8-heimdal libcurl3 libcurl3-gnutls libcurl4-openssl-dev libgssapi3-heimdal libhcrypto4-heimdal libheimbase1-heimdal libheimntlm0-heimdal libhx509-5-heimdal libjsoncpp1 libkrb5-26-heimdal libldap-2.4-2 libllvm6.0 libpcre2-8-0 libpq-dev libpq5 libroken18-heimdal librtmp1   libsasl2-2 libsasl2-modules-db libsensors4 libwind0-heimdal postgresql postgresql-11 postgresql-client postgresql-client-11 postgresql-contrib python3-pycurl python3-software-properties  software-properties-common sysstat ubuntu-server
