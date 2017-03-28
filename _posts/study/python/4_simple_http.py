#!/usr/bin/python
# coding=utf-8

#  by cheenwe 2017-03-24

import BaseHTTPServer

class RequestHandler(BaseHTTPServer.BaseHTTPRequestHandler):
	Page = '''\
	    <html>
	    <body>
	    <p>Hello World</p>
	    </body>
	    </html>
	'''
	# Request
	def do_GET(self):
		self.send_response(200)
		self.send_header("Content-Type", "text/html")
		self.send_header("Content-Length", str(len(self.Page)))
		self.end_headers()
		self.wfile.write(self.Page)

if __name__ == '__main__':
	serverAdress = ('', 9090)
	server = BaseHTTPServer.HTTPServer(serverAdress, RequestHandler)
	print "server is open port 9090	"
	server.serve_forever()
