# install golang

PACKAGE_NAME="1.15.5"

wget https://studygolang.com/dl/golang/go$PACKAGE_NAME.linux-amd64.tar.gz

#wget https://dl.gocn.io/golang/$PACKAGE_NAME/go$PACKAGE_NAME.linux-amd64.tar.gz
# wget https://dl.google.com/go/go$PACKAGE_NAME.linux-amd64.tar.gz

# Remove former Go installation folder
sudo rm -rf /usr/local/go

sudo tar -C /usr/local -zxvf go$PACKAGE_NAME.linux-amd64.tar.gz

mkdir -p ~/go/src
echo "export GOPATH=$HOME/go" >> ~/.bashrc
echo "export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin" >> ~/.bashrc

echo "export GO111MODULE=on" >> ~/.bashrc
echo "export GOPROXY=https://goproxy.cn" >> ~/.bashrc

source ~/.bashrc

go version
# go的系统库存放于/usr/local/go/bin;
# 工程中自动下载的库存放于$HOME/go/bin下


rm go$PACKAGE_NAME.linux-amd64.tar.gz






# https://storage.googleapis.com/golang/go1.11.8.linux-amd64.tar.gz
