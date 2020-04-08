# 安装 harbor

# 下载 并解压
wget  https://storage.googleapis.com/harbor-releases/harbor-offline-installer-v1.5.2.tgz
tar -zxf harbor-offline-installer-v1.5.2.tgz
# 修改配置文件 harbor.cfg

# 安装 docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo ./install.sh
