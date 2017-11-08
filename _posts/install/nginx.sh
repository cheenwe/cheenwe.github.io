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
