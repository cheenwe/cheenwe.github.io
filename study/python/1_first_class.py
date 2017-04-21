#!/usr/bin/python
# -*- coding: utf-8 -*-

# database.py
_metaclass_ = type
class User:
  def setName(self, name):
    self.name = name

  def hi(self):
    print "hello ,I'm %s. " % self.name

user = User()
user.setName("Chenwei")
user.hi()
