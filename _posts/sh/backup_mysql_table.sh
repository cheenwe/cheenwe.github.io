#!/usr/bin/env bash

# # # # # # # # BEGIN INIT INFO # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2017 cheenwe.
#  filename    : backup_db.sh
#  author      : chenwei
#  version     : 0.0.2
#  created     : 2015-11-26
#  description : 自动备份MySQL数据库
#                   备份全部数据库/指定表
#  history     :
#               1. Date: 2015-11-26
#               Author:  chenwei
#               Modification: 备份多个数据库
#  history     :
#               2. Date: 2018-12-28
#               Author:  chenwei
#               Modification: 备份指定表指定日期
# # # # # # # # END INIT INFO # # # # # # # # # # # # # # #


# 配置备份数据路径
bak_path='/usr/local/nginx/html/idata/'

#---- start ---- 配置mysql 连接信息
# 配置数据库名称
bak_databases=violated-test
bak_table=ser_outputdata
bak_user=root
bak_password="xxx"
#---- end ---- 配置mysql 连接信息

# 默认导出昨天数据，
#   配置开始时间
#   配置结束时间
bak_start_at=`date -d 'yesterday' "+%Y-%m-%d 0:00:00"`
bak_end_at=`date -d 'yesterday' "+%Y-%m-%d 24:00:00"`


db_date=`date -d 'yesterday' "+%Y%m%d"`
bak_date_at=`date "+%Y-%m-%d %H:%M:%S"`


if [ ! -d "$bak_path" ]; then
  mkdir -p "$bak_path"
fi

# 导出整个数据库
    # mysqldump -u$bak_user -p$bak_password --database $bak_databases > $bak_path$bak_table-$db_date.sql

# 导出指定表中指定日期中数据
mysqldump  -u$bak_user -p$bak_password   $bak_databases $bak_table --where="( wdatetime >= '$bak_start_at' AND  wdatetime  <= '$bak_end_at')"  > $bak_path$bak_table-$db_date.sql


if [ -f $bak_path$bak_table-$db_date.sql ]
  then
    cd $bak_path
    tar zcf  $bak_table-$db_date.sql.tar.gz $bak_table-$db_date.sql
    echo "[success] db |  $bak_date_at | $bak_table-$db_date.sql.tar.gz | backup  successful" >> $bak_path/backup_info.log
  else
    echo  "[error]  db | $bak_date_at  | $bak_table-$db_date.sql  backup | backup  fail " >> $bak_path/backup_info.log
fi

rm -rf $bak_path$bak_table-$db_date.sql

# 压缩昨天图片数据
cd /usr/local/nginx/html

tar -zcf  data_$db_date.tar.gz $db_date

mv  data_$db_date.tar.gz $bak_path

echo "[success] file |  $bak_date_at | data_$db_date.tar.gz | backup  successful" >> $bak_path/backup_info.log

#scp $bak_path$bak_table-$db_date.sql.tar.gz root@139.196.216.59:/home/chenwei/backup/databases/

#ruby /home/deploy/mail.rb
