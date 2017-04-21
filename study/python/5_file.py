#!/usr/bin/python
# coding=utf-8

#  by cheenwe 2017-03-24

# write file
f = open("1.txt", 'w+')
f.write("hello \n")
f.write("hi")
f.close()

# read file
f1 = open(r"/home/chenwei/workspace/python/study/1.txt")
print f1.read(1)
f1.close()

# read line
f2 = open(r'1.txt')
for i in xrange(1,3):
	print str(i) + ":" + f2.readline(),
f2.close()

print "\n"

# readlines
import pprint
f3 = open(r'1.txt')
pprint.pprint(f3.readlines())
f3.close()

# read by character
f = open(r'1.txt')
while True:
	char = f.read(1)
	if  char == "": break
	print char
f.close()


# read by character
f = open(r'1.txt')
for line in f:
	print line
	pass
f.close()