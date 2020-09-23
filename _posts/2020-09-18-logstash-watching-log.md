---
layout: post
title: 使用 logstash 实时监控日志文件
tags: logstash log
category: logstash
---

前面使用 inotify 实时监控 ftp 目录文件新增的情况，然后推送到 MQ 和接口里面，实际使用的过程中经常出现未知原因不推送，也无法排查原因，很影响业务运行，索性就直接解析 ftp 日志,然后发送到接口中，这也能保证实时性。以下为 ubuntu 下 logstash 安装及配置步骤。


Logstash 是免费且开放的服务器端数据处理管道，能够从多个来源采集数据，转换数据，然后将数据发送到您最喜欢的“存储库”中。


##  安装

- 安装 java 环境

下载离线包并解压到 /opt 下

链接:https://pan.baidu.com/s/1q5Kci47f4sUQdhDpd0KUIQ  密码:3h7o


```

echo 'export JAVA_HOME=/opt/jdk1.8.0_231' >> /etc/profile
echo 'export JRE_HOME=${JAVA_HOME}/jre' >> /etc/profile
echo 'export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib' >> /etc/profile
echo 'export PATH=${JAVA_HOME}/bin:$PATH' >> /etc/profile

```

- 安装 logstash

```bash

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

sudo apt-get install apt-transport-https


echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list

sudo apt-get update && sudo apt-get install logstash

```

##  配置

监控 ftp 日志，并把上传的日志推送到 接口中。

```bash

input{
    file{
        path => ["/var/log/vsftpd.log"]
        type => 'ftp_log'
        #start_position => "beginning"
    }
}
#只推送包含 UPLOAD 的日志记录
filter{
    if "UPLOAD" in [message]{

    }else{
        drop {}
    }
}

output{
    http {
        http_method => "post"
        url => "http://192.168.90.229:90/notify/all"
        format => "json_batch"
        mapping => {
            "ip" => "192.168.90.10"
            "url" => "http://192.168.90.10:8510"
            "message" => "%{message}"
        }
    }
}


```

##  运行

```bash
/usr/share/logstash/bin/logstash -t -f ftp.cnf  # 测试配置文件

/usr/share/logstash/bin/logstash  -f ftp.cnf  # 运行
```

##  写成服务

```bash

# 写配置
file=/opt/watch_ftplog.cnf
mv $file $file.bak
cat <<EOF >>$file
input{
    file{
        path => ["/var/log/vsftpd.log"]
        type => 'ftp_log'
        #start_position => "beginning"
    }
}
filter{
    if "UPLOAD" in [message]{
    }else{
        drop {}
    }
}

output{
    http {
        http_method => "post"
        url => "http://192.168.90.229:90/notify/all"
        format => "json_batch"
        mapping => {
            "ip" => "192.168.90.10"
            "url" => "http://192.168.90.10:8510"
            "message" => "%{message}"
        }
    }
}

EOF
cat $file


# 启动脚本
file=/opt/watch_ftplog
mv $file $file.bak
cat <<EOF >>$file
#!/bin/bash

export JAVA_HOME=/opt/jdk1.8.0_231
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH

/usr/share/logstash/bin/logstash  -f /opt/watch_ftplog.cnf

EOF
cat $file

chmod +x  $file

# 写 service
file=/lib/systemd/system/watch_ftplog.service
mv $file $file.bak

cat <<EOF >>$file
[Unit]
Description=realtime watch ftp log shell by chenwei.

Wants=network-online.target
After=network-online.target

[Service]
Type=simple
ExecStart=/opt/watch_ftplog
ExecReload=/bin/kill -HUP
RestartSec=30s
Restart=on-failure

[Install]
WantedBy=multi-user.target

EOF
cat $file

systemctl enable --now watch_ftplog.service
systemctl status watch_ftplog.service
```
