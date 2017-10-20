---
layout: post
title: 本地定时备份mysql数据库脚本
tags: mysql backup
category: mysql
---


#  备份mysql数据库
支持 同时备份多个数据库,自定义备份路径,数据库用户名,密码,备份日志等

## 脚本
>/home/root/mysqlbackup.sh

```bash
  #!/bin/bash
  #by chennewe 2015-11-26

  #自动备份mysql 脚本

bak_databases=(dbname1 dbname2 dbname3) # 要备份的数据库名，多个数据库用空格分开
bak_path='/root/backup/' #备份路径
bak_user=root #备份用户名
bak_password="root" #备份密码
bak_date=`date +%F` #备份日期

export PATH=$PATH:/usr/bin
  # echo $PATH

if [ ! -d "$bak_path" ]; then
  mkdir -p "$bak_path"
fi

  # 循环备份数据库名
for db in ${bak_databases[*]}
  do
    # 备份数据库生成SQL文件

  mysqldump -u$bak_user -p$bak_password --database $db > $bak_path$db-$bak_date.sql

    # 生成日志

  if [ -f $bak_path$db-$bak_date.sql ]
   then
    # 将生成的SQL文件压缩
    tar zPcf  $bak_path$db-$bak_date.sql.tar.gz $bak_path$db-$bak_date.sql
         echo "$bak_date  |$db-$bak_date.sql.tar.gz | backup successful" >> $bak_path/backup_mysql_success.log
   else
         echo  "$bak_date  | $db-$bak_date.sql  backup | backup  fail " >> $bak_path/backup_mysql_fail.log
  fi

    #解压
    # tar -xzvf xx.tar.gz

    # 删除7天之前的备份数据
    # find $bak_path -mtime +7 -name "*.sql.tar.gz" -exec rm -rf {} \;

done

  # 删除生成的SQL文件

rm -rf $bak_path/*.sql

```


## 设置定时执行
>crontab -e

设置为凌晨 1 点执行：

>0 1 * * * /home/root/mysqlbackup.sh


## 设置开机启动脚本执行
>crontab -e