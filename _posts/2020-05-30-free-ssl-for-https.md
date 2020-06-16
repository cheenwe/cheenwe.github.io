---
layout: post
title: 免费的https证书
tags: https
category: https
---




Let’s Encrypt提供了免费的证书申请服务，同时也提供了官方客户端 Certbot以下为操作步骤教程。官方教程给出了四种常用服务器和不同的Linux、Unix的安装使用方案，可以说是十分的贴心了。


更多参见： https://certbot.eff.org/


```
sudo apt-get install -y software-properties-common
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install -y  certbot
```

- 生成

生成

    sudo certbot certonly --webroot


- 注意

生成时第一步输入你的域名， 第二步需要填写你当前域名 http 的目录， 证书提供商需要校验下这个域名是否真正的被你拥有，
这时候搭建个简单的http服务， 这里我们输入的目录 /tmp

    cd /tmp && sudo python3 -m http.server  --bind 0.0.0.0 80

即可。


最终证书会生成到 /etc/letsencrypt/live/ 你的域名目录下， 对应关系如下。


```
ln -sf /etc/letsencrypt/live/git.10sh.cn/fullchain.pem  /etc/gitlab/ssl/git.10sh.cn.crt
ln -sf /etc/letsencrypt/live/git.10sh.cn/privkey.pem /etc/gitlab/ssl/git.10sh.cn.key

```


- 自动续期

sudo certbot renew --dry-run


注:证书在到期前30天才会续签成功,但为了确保证书在运行过程中不过期,官方建议每天自动执行续签两次;
使用crontab自动续期


```
crontab -e 
0 */24 * * * certbot renew --quiet --renew-hook "/etc/init.d/nginx reload"
```


- Nginx https config


```

server {
    listen       443  ssl http2;
    server_name  _;

    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;

    ssl                  on;
    ssl_certificate      /etc/letsencrypt/live/git.10sh.cn/fullchain.pem;
    ssl_certificate_key  /etc/letsencrypt/live/git.10sh.cn/privkey.pem;

    ssl_ciphers 'ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA:ECDHE-RSA-AES128-SHA:AES256-GCM-SHA384:AES128-GCM-SHA256:AES256-SHA256:AES128-SHA256:AES256-SHA:AES128-SHA:!aNULL:!eNULL:!EXPORT:!DES:!MD5:!PSK:!RC4';
    ssl_protocols  TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;
    ssl_session_cache  builtin:1000  shared:SSL:10m;
    ssl_session_timeout  5m;

    ## Real IP Module Config
    ## http://nginx.org/en/docs/http/ngx_http_realip_module.html

    ## HSTS Config
    ## https://www.nginx.com/blog/http-strict-transport-security-hsts-and-nginx/
    add_header Strict-Transport-Security "max-age=31536000";
    add_header Referrer-Policy strict-origin-when-cross-origin;

	location / {
		proxy_set_header Host $host;
		proxy_set_header X-Real-ip $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header X-Forwarded-Proto https;
		proxy_redirect off;
		proxy_pass http://localhost:3000;
		#proxy_pass http://unicorn;

 	}
}

```
