#!/usr/bin/python
# -*- coding:utf-8 -*-

import traceback
import datetime
import logging

# 自定义的日志输出
def log(msg, level = logging.DEBUG):
    logging.log(level, msg)
    print('%s [%s], msg:%s' % (datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'), level, msg))

    if level == logging.WARNING or level == logging.ERROR:
        for line in traceback.format_stack():
            print(line.strip())

        for line in traceback.format_stack():
            logging.log(level, line.strip())

logging.basicConfig(
    filename = 'log/run.log',
    format = '%(asctime)s: %(message)s',
    level = logging.DEBUG
)

log( "开始下载升级文件...")
