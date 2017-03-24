#!/usr/bin/python
# coding=utf-8

# test write file for python
# usage: python 0_test_write_users.py
#  by cheenwe 2017-03-24

import time
start_at = time.time()
# write file
f = open("users.txt", 'w+')
open_at = time.time()

for x in xrange(1,1000000):
  f.write( str(x) + ", wahaha"+ ",12312312323" + ",12" + ",texzt"  + " \n" )

end_at = time.time()
f.close()

print "total: ",  (time.time() - start_at)*1000
print "open file: ",  (open_at - start_at)*1000
print "for 100000 times: ", (end_at - open_at)*1000


# total:  56.9939613342
# open file:  0.365018844604
# for 100000 times:  56.2789440155

# total:  53.9829730988
# open file:  0.391006469727
# for 100000 times:  53.2660484314
