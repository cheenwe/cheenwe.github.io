


## Ubuntu18修改hostname重启后恢复原始设置的解决方法


在Ubuntu 16.04及多数Linux版本中，如需要修改hostname，直接修改/etc/hostname文件即可。
但是在Ubuntu 18.04及18.10中，修改/etc/hostname文件后，重启电脑就会恢复原始的设置。


原因：
Ubuntu在新版中默认安装了cloud-init工具，是一个自动化的云服务工具。
当系统启动时，cloud-init会从nova metadata服务或config drive中获取metadata，完成包括但不限于下面的定制化工作：
1.设置default locale
2.设置hostname
3.添加ssh keys到.ssh/authorized_keys
4.设置用户密码
5.配置网络
6.安装软件包





解决方法：
sudo vim /etc/cloud/cloud.cfg
找到preserve_hostname: false这行，把false改成true。
作用是保存用户修改的hostname值，不重新从云端同步hostname。


然后就可修改hostname了。附上修改的3种方法（任意一种均可修改）：
1.输入命令（旧版）
sudo hostname myHostname #这里的myHostname就是修改的名字

2.输入命令（新版）
sudo hostnamectl set-hostname myHostname #这里的myHostname就是修改的名字

3.修改/etc/hostname文件中的值
sudo vim /etc/hostname


修改后重启电脑。



## mac checking whether the C compiler works... no

sudo ln -s /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/ /Applications/Xcode.app/Contents/Developer/Toolchains/OSX10.9.xctoolchain


brew install apple-gcc42



## elk日志监控平台搭建
版本：6.1.3
1. jdk 安装（略）
2. kibana 安装
  tar xvzf kibana-6.1.3-linux-x86_64.tar.gz
  启动 ： ./bin/kibana
  验证： http://localhost:5601
  后台启动： ./bin/kibana &
  exit退出

3. elasticsearch 安装
  tar xvzf elasticsearch-6.1.3.tar.gz
  修改配置文件  vim elasticsearch.yml
  network.host:0.0.0.0
  启动： ./bin/elasticsearch -d #-d为后台启动
  验证： http://ip:9200

  报错：max file descriptors [65535] for elasticsearch process is too low, increase to at least [65536]

  编辑 /etc/security/limits.conf
  追加：* soft nofile 65536
      * hard nofile 131072
      * soft nproc 2048
      * hard nproc 4096

  报错： max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]

  编辑： /etc/sysctl.conf
  追加：vm.max_map_count=655360
  保存后，执行：
      sysctl -p

4. logstash 安装
  unzip logstash-6.1.3.zip
  修改配置：vi config/jvm.options
    -Xms6g  (运行内存，具体多大视配置而定)
    -Xmx6g
  新建 logstash.conf 文件（文件名自定义）
  插件内容（更多内容参照官网）：
    input {
      file {
       path => "/usr/local/src/open_falcon/alarm/logs/*.log"
       start_position => "beginning"    #定义文件读取的位置
     }
    }


    output {
      # 输出到 elasticsearch
      elasticsearch {
         hosts => ["192.168.31.128:9200"]
         index => "test_elk"
       }
      #输出到文件
      #file {
      #       path => "/usr/local/test.log"
      #}

    }

  启动：bin/logstash -f logstash.conf


5.其他

/root/soft/watch_logstash &
/root/soft/kafka_2.11-0.11.0.0/bin/zookeeper-server-start.sh config/zookeeper.properties &
/root/soft/kafka_2.11-0.11.0.0/bin/kafka-server-start.sh config/server.properties & # 开启 kafka

/root/soft/open-falcon/open-falcon start & # open falcon
/root/soft/kibana-6.1.3/bin/kibana &
/root/soft/logstash-6.1.3/bin/logstash -f /root/soft/logstash-6.1.3/wechat.cnf  &

cd /root/soft/elasticsearch-6.1.3/elasticsearch-head-master && grunt server &

/etc/init.d/nginx stop #stop apt nginx
/usr/local/nginx/sbin/nginx  #start source code nginx

su deploy
/data/elasticsearch-6.1.3/bin/elasticsearch -d





## Ubuntu Falcon+ 监控报警


  #安装 golang

PACKAGE_NAME="1.10.3"
wget https://studygolang.com/dl/golang/go$PACKAGE_NAME.linux-amd64.tar.gz


#scp user@192.168.30.30:~/project/go1.10.3.linux-amd64.tar.gz .

sudo tar -C /usr/local -zxvf go$PACKAGE_NAME.linux-amd64.tar.gz
mkdir -p ~/go/src
echo "export GOPATH=$HOME/go" >> ~/.bashrc
echo "export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin" >> ~/.bashrc
source ~/.bashrc
go version

  # 导入数据库

sudo apt install redis-server mysql-server

cd /tmp/ && git clone https://github.com/open-falcon/falcon-plus.git
cd /tmp/falcon-plus/scripts/mysql/db_schema/

passwd="root"
mysql -u root -p$passwd < 1_uic-db-schema.sql
mysql -u root -p$passwd < 2_portal-db-schema.sql
mysql -u root -p$passwd < 3_dashboard-db-schema.sql
mysql -u root -p$passwd < 4_graph-db-schema.sql
mysql -u root -p$passwd < 5_alarms-db-schema.sql

cd 
rm -rf /tmp/falcon-plus/


  # 安装 falcon 后端

version=v0.2.1

mkdir -p ~/falcon/falcon-plus
cd ~/falcon/falcon-plus

wget https://github.com/open-falcon/falcon-plus/releases/download/$version/open-falcon-$version.tar.gz

tar -zxf open-falcon-$version.tar.gz

cd ~/falcon/falcon-plus

  #修改 real_user 为你数据库 用户
real_user=root
  #修改 real_password 为你数据库 密码
real_password=root


grep -Ilr 3306  ./ | xargs -n1 -- sed -i 's/root:@/$real_user:$real_password@/g'


  # 安装 falcon 前端


sudo apt-get install -y python-virtualenv slapd ldap-utils libmysqld-dev build-essential python-dev libldap2-dev libsasl2-dev libssl-dev


cd ~/falcon/falcon-plus

git clone https://github.com/open-falcon/dashboard.git

cd ~/falcon/falcon-plus/dashboard

virtualenv ./env

./env/bin/pip install -r pip_requirements.txt -i https://pypi.douban.com/simple

  #dashboard的配置文件为： 'rrd/config.py'，请根据实际情况修改

  ## API_ADDR 表示后端api组件的地址
  API_ADDR = "http://127.0.0.1:8080/api/v1"

  ## 根据实际情况，修改PORTAL_DB_*, 默认用户名为root，默认密码为""
  ## 根据实际情况，修改ALARM_DB_*, 默认用户名为root，默认密码为""




# 使用python处理selenium中的xpath定位元素的模糊匹配问题


## 用contains，寻找页面中style属性值包含有sp.gif这个关键字的所有div元素,其中@后面可以跟该元素任意的属性名。

self.driver.find_element_by_xpath('//div[contains(@style,"sp.gif")]').click()

## 用start-with，寻找style属性以position开头的div元素,其中@后面可以跟该元素任意的属性名。

self.driver.find_element_by_xpath('//div[start-with(@style,"position")]').click()

## 用Text，直接查找页面当中所有的退出二字，经常用于纯文字的查找。

self.driver.find_element_by_xpath('//*[text()="退出"]').click()

## 用于知道超链接上显示的部分或全部文本信息

self.driver.find_element_by_xpath('//a[contains(text(), "退出")]').click()

 




 
在公司为了使用RTX，专门安装了一个XP的虚拟机，但是这个也不方便，每天得开个虚拟机，并且别人给你发的消息你很多时候不能立马看到。
所以准备在Linux搞个RTX，这样就能解决我的问题。


下面说一下安装的步骤，以及一些问题的解决方法：

1、安装windows的软件，第一件事当然是安装个wine
如果是Ubuntu，直接：

$sudo apt-get install wine
2、下载winetricks脚本

    wget  http://kegel.com/wine/winetricks

利用winetricks脚本安装一些RTX需要的windows的组件

    sh winetricks msxml3 gdiplus riched20 riched30 ie6 vcrun6 vcrun2005sp1
3、安装RTX
从RTX官网下载RTX客户端，

    wget http://dldir1.qq.com/foxmail/rtx/rtxclient2015formal.exe

然后安装。
4.安装之后的RTX有个问题，就是名字的前两个字是乱码，需要配置一下wine来解决这个问题。
在菜单中选择wine->configure wine打开wine configure的对话框，选择函数库tab,在新增函数库顶替中选择oleaut32添加，然后重新启动RTX皆可。





## linux下使用cpu并发解压缩来加快速度

pigz是支持并行的gzip,默认用当前逻辑cpu个数来并发压缩，无法检测个数的话，则并发8个线程

>sudo apt install pigz 

### 打包

>tar --use-compress-program=pigz -cvpf 0918.tgz ./20180918/

### 解包

> tar --use-compress-program=pigz -xvpf package.tgz -C ./package







## 报错

### kernel:NMI watchdog: BUG: soft lockup - CPU#8 stuck for 26s

跑大量高负载程序，造成cpu soft lockup

```
#nano /etc/sysctl.conf

kernel.watchdog_thresh=30
```
