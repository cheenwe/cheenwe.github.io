
#  gem  install  net-ldap
# or
#  gem 'net-ldap'

require 'rubygems'
require 'net/ldap'

dc_host = 'shemdc1.xxx.cn'
dc_port = '389'
dc_method = ':simple'
dc_username = 'emadmin@xxx.cn'
dc_password = 'xxx/'

# username = "cn=#{dc_username},dc=em-data,dc=com,dc=cn"

## 获取用户信息

ldap = Net::LDAP.new :host => dc_host,
    :port => dc_port,
    :auth => {
        :method => :simple,
        :username => dc_username,
        :password => dc_password
    }

# filter = Net::LDAP::Filter.eq("cn", "chen*")
treebase = "OU=EmUsers,dc=em-data,dc=com,dc=cn"

ldap.search(:base => treebase) do |entry|
# puts "DN: #{entry.dn}"
p " #{entry["company"][0]}, #{entry["department"][0]}, #{entry["name"][0]}, #{entry["mail"][0]},#{entry["title"][0]},#{entry["whencreated"][0]}" if entry["department"][0]&& entry["mail"][0]

# entry.each do |attribute, values|
#     puts "   #{attribute}:"
#     values.each do |value|
#     puts "      --->#{value}"
#     end
# end

end

p ldap.get_operation_result



## 搜索某个用户信息

treebase = "OU=EmUsers,dc=em-data,dc=com,dc=cn"
filter = Net::LDAP::Filter.eq("mail", "chenwei@xxx.cn")
attrs = ["department", "name", "mail", "title", "whencreated"]


ldap = Net::LDAP.new :host => dc_host,
    :port => dc_port,
    :auth => {
        :method => :simple,
        :username => dc_username,
        :password => dc_password
    }


ldap.search(:base => treebase, :filter => filter, :attributes => attrs,
            :return_result => false) do |entry|
    puts "DN: #{entry.dn}"
    entry.each do |attr, values|
    puts ".......#{attr}:"
    values.each do |value|
        puts "          #{value}"
    end
    end
end


## = 验证账户密码

ldap = Net::LDAP.new :host => dc_host,
    :port => dc_port,
    :auth => {
            :method => :simple,
            :username => "陈伟",
            :password => "xx?"
        }

 if ldap.bind
   p "authentication succeeded"
 else
   # authentication failed
   p "authentication failed"
 end
