## ubuntu Trash ‘s location

 ~/.local/share/Trash/







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





## Falcon+ 监控报警
