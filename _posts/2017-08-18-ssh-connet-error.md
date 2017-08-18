---
layout: post
title: 使用 SSH Secure Shell Client 连接  Ubuntu 报错
tags:   ssh
category:  ssh
---


# 使用 SSH Secure Shell Client 连接  Ubuntu 报错

1. edit  sshd_config

>sudo nano /etc/ssh/sshd_config

copy this
```
Ciphers aes128-cbc,aes192-cbc,aes256-cbc,aes128-ctr,aes192-ctr,aes256-ctr,3des-cbc,arcfour128,arcfour256,arcfour,blowfish-cbc,cast128-cbc
MACs hmac-md5,hmac-sha1,umac-64@openssh.com,hmac-ripemd160,hmac-sha1-96,hmac-md5-96
KexAlgorithms diffie-hellman-group1-sha1,diffie-hellman-group14-sha1,diffie-hellman-group-exchange-sha1,diffie-hellman-group-exchange-sha256,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group1-sha1,curve25519-sha256@libssh.org
```

2. restart ssh

> service sshd restart

