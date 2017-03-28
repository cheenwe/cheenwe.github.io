#!/usr/bin/python
# coding=utf-8

#  by cheenwe 2017-03-24
#  simple sqlite insert demo

import sqlite3

def conver(value):
	if value.startswith('~'):
		return value.strip('~')
	if not value:
		value = '0'
	return value

conn  = sqlite3.connect("user.db")
curs = conn.cursor()

curs.execute('''
	CREATE TABLE users(
		id		INTEGER		PRIMARY KEY,
		name 	TEXT,
		phone	TEXT,
		age		INTEGER,
		remark  TEXT
	)
	''')

query = 'INSERT INTO users VALUES(?, ?, ?, ?, ?)'
for line in open("users.txt"):
	fields = line.split(',')
	vals = [conver(f) for f in fields[:1000]]
	curs.execute(query, vals)
	print "success"

conn.commit()
conn.close()