#!/usr/bin/ruby
# coding=utf-8

#  by cheenwe 2017-03-24

# write file

require 'socket'
s = TCPSocket.new "localhost", 1234
while line = s.gets
  puts line

end
s.close