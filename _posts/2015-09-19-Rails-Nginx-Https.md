---
layout: post
title: 提供https的服务
tags:  rails  https
categories: https
---

# 什么是https
https(443)是针对http(80)的加密协议，它可以保证用户访问网站的过程中，通讯的数据是加密的，这样可以防止第三方监听，保护用户隐私。

##  免费ssl证书认证
[https://www.startcomca.com](https://www.startcomca.com/)

```
sudo mkdir /etc/nginx/ssl
cd /etc/nginx/ssl

#生成private key
sudo openssl genrsa -des3 -out server.key 2048
这里问你输入一个passphrase,选择一个容易记得，下一步会需要输入。

#生成 CSR
sudo openssl req -new -key server.key -out server.csr

Country Name (2 letter code) [AU]:US  #国家代码
State or Province Name (full name) [Some-State]:New York #省份
Locality Name (eg, city) []:NYC  #城市
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Awesome Inc #公司名称
Organizational Unit Name (eg, section) []:   #部门名称
Common Name (e.g. server FQDN or YOUR name) []: www.example.com
Email Address []: admin@example.com  #管理员邮箱
```
生成之后，在CSR那个框框里面填入 server.csr 文件的内容。

收到证书后，再/etc/nginx/ssl文件夹下面新建一个server.crt的文件，把证书内容粘贴进去。证书这部分就搞定了。

## 自己颁发证书
浏览器会提示 不安全

```
sudo apt-get install  openssl

openssl req -new -nodes -keyout server.key -out server.csr #生成 CSR和私有 KEY
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt

```
生成的几个文件解释：

server.key 服务器的私钥。
server.csr (certificate signing request) https证书签名请求。
server.crt 生成的服务器证书。
然后有这些文件，我们可以配置nginx服务了。


## Ubuntu服务器

### 生成nginx的配置文件：

```
sudo touch /etc/nginx/sites-available/my_web
sudo ln -s /etc/nginx/sites-available/my_web /etc/nginx/sites-enabled
sudo vi /etc/nginx/sites-available/my_web

```


里面的内容：

```
upstream unicorn {
  server unix:///opt/crm/tmp/puma.sock;
}


server {
    listen  443  ssl http2;

    server_name crm.xxxxxx.cn;
    root /opt/crm/public;

    ssl_certificate      /etc/nginx/ssl/server.crt;
    ssl_certificate_key  /etc/nginx/ssl/server.key;

    ssl_ciphers 'ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA:ECDHE-RSA-AES128-SHA:AES256-GCM-SHA384:AES128-GCM-SHA256:AES256-SHA256:AES128-SHA256:AES256-SHA:AES128-SHA:!aNULL:!eNULL:!EXPORT:!DES:!MD5:!PSK:!RC4';
    ssl_protocols  TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;
    ssl_session_cache  builtin:1000  shared:SSL:10m;
    ssl_session_timeout  5m;


    location ^~ /uploads/ {
      root /opt/crm/public/;
    }


    location ^~ /assets/ {
      gzip on;
      expires max;
      add_header Cache-Control public;
    }

    location / {
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header Host $http_host;
      proxy_set_header   X-Real-IP        $remote_addr;
      proxy_set_header   X-Forwarded-Host $host;
      proxy_set_header   X-Forwarded-Server $host;
      proxy_set_header X-NginX-Proxy true;

      proxy_redirect off;
      proxy_pass http://unicorn;

    }

    location /cable {
      proxy_buffering    on; 
      proxy_pass http://unicorn;
      proxy_http_version 1.1;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header   X-Forwarded-Proto https;
      proxy_set_header Connection "upgrade";
    }

    error_page 500 502 503 504 /500.html;
    client_max_body_size 4G;
    keepalive_timeout 10;
}

## http 跳转 https

server {
  listen  80;
  server_name _;

rewrite  ^   https://crm.xxxxxx.cn$request_uri? permanent;
}


```
需要修改里面的server_name

### 然后重新启动nginx:

sudo service nginx restart
如果没有报错，那么你就可以通过https://yourserver.com来访问你的网站了。

不过，浏览器会阻止你继续访问，或者需要你的确认。 浏览器会保存一份可信网站的列表，你的服务器加密是自己生成的，不在里面。



## Centos服务器

### 生成nginx的配置文件：

```
sudo nano /etc/nginx/conf.d/my_web_ssl.conf
```

里面的内容：


```
upstream unicorn {
  server unix:///opt/crm/tmp/puma.sock;
}


server {
    listen  443  ssl http2;

    server_name crm.xxxxxx.cn;
    root /opt/crm/public;

    ssl_certificate      /etc/nginx/ssl/4156042_crm.xxxxxx.cn.pem;
    ssl_certificate_key  /etc/nginx/ssl/4156042_crm.xxxxxx.cn.key;

    ssl_ciphers 'ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA:ECDHE-RSA-AES128-SHA:AES256-GCM-SHA384:AES128-GCM-SHA256:AES256-SHA256:AES128-SHA256:AES256-SHA:AES128-SHA:!aNULL:!eNULL:!EXPORT:!DES:!MD5:!PSK:!RC4';
    ssl_protocols  TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;
    ssl_session_cache  builtin:1000  shared:SSL:10m;
    ssl_session_timeout  5m;


    location ^~ /uploads/ {
      root /opt/crm/public/;
    }


    location ^~ /assets/ {
      gzip on;
      expires max;
      add_header Cache-Control public;
    }

    location / {
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header Host $http_host;
      proxy_set_header   X-Real-IP        $remote_addr;
      proxy_set_header   X-Forwarded-Host $host;
      proxy_set_header   X-Forwarded-Server $host;
      proxy_set_header X-NginX-Proxy true;

      proxy_redirect off;
      proxy_pass http://unicorn;

    }

    location /cable {
      proxy_buffering    on; 
      proxy_pass http://unicorn;
      proxy_http_version 1.1;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header   X-Forwarded-Proto https;
      proxy_set_header Connection "upgrade";
    }
    
    error_page 500 502 503 504 /500.html;
    client_max_body_size 4G;
    keepalive_timeout 10;
}

## http 跳转 https

server {
  listen  80;
  server_name _;

rewrite  ^   https://crm.xxxxxx.cn$request_uri? permanent;
}


```

需要修改里面的server_name，服务器开在4000端口，使用http://server_name:3000端口转发到服务器4000端口，保证原来服务继续运行，配置如下：

    sudo nano /etc/nginx/conf.d/my_web_http.conf

```
server {
  listen       3000;
  server_name  server_name;
  location / {
      proxy_pass http://localhost:4000;
  }
}
```

### 然后重新启动nginx:

    service nginx restart

## http 跳转 https

    server {
      listen      80;
      server_name server_name;
      rewrite     ^   https://$server_name$request_uri? permanent;
    }


## rails 获取 nginx 代理后的 请求IP

> request.env["HTTP_X_REAL_IP"]

nginx 中需要添加一行 ：

      proxy_set_header X-Real-ip $remote_addr;
