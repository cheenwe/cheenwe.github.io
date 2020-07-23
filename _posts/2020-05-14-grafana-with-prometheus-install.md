---
layout: post
title: 使用 Grafana 监控服务器性能
tags: prometheus
category: monitor
---

在 ubuntu系统中使用 Prometheus 采集数据并通过 Grafana 实时展示结果, 


Prometheus 用于归集 node_exporter 采集的数据, 开放 9090 端口, 多台机器只需要部署一个即可

node_exporter 用于采集数据, 开放 9100端口, 每台需要监控的机器均需要部署

- 使用 apt 安装, 默认会装 prometheus 和 node_exporter

```
sudo apt install prometheus
```

通过 apt 安装的版本旧, 很多监控项均无法开启, 建议使用最新官网包安装, 步骤如下:





 
- 所需包下载: 
 
https://github.com/prometheus/node_exporter/tags

https://github.com/prometheus/prometheus/tags




wget https://github.com/prometheus/prometheus/releases/download/v2.19.2/prometheus-2.19.2.linux-amd64.tar.gz 

wget https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz



## 安装 Prometheus 及 node_exporter


- 安装最新版 prometheus 及 node_exporter

```
sudo -i

tar -zxf node_exporter-1.0.1.linux-amd64.tar.gz

tar -zxf prometheus-2.19.2.linux-amd64.tar.gz

mv prometheus-2.19.2.linux-amd64 /opt/prometheus

mv node_exporter-1.0.1.linux-amd64/node_exporter /opt/prometheus/

```


- 添加系统服务


```
cat <<EOF >>/lib/systemd/system/prometheus-node-exporter.service

[Unit]
Description=Prometheus exporter for machine metrics
Documentation=https://github.com/prometheus/node_exporter

[Service]
Type=simple
ExecStart=/opt/prometheus/node_exporter
ExecReload=/bin/kill -HUP $MAINPID    
RestartSec=5s                         
Restart=on-failure                    

[Install]
WantedBy=multi-user.target  

EOF

 
```

```

cat <<EOF >>/lib/systemd/system/prometheus.service

[Unit]
Description=Monitoring system and time series database
Documentation=https://prometheus.io/docs/introduction/overview/    

[Service]
Type=simple
ExecStart=/opt/prometheus/prometheus --config.file=/opt/prometheus/prometheus.yml --web.listen-address=:9090
ExecReload=/bin/kill -HUP $MAINPID    
RestartSec=5s                         
Restart=on-failure                    

[Install]
WantedBy=multi-user.target  

EOF

``` 

- 重新加载系统服务


```
systemctl daemon-reload #重新加载
systemctl enable --now prometheus.service  # 立刻开启并开机启动
systemctl enable --now prometheus-node-exporter.service  # 立刻开启并开机启动

```

- 验证安装完成.

访问该服务器 ip:9090 及 ip:9100


### 配置 prometheus

收集多台服务器数据, 参考以下调整即可.

```
  - job_name: node
    # If prometheus-node-exporter is installed, grab stats about the local
    # machine by default.
    static_configs:
      - targets: ['192.168.30.2:9100', '192.168.30.3:9100', '192.168.1.51:9100']     
```


## 安装 Grafana


```
sudo apt-get install -y adduser libfontconfig1
wget https://dl.grafana.com/oss/release/grafana_6.7.3_amd64.deb
sudo dpkg -i grafana_6.7.3_amd64.deb
```

- 初始账户名

    用户: admin 
    密码: admin

### 配置 Grafana 

1. 点击 confuguration -> Data Sources -> Add data source -> 选择 Pormetheus -> 输入 http://192.168.30.2:9090 -> Save &Test 即可
2. 点击 Create -> Import -> 输入 dashboard id 即可.

推荐 ID: 1860 / 8919

更多 ID:  https://grafana.com/grafana/dashboards?direction=desc&orderBy=reviewsCount
