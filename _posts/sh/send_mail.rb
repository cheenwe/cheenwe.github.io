# Ruby 发送邮件的方式
# gem install mail

#!/usr/bin/ruby

require 'mail'

smtp = {
				:address => 'smtp.163.com',
				:port => 25,
				:domain => '163.com',
				:user_name => 'cxhyun@163.com',
				:password => 'xxxxxxxx',
				:enable_starttls_auto => true,
				:openssl_verify_mode => 'none'
			}

Mail.defaults { delivery_method :smtp, smtp }

mail = Mail.new do
  from 'cxhyun@163.com'
  to '869523867@qq.com'
  subject '这是邮件主题'
  body 'body:hello send mail way 2 :)'
  # add_file '/Users/chenwei/Desktop/spritesheet.png'
  # add_file :filename => 'spritesheet.png', :content => File.read('/Users/chenwei/Desktop/spritesheet.png')
end

mail.deliver!



# 使用sendmail
# sudo apt-get install sendmail

#!/usr/bin/ruby

require 'mail'

mail = Mail.new do
  from     'root@pm.cheenwe.cn'
  to       '869523867@qq.com'
  subject  'Here is the image you wanted'
  body     "May be good!"#File.read('body.txt')
  add_file '/root/sh/email.rb'
  # add_file :filename => 'database.yml', :content => File.read('/home/ubuntu/backup/database.yml')
end

mail.delivery_method :sendmail

mail.deliver!



