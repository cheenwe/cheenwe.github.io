# -*- coding: utf-8 -*-
from celery_app import task
task.add.apply_async(args=[2, 8])        # 也可用 task1.add.delay(2, 8)
print('hello world')