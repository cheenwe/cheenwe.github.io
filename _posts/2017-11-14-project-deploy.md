---
layout: post
title: 项目部署整理
tags:   deploy
category:   deploy
---

最近一段忙于在Centos下离线部署Rails应用程序, 闲下来把后续部署流程整理成脚本方便操作.

0.  更新包以软链接方式链接到指定目录，方便回滚版本
1.  上传文件，单独目录 /file ，方便后续扩容,　部署时链接到部署文件夹
2.  配置文件，全部以 .yum 结尾，放shared 下，更新后链接
3.  自动更新脚本


## first deploy
```
sudo mkdir -p /file/uploads
sudo chmod -R 777  /file


mkdir -p /home/deploy/project/shared/config
mkdir -p /home/deploy/project/shared/log
mkdir -p /home/deploy/project/shared/tmp/pids
mkdir -p /home/deploy/project/shared/tmp/cache

mkdir  /home/deploy/project/update/

cp /home/deploy/project/web_server/config/config.yml.example /home/deploy/project/shared/config/config.yml

cp /home/deploy/project/web_server/config/database.yml.example /home/deploy/project/shared/config/database.yml

cp /home/deploy/project/web_server/config/nginx.yml.example /home/deploy/project/shared/config/nginx.yml

cp /home/deploy/project/web_server/config/puma.yml.example /home/deploy/project/shared/config/puma.yml
```

## 更新
```

##修改版本号码
update_pkg_name=V0.1.111417

#项目名
project_name=bank

##下载文件
wget http://192.168.100.229/xxx/repository/archive.tar.gz?ref=$update_pkg_name -O $update_pkg_name.tar.gz
#解压
tar -zxf  $update_pkg_name.tar.gz  -C  /home/deploy/project/update/

mv /home/deploy/project/update/$project_name-$update_pkg_name-* /home/deploy/project/update/$update_pkg_name

cd /home/deploy/project/web_server/bin
./web stop

ln -s /home/deploy/project/update/$update_pkg_name/ /home/deploy/project/web_server

ln -sf /home/deploy/project/shared/tmp/ /home/deploy/project/web_server/tmp
ln -sf /home/deploy/project/shared/log/ /home/deploy/project/web_server/log

ln -sf /home/deploy/project/shared/config/config.yml /home/deploy/project/web_server/config/config.yml
ln -sf /home/deploy/project/shared/config/database.yml /home/deploy/project/web_server/config/database.yml
ln -sf /home/deploy/project/shared/config/nginx.yml /home/deploy/project/web_server/config/nginx.yml
ln -sf /home/deploy/project/shared/config/puma.yml /home/deploy/project/web_server/config/puma.yml
ln -sf /home/deploy/project/shared/config/redis.yml /home/deploy/project/web_server/config/redis.yml
ln -sf /home/deploy/project/shared/config/secrets.yml /home/deploy/project/web_server/config/secrets.yml
ln -sf /home/deploy/project/shared/config/config.js /home/deploy/project/web_server/public/config.js

ln -s /file/uploads /home/deploy/project/web_server/public/uploads



# service restart
/home/deploy/project/web_server/bin/web start

/home/deploy/project/web_server/bin/web restart


# nginx restart

/usr/local/nginx/sbin/nginx

sudo /usr/local/nginx/sbin/nginx -s reload

```