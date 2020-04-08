sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible


git clone git://github.com/ansible/ansible.git --recursive

cd ./ansible
source ./hacking/env-setup
sudo pip install paramiko PyYAML Jinja2 httplib2 six




## 更新

git pull --rebase

git submodule update --init --recursive
