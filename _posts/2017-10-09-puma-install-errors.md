---
layout: post
title: Puma install errors
tags:   puma 
category:  gems
---




#  OSX Puma install errors

报错详情

```
Building native extensions.  This could take a while...
ERROR:  Error installing puma:
	ERROR: Failed to build gem native extension.
...
mini_ssl.c:4:10: fatal error: 'openssl/bio.h' file not found
#include <openssl/bio.h>
...
An error occurred while installing puma (2.6.0), and Bundler cannot continue.
Make sure that `gem install puma -v '2.6.0'` succeeds before bundling.
``` 

解决

```
gem install puma -v '2.6.0' -- --with-cppflags=-I/usr/local/opt/openssl/include
bundle install
```



or  install  libssl-dev 
>sudo apt-get install python-pip python-dev libffi-dev libssl-dev libxml2-dev libxslt1-dev libjpeg8-dev zlib1g-dev

2017 10.20
