---
layout: post
title: Python locale error: unsupported locale setting
tags:    python error
category:   python
---

新购了台阿里云服务器, 在使用 pip 安装包的时候, 报 locale.Error, 解决如下:


```sh
Traceback (most recent call last):
  File "/usr/bin/pip", line 11, in <module>
    sys.exit(main())
  File "/usr/lib/python2.7/dist-packages/pip/__init__.py", line 215, in main
    locale.setlocale(locale.LC_ALL, '')
  File "/usr/lib/python2.7/locale.py", line 581, in setlocale
    return _setlocale(category, locale)
locale.Error: unsupported locale setting

```

解决方法:

```sh

export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
sudo dpkg-reconfigure locales
```

