# install golang

PACKAGE_NAME="1.10.3"

wget https://studygolang.com/dl/golang/go$PACKAGE_NAME.linux-amd64.tar.gz

#wget https://dl.gocn.io/golang/$PACKAGE_NAME/go$PACKAGE_NAME.linux-amd64.tar.gz
# wget https://dl.google.com/go/go$PACKAGE_NAME.linux-amd64.tar.gz


sudo tar -C /usr/local -zxvf go$PACKAGE_NAME.linux-amd64.tar.gz

mkdir -p ~/go/src
echo "export GOPATH=$HOME/go" >> ~/.bashrc
echo "export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin" >> ~/.bashrc
source ~/.bashrc

go version
# go的系统库存放于/usr/local/go/bin;
# 工程中自动下载的库存放于$HOME/go/bin下








# Remove former Go installation folder
sudo rm -rf /usr/local/go

curl --remote-name --progress https://storage.googleapis.com/golang/go1.10.3.linux-amd64.tar.gz

sudo tar -C /usr/local -xzf go1.10.3.linux-amd64.tar.gz
sudo ln -sf /usr/local/go/bin/{go,godoc,gofmt} /usr/local/bin/
rm go1.10.3.linux-amd64.tar.gz
