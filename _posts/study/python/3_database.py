#!/usr/bin/python
# -*- coding: utf-8 -*-

# database.py
#  存储和查找 用户
import sys, shelve

def new_user(db):
	uid = raw_input(' 请输入id: ')
	user={}
	user['name'] = raw_input('输入用户名：')
	user['age'] = raw_input('输入年龄：')
	user['phone'] = raw_input('输入电话号码：')
	db[uid] = user

def find_user(db):
	uid = raw_input('输入查询id: ')
	field = raw_input('信息如下，(姓名/name， 年龄/age， 电话/phone)')
	field = field.strip().lower()
	print field.capitalize() + ': ',\
		db[uid][field]

def print_help():
	print '帮助命令'
	print 'new: 新建用户'
	print 'find: 查找用户'
	print 'quit:  保存并退出'
	print '?: 显示帮助'

def enter_command():
	cmd = raw_input('请输入命令(? 打开帮助): ')
	cmd = cmd.strip().lower()
	return cmd


def main():
	database = shelve.open('db.dat')
	try:
		while True:
			cmd = enter_command()
			if cmd == 'new':
				new_user(database)
			elif cmd == 'find':
				find_user(database)
			elif cmd == '?':
				print_help()
			elif cmd == 'quit':
				return
	finally:
		database.close()
if __name__ == '__main__': main()