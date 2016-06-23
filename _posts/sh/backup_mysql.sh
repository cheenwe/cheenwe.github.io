#!/bin/bash
#by chennewe 2015-11-26

bak_databases=(ihop_api ah_dev)
bak_path='/root/backup/mysql/'
bak_user=root
bak_password="root"
bak_date=`date +%F`

export PATH=$PATH:/usr/bin
echo $PATH

if [ ! -d "$bak_path" ]; then
  mkdir -p "$bak_path"
fi

for db in ${bak_databases[*]}
  do
        mysqldump -u$bak_user -p$bak_password --database $db > $bak_path$db-$bak_date.sql

        if [ -f $bak_path$db-$bak_date.sql ]
         then
                tar zPcf  $bak_path$db-$bak_date.sql.tar.gz $bak_path$db-$bak_date.sql
               echo "$db-$bak_date.sql.tar.gz  backup successful" >> $bak_path/backup_mysql_success.log
         else
               echo  "$db-$bak_date.sql  backup  fail  and  file no exist" >> $bak_path/backup_mysql_fail.log
        fi
done

  rm -rf $bak_path/*.sql
