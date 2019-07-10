#!/bin/bash

## 安装
sudo add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main"
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

sudo apt-get update

sudo apt-get install postgresql-9.6






## 复制数据文件到新主机

```
sudo chown -R postgres /var/lib/postgresql/
sudo service  postgresql start
sudo chmod  -R 0700 /var/lib/postgresql/
sudo service  postgresql start

```



## 命令

```
sudo -u postgres psql

ALTER USER git WITH PASSWORD 'git';


sudo -u postgres psql ALTER USER git WITH PASSWORD 'git';





1、相当与mysql的show databases;

select datname from pg_database;

2、相当于mysql的show tables;

SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';

public 是默认的schema的名字

3、相当与mysql的describe table_name;

SELECT column_name FROM information_schema.columns WHERE table_name ='table_name';

'table_name'是要查询的表的名字



```
