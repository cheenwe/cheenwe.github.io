---
layout: post
title: python 链接 oracle
tags:    python   oracle
category:   python
---

# LINUX下python 链接 oracle


## 打开链接下载oracle并解压

https://github.com/oracle/odpi

[oracle_client](http://v.emdata.cn:3000//uploads/temp/file_share/link/61/oracle.tar.gz)

把解压的oracle文件放入/opt/oracle/目录下



## 操作步骤

```
sudo mkdir -p /opt/oracle

sudo mv instantclient_18_3 /opt/oracle/

cd /opt/oracle

sudo sh -c "echo /opt/oracle/instantclient_18_3 > /etc/ld.so.conf.d/oracle-instantclient.conf" #注意版本对应instantclient_18_3

sudo ldconfig

export LD_LIBRARY_PATH=/opt/oracle/instantclient_18_3:$LD_LIBRARY_PATH


mkdir -p /opt/oracle/instantclient_18_3/network/admin 

```

## 下载libaio

sudo apt install libaio-dev
 
## 示例代码

```
# -*- coding: utf-8 -*-
# python  with oracle
# https://github.com/oracle/odpi


import cx_Oracle
#引用模块cx_Oracle
import os

def conn_sql():

    os.environ['NLS_LANG'] = 'SIMPLIFIED CHINESE_CHINA.UTF8'

    db_user ="trff_zjk"
    db_passwd ="trff_zjk"
    db_host ="192.168.50.10:1521"

    # 数据库表名
    table_name = 'WX_ZPXX_20181227_02'

    # 数据库链接信息
    conn_info = db_user+"/"+ db_passwd +"@"+ db_host +"/orcl"
    conn=cx_Oracle.connect(conn_info)

    #连接数据库
    c=conn.cursor()
    return c

```


## Oracle 分页
```
SELECT * FROM 
(
SELECT A.*, ROWNUM RN 
FROM (SELECT * FROM TABLE_NAME) A 
WHERE ROWNUM <= 40
)
WHERE RN >= 21

```
