sudo apt-get install -y software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible


git clone git://github.com/ansible/ansible.git --recursive

cd ./ansible
source ./hacking/env-setup
sudo pip install paramiko PyYAML Jinja2 httplib2 six




## 更新

git pull --rebase

git submodule update --init --recursive








## centos

yum -y install epel-release
yum -y install python-pip

pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pip -U

pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
pip install ansible
