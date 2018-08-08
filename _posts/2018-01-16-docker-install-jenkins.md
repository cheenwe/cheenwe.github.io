---
layout: post
title: Docker 安装 Jenkins
tags:    docker jenkins devops
category:   docker
---


## 安装

```shell
sudo apt install docker.io
sudo service docker start
sudo docker login
#Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
#Username: cheenwe
#Password:
#Login Succeeded

sudo docker pull jenkins/jenkins:lts
```

## 用法

```shell
sudo docker run -p 8001:8001  -v jenkins_home:/tmp/jenkins jenkins/jenkins:lts

```




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

## New uninstall docker

```
sudo apt-get purge docker-ce
sudo rm -rf /var/lib/docker
```

# ubuntu install jenkins

This is the Debian package repository of Jenkins to automate installation and upgrade. To use this repository, first add the key to your system:

>wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -

Then add the following entry in your /etc/apt/sources.list:
>deb https://pkg.jenkins.io/debian-stable binary/

Update your local package index, then finally install Jenkins:

>sudo apt-get update
>sudo apt-get install jenkins

## 修改Ubuntu下的jenkins端口号

>nano /etc/init.d/jenkins
>nano /etc/default/jenkins

将端口8080改成8000
