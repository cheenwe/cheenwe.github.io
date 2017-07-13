#!/usr/bin/python
# -*- coding:utf-8 -*-

import os

path = os.getcwd()

parent_path = os.path.dirname(path)

if not os.path.exists(parent_path + '/downdir'):
    os.chdir(parent_path)
    os.makedirs('downdir')