
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
