#!/usr/bin/python
# -*- coding: utf-8 -*-

while True:
  try:
    x = input('Enter a number: ')
    y = input('Enter another number: ')
    print x/y
    # print "this is a simple"
  except:
    print "your input is wrong"
  else:
    print "haha, it's ok?"
  finally:
    print ">>>>>>>>>>"