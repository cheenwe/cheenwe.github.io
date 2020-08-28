#!/bin/bash

sudo -i

sudo apt-get install -y software-properties-common

sudo apt-add-repository ppa:brightbox/ruby-ng
sudo apt-get update
sudo apt-get install -y ruby2.6 ruby2.6-dev

apt-get install  git libsqlite3-dev  libxml2-dev   libmysqlclient-dev mysql-server nodejs

gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/

gem install bundler

bundle config mirror.https://rubygems.org https://gems.ruby-china.com



## install redmine

```
cd /opt

git clone https://github.com/redmine/redmine.git


cd redmine/config


cp database.yml.example database.yml #修改MySQL密码
cp additional_environment.rb.example  additional_environment.rb
cp configuration.yml.example configuration.yml



bundle install --without development test


bundle exec rake generate_secret_token

rails db:create RAILS_ENV="production"
bundle exec rake db:migrate RAILS_ENV="production"


sudo chown -R redmine:redmine files log tmp public/plugin_assets
sudo chmod -R 755 files log tmp public/plugin_assets



## add run shell and service

file=/opt/run_redmine
mv $file $file.bak
cat <<EOF >>$file
#!/bin/bash
cd /opt/redmine/&&ruby bin/rails server -e production -p 80

EOF
cat $file

chmod +x  $file


file=/lib/systemd/system/redmine.service
mv $file $file.bak

cat <<EOF >>$file

[Unit]
Description= redmine server

Wants=network-online.target
After=network-online.target

[Service]
Type=simple
ExecStart=/opt/run_redmine
ExecReload=/bin/kill -HUP
RestartSec=5s
Restart=on-failure

[Install]
WantedBy=multi-user.target


EOF
cat $file


systemctl enable --now redmine.service

systemctl status redmine.service

```






