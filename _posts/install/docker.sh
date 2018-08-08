
## New install docker

```shell
sudo apt-get remove docker docker-engine docker.io
sudo rm -rf /var/lib/docker/

sudo apt-get update

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88


sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"


sudo apt-get update

sudo apt-get install docker-ce

# or select version
# apt-cache madison docker-ce
# sudo apt-get install docker-ce=<VERSION>

docker -v
```

# ## New uninstall docker

# ```
# sudo apt-get purge docker-ce
# sudo rm -rf /var/lib/docker
# ```
