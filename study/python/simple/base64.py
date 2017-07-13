#!/usr/bin/python
# -*- coding:utf-8 -*-

# base64 转码

import time
import base64

str_time = time.time()/1991
req_str = base64.b64encode(str(str_time))
str = base64.b64decode(str(str_time))
print req_str

