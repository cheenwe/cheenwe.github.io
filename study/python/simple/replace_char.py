#!/usr/bin/python
# -*- coding:utf-8 -*-


# import linecache

# theline = linecache.getline(r'config.py', 2)
# print theline

# f1 = open('config.py')
# con = f1.read()

# con1 = con.replace('\n0.0.1\n', '\n#version = "0.0.2"\n')

# print con1

# f1.close()

# import os
# import  re

# f = open ("config.py", "r+")
# open('config.py', 'w').write(re.sub('\n0.0.1\n', '\n#0.0.2\n', f.read()))




# f = open('config.py','rw')
# c = f.read()
# t = c.replace('0.0.1', '0.0.2')
# f.seek(0, 0)
# f.write(t)

with open('config.py','r') as r:

    lines=r.readlines()
with open('config.py','w') as w:
    for l in lines:
        w.write(l.replace('0.0.1', '0.0.2'))