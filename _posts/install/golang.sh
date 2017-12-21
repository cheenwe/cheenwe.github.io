# install golang

PACKAGE_NAME="1.9.2"

wget https://dl.gocn.io/golang/$PACKAGE_NAME/go$PACKAGE_NAME.linux-amd64.tar.gz

sudo tar -C /usr/local -zxvf go$PACKAGE_NAME.linux-amd64.tar.gz

mkdir -p ~/go/src
echo "export GOPATH=$HOME/go" >> ~/.bashrc
echo "export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin" >> ~/.bashrc
source ~/.bashrc

go version
# go的系统库存放于/usr/local/go/bin;
# 工程中自动下载的库存放于$HOME/go/bin下


