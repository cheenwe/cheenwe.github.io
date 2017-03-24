#!/usr/bin/ruby
# coding=utf-8

# test write file for ruby
# usage: ruby 0_test_write_users.rb
#  by cheenwe 2017-03-24

start_at = Time.now

f = File.open("users.rb.txt", 'w+')

open_at = Time.now
  1_000_000.times do |i|
    f.puts "#{ i} " + ", wahaha"+ ",12312312323" + ",12" + ",texzt"  + " \n"
  end
end_at = Time.now

f.close()


puts "total:  #{ (Time.now - start_at)*1000}"
puts "open file:  #{( open_at - start_at)*1000}"
puts "for 100000 times:  #{(end_at - open_at)*1000}"

# total:  139.282036
# open file:  0.538615
# for 100000 times:  138.406316

# total:  127.00651199999999
# open file:  0.374507
# for 100000 times:  126.284391