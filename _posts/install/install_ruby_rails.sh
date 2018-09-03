
sudo add-apt-repository ppa:brightbox/ruby-ng
sudo apt-get update
sudo apt-get install -y  zlib1g-dev libxml2-dev ruby2.4  ruby2.4-dev

sudo gem install rails

gem sources --add https://ruby.taobao.com/ --remove https://rubygems.org/

sudo gem install bundler

bundle config mirror.https://rubygems.org https://ruby.taobao.com
