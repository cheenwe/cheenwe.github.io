# Ubuntu 14.04 (Trusty) or newer

sudo apt-get install -y python-software-properties software-properties-common

sudo apt-add-repository ppa:brightbox/ruby-ng
sudo apt-get update
sudo apt-get install -y ruby2.7 ruby2.7-dev


# Ubuntu 12.04 (Precise) or older


sudo apt-get install -y python-software-properties software-properties-common
sudo apt-add-repository ppa:brightbox/ruby-ng
sudo apt-get update
sudo apt-get install -y ruby2.3 ruby2.3-dev




# ruby-switch
sudo apt-get install ruby-switch

ruby-switch --list

sudo ruby-switch --set ruby2.3
