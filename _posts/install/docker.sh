
## New install docker

```shell

sudo apt install -y  curl wget

sudo apt-get remove docker docker-engine docker.io
sudo rm -rf /var/lib/docker/

sudo apt-get update

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo apt install -y software-properties-common
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"


sudo apt-get  -y  update

sudo apt-get install -y  docker-ce

# or select version
# apt-cache madison docker-ce
# sudo apt-get install docker-ce=<VERSION>

docker -v
```




echo "========================================  "
echo "========================================  "
echo "=======  install nvidia docker  ========  "
docker -v
echo "========================================  "
echo "========================================  "

# Add the package repositories
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit nvidia-docker2
sudo systemctl restart docker


sudo mkdir -p /etc/systemd/system/docker.service.d
sudo tee /etc/systemd/system/docker.service.d/override.conf <<EOF
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd --host=fd:// --add-runtime=nvidia=/usr/bin/nvidia-container-runtime
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker

sudo tee /etc/docker/daemon.json <<EOF
{
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
        }
    }
}
EOF
sudo pkill -SIGHUP dockerd



sudo dockerd --add-runtime=nvidia=/usr/bin/nvidia-container-runtime

# docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi



echo "========================================  "
echo "========================================  "
echo "========= docker-compose       =========  "
echo "========================================  "
echo "========================================  "

sudo curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose



