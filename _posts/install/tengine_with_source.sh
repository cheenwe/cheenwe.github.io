# install nginx
sudo -i

sudo apt install libssl-dev  autoconf

git clone  https://github.com/jemalloc/jemalloc.git /root/install/jemalloc #开启jemalloc内存优化


PACKAGE_NAME="tengine-2.3.2"


wget http://tengine.taobao.org/download/$PACKAGE_NAME.tar.gz
tar -zxf  $PACKAGE_NAME.tar.gz
cd $PACKAGE_NAME


useradd nginx


./configure --prefix=/usr/share/nginx --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/lock/subsys/nginx --user=nginx --group=nginx --with-http_ssl_module --with-http_realip_module --with-http_addition_module --with-http_sub_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_stub_status_module --with-http_auth_request_module  --with-http_degradation_module --with-mail --with-mail_ssl_module --with-file-aio --with-ipv6  --with-http_v2_module   --add-module=./modules/ngx_http_concat_module  --add-module=./modules/ngx_http_reqstat_module --add-module=./modules/ngx_http_sysguard_module --add-module=./modules/ngx_http_upstream_consistent_hash_module --add-module=./modules/ngx_http_user_agent_module  --add-module=./modules/ngx_multi_upstream_module  --with-stream_sni --with-stream_ssl_module   --with-jemalloc=/root/install/jemalloc  --with-http_gzip_static_module --with-http_realip_module

make -j 12
make install -j 12


## 服务制作

cat <<EOF >>/lib/systemd/system/nginx.service


[Unit]
Description=A high performance web server and a reverse proxy server
After=network.target

[Service]
Type=forking
PIDFile=/var/run/nginx.pid
#ExecStartPre=/usr/local/nginx/sbin/nginx
ExecStart=/usr/sbin/nginx
ExecReload=/usr/sbin/nginx -s reload
ExecStop=-/sbin/start-stop-daemon --quiet --stop --retry QUIT/5 --pidfile /run/nginx.pid
TimeoutStopSec=5
KillMode=mixed

[Install]
WantedBy=multi-user.target

EOF



systemctl enable --now nginx.service
# systemctl daemon-reload
systemctl status nginx.service
