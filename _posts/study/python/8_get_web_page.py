import socket

s = socket.socket()

host = socket.gethostname()
port = 1234
s.bind((host, port))

s.listen(5)
while True:
	c, addr = s.accept()
	print "Get coonect from", addr
	c.send('Thanks your coonecting')
	c.close()