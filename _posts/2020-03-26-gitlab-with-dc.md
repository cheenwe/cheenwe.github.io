---
layout: post
title: 内网转发
tags: ssh 
category: ssh
---

GitLab 和 域控进行结合


修改配置文件 `/etc/gitlab/gitlab.rb`

```
gitlab_rails['ldap_enabled'] = true

###! **remember to close this block with 'EOS' below**
gitlab_rails['ldap_servers'] = YAML.load <<-'EOS'
   main: # 'main' is the GitLab 'provider ID' of this LDAP server
     label: 'LDAP'
     host: '192.168.30.2' #change to dc ip or host
     port: 389
     uid: 'sAMAccountName'
     method: 'plain' # "tls" or "ssl" or "plain"
     bind_dn: 'admin@cheenwe.cn' #change to admin account
     password: 'Password' #change to admin password
     verify_certificates: true
     smartcard_auth: false
     active_directory: true
     allow_username_or_email_login: true
     lowercase_usernames: false
     block_auto_created_users: false
     base: 'dc=cheenwe.cn,dc=com,dc=cn' #change your dc
     user_filter: ''          
EOS
```


参数说明：
- host 、port ：是 LDAP 服务的主机IP和端口。
- bind_dn ：管理 LDAP 的 dn。指定ldap服务器的管理员信息，即cn=账户，cn=组织单位。
- base：表 LDAP 将以该 dn 为 节点，向下查找用户。ldap服务器的base域。
- user_filter：表以某种过滤条件筛选用户。为空表示不过滤。
例如需要过滤允许的用户：
user_filter: '(CN=sambauser1)'


使用gitlab命令配置重置生效

```

gitlab-ctl reconfigure

gitlab-ctl restart
 
gitlab-rake gitlab:ldap:check
```
