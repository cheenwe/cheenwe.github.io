---
layout: post
title: nginx config
tags:   nginx config
category:  nginx
---




#  nginx config

## open gzip
```
# nano /etc/nginx/nginx.conf

gzip_vary on;
gzip_proxied any;
gzip_comp_level 6;
gzip_buffers 16 8k;
gzip_http_version 1.1;
gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript  image/jpeg image/gif image/png
application/octet-stream text/html;
```


## single config

```

server {
  server_name xxx.cn;
  listen 80;
  root /var/www/project/public;

  location ^~ /assets/ {
    gzip on;
    expires max;
    add_header Cache-Control public;
  }

  try_files $uri/index.html $uri @unicorn;
  location @unicorn {
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_redirect off;
    proxy_pass http://localhost:3001;
}

  error_page 500 502 503 504 /500.html;
  client_max_body_size 4G;
  keepalive_timeout 10;
}

```




```
server {
    listen 443;
    server_name baidu.com;

    root  /root/project/istar/public;

    ###ssl start
    ssl on;
    ssl_certificate  /root/project/cert/1540158928481.pem;
    ssl_certificate_key  /root/project/cert/1540158928481.key;
    ssl_session_timeout 5m;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_prefer_server_ciphers on;

    ###ssl end

   location ^~ /assets/ {
    gzip on;
    expires max;
    add_header Cache-Control public;
   }

    location / {
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header Host $http_host;
      proxy_redirect off;
      proxy_pass http://unicorn;

      proxy_http_version 1.1;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection "upgrade";
    }
 
}
```

## http to https

```

server {
  listen      http://xxxx.cn;
  server_name server_name;
  rewrite     ^   https://$server_name$request_uri? permanent;
}

```
