#!/usr/bin/python
# coding=utf-8

#  by cheenwe 2017-03-24
#  simple socket

# import socket

# s = socket.socket()

# host = socket.gethostname()
# port = 1234
# s.bind((host, port))

# s.listen(5)
# while True:
# 	c, addr = s.accept()
# 	print "Get coonect from", addr
# 	c.send('Thanks your coonecting')
# 	c.close()

# with select socket server
import socket, select
s = socket.socket()

host = socket.gethostname()
port = 1234
s.bind((host, port))
s.listen(5)

inputs = [s]
while True:
  rs, ws, es = select.select(inputs, [], [])
  for r in rs:
    if r is s:
      c, addr = s.accept()
      print "Got a coonecting from: " , addr
      inputs.append(c)
    else:
      try:
        data = r.recv(1024)
        disconnected = not data
      except socket.error:
        disconnected = True
      if disconnected:
        print r.getpeername(), 'disconnected'
        inputs.remove(r)
      else:
        print data
