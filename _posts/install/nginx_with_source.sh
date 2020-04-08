# install nginx

## source code

PACKAGE_NAME="nginx-1.12.2"

wget https://nginx.org/download/$PACKAGE_NAME.tar.gz

tar -zxf $PACKAGE_NAME.tar.gz

cd $PACKAGE_NAME

./configure

make && sudo make install

cd ..

sudo rm -R $PACKAGE_NAME

rm $PACKAGE_NAME.tar.gz

## ubuntu

sudo apt-get install libpcre3 libpcre3-dev zlib1g-dev libssl-dev build-essential openssl


  ## nginx
  # 启动nginx
  # >sudo /usr/local/nginx/sbin/nginx –t

  # 若提示没有nginx.pid文件
  # >sudo /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf

  # 重启nginx
  # >sudo /usr/local/nginx/sbin/nginx -s reload –t


  # >nano /usr/local/nginx/conf/nginx.conf

  # include /home/deploy/web_server/config/nginx.conf


# 配置代理 mysql 转发

./configure --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_realip_module --with-http_flv_module --with-http_mp4_module --with-http_gzip_static_module --with-stream --with-stream_ssl_module

stream {
   server {
        listen 23456;
        proxy_connect_timeout 1s;
        proxy_timeout 3s;
        proxy_pass 127.0.0.1:3306;
   }
}
