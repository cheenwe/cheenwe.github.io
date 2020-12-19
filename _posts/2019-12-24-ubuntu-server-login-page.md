---
layout: post
title: Ubuntu 服务器欢迎页修改
tags: ubuntu
category: ubuntu
---

## 文件位置

    /etc/update-motd.d

## 修改或删除指定文件即可

    00-header  10-help-text  50-motd-news 92-unattended-upgrades  98-fsck-at-reboot  98-reboot-required  99-esm

## 查看效果
    
    run-parts /etc/update-motd.d



## 添加其他信息

cat /etc/update-motd.d/10-help-text 

```

BANNER_PATH=/etc/update-motd.d/banner
cat $BANNER_PATH/info
cat $BANNER_PATH/contact

```



cat /etc/update-motd.d/banner/info

```


██      ███    ███       ██   ██        ██████           ██████ 
        ████  ████       ██   ██        ██   ██         ██         
██      ██ ████ ██       ███████        ██████          ██     
██      ██  ██  ██       ██   ██        ██              ██      
██      ██      ██       ██   ██        ██               ██████ 


            High Performance Computing Cluster

```



cat /etc/update-motd.d/banner/contact

```

* Management: Cheenwe cxhyun@126.com

* Support: xxxx cxhyun@126.com

* Usage:
   >>>  使用手册                 http://doc.hpc.io    <<<      

```

