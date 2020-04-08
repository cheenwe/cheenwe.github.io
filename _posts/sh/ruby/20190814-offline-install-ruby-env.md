## 离线环境下将一台ubuntu服务器上的ruby环境快速部署到另外一台电脑上


## 需要用到的库

```

/usr/bin/ruby
/usr/bin/ruby2.3
/var/lib/gems
/usr/include/ruby-2.3.0
/usr/lib/ruby

/usr/lib/x86_64-linux-gnu/libruby-2.3-static.a
/usr/lib/x86_64-linux-gnu/libruby-2.3.so
/usr/lib/x86_64-linux-gnu/libruby-2.3.so.2.3
/usr/lib/x86_64-linux-gnu/libruby-2.3.so.2.3.0
/usr/lib/x86_64-linux-gnu/ruby
/usr/lib/x86_64-linux-gnu/pkgconfig/ruby-2.3.pc
/usr/lib/x86_64-linux-gnu/ruby/

/var/lib/gems/2.3.0

```

## A电脑有ruby环境上操作


mkdir -p /tmp/ruby2.3/usr/bin/
mkdir -p /tmp/ruby2.3/var/lib/
mkdir -p /tmp/ruby2.3/usr/include/
mkdir -p /tmp/ruby2.3/usr/lib/x86_64-linux-gnu/
mkdir -p /tmp/ruby2.3/var/lib/gems/


cp -rf /usr/bin/ruby /tmp/ruby2.3/usr/bin/
cp -rf /usr/bin/ruby2.3 /tmp/ruby2.3/usr/bin/
cp -rf /var/lib/gems /tmp/ruby2.3/var/lib/
cp -rf /usr/include/ruby-2.3.0 /tmp/ruby2.3/usr/include/
cp -rf /usr/lib/ruby /tmp/ruby2.3/usr/lib/

cp -rf /usr/lib/x86_64-linux-gnu/libruby-2.3-static.a /tmp/ruby2.3/usr/lib/x86_64-linux-gnu/
cp -rf /usr/lib/x86_64-linux-gnu/libruby-2.3.so.2.3 /tmp/ruby2.3/usr/lib/x86_64-linux-gnu/
cp -rf /usr/lib/x86_64-linux-gnu/libruby-2.3.so.2.3.0 /tmp/ruby2.3/usr/lib/x86_64-linux-gnu/
cp -rf /usr/lib/x86_64-linux-gnu/ruby /tmp/ruby2.3/usr/lib/x86_64-linux-gnu/
cp -rf /usr/lib/x86_64-linux-gnu/pkgconfig/ruby-2.3.pc /tmp/ruby2.3/usr/lib/x86_64-linux-gnu/pkgconfig/
cp -rf /usr/lib/x86_64-linux-gnu/pkgconfig/ruby /tmp/ruby2.3/usr/lib/x86_64-linux-gnu/

cp -rf /var/lib/gems/2.3.0 /tmp/ruby2.3/var/lib/gems/


tar -zcvf /tmp/ruby2.3.tar.gz /tmp/ruby2.3


## B 电脑安装执行


cp -rf /tmp/ruby2.3/usr/bin/ruby /usr/bin/ruby
cp -rf /tmp/ruby2.3/usr/bin/ruby2.3 /usr/bin/ruby2.3
cp -rf /tmp/ruby2.3/var/lib/gems /var/lib/gems
cp -rf /tmp/ruby2.3/usr/include/ruby-2.3.0 /usr/include/ruby-2.3.0
cp -rf /tmp/ruby2.3/usr/lib/ruby /usr/lib/ruby

cp -rf /tmp/ruby2.3/usr/lib/x86_64-linux-gnu/libruby-2.3-static.a /usr/lib/x86_64-linux-gnu/libruby-2.3-static.a
cp -rf /tmp/ruby2.3/usr/lib/x86_64-linux-gnu/libruby-2.3.so /usr/lib/x86_64-linux-gnu/libruby-2.3.so
cp -rf /tmp/ruby2.3/usr/lib/x86_64-linux-gnu/libruby-2.3.so.2.3 /usr/lib/x86_64-linux-gnu/libruby-2.3.so.2.3
cp -rf /tmp/ruby2.3/usr/lib/x86_64-linux-gnu/libruby-2.3.so.2.3.0 /usr/lib/x86_64-linux-gnu/libruby-2.3.so.2.3.0
cp -rf /tmp/ruby2.3/usr/lib/x86_64-linux-gnu/ruby /usr/lib/x86_64-linux-gnu/ruby
cp -rf /tmp/ruby2.3/usr/lib/x86_64-linux-gnu/pkgconfig/ruby-2.3.pc /usr/lib/x86_64-linux-gnu/pkgconfig/ruby-2.3.pc
cp -rf /tmp/ruby2.3/usr/lib/x86_64-linux-gnu/ruby/ /usr/lib/x86_64-linux-gnu/ruby/

cp -rf /tmp/ruby2.3/var/lib/gems/2.3.0 /var/lib/gems/2.3.0
