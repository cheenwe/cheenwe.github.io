sudo apt-get install -y software-properties-common libmysqlclient20 rsync
sudo apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
sudo add-apt-repository 'deb [arch=amd64,arm64,ppc64el] http://mirrors.tuna.tsinghua.edu.cn/mariadb/repo/10.4/ubuntu bionic main'
sudo apt install -y mariadb-server
