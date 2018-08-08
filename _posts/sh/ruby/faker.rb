require 'faker'

Faker::Config.locale = 'zh-CN'

p Faker::Name.name
# p Faker::Address.full_address
BANKS= %w(中国工商银行 招商银行 中国农业银行 中国建设银行 中国银行 中国民生银行 中国光大银行 中信银行 交通银行 兴业银行 上海浦东发展银行 中国人民银行 华夏银行 深圳发展银行 广东发展银行 国家开发银行 中国邮政储蓄银行 中国进出口银行 中国农业发展银行 中国银行香港分行 北京银行 北京农村商业银行 天津银行 上海银行 上海农村商业银行 南京银行 宁波银行 杭州市商业银行 深圳平安银行 深圳农村商业银行 温州银行 厦门国际银行 济南市商业银行 重庆银行 哈尔滨银行 成都市商业银行 包头市商业银行 南昌市商业银行 贵阳商业银行 兰州市商业银行 常熟农村商业银行 青岛市商业银行 徽商银行 花旗中国银行 汇丰中国银行 渣打中国银行 香港汇丰银行 渣打(香港)银行 中国建设银行(亚洲) 东亚银行中国网站 恒生银行 花旗(台湾)银行 荷兰银行 欧力士银行 巴黎银行 美国运通银行 蒙特利尔银行 满地可银行 瑞士银行 德意志银行)


# 壹、贰、叁、肆、伍、陆、柒、捌、玖、拾、佰、仟、万、亿、元(圆)、角、分、零、整。

class Money
  # Mfraction = ['角', '分', '厘']
  Mfraction = ['角', '分']
  Mdigit = [
      '零', '壹', '贰', '叁', '肆',
      '伍', '陆', '柒', '捌', '玖'
  ];
  Munit = [
      ['元', '万', '亿'],
      ['', '拾', '佰', '仟']
  ];

  def cb(n)
    # ==== 处理小数部分
    s = ''
    head = n < 0 ? '欠' : '';
    m = n= n.abs();
    i = 0

    while  i < Mfraction.length;
      m1 = (((n * 1000 * (10 ** i)) % 1000)/100).to_i
      s = s + (Mdigit[m1] + Mfraction[i]).sub(/零./, '')
      i = i +1
    end
    s = (s==""? '整':s);
    m = m.to_i

    # ==== 处理整数部分
    i = 0
    while i < Munit[0].length && m > 0
      # p  "i: #{i}, m: #{m}, i: #{i}"
      j = 0
      t = ''
      while j < Munit[1].length && m >0
        t = Mdigit[m % 10] + Munit[1][j] + t;
        m = (m*10 / 100).to_i
        j = j +1
      end
      s = t.sub(/(零.)*零$/, '').sub(/^$/, '零') + Munit[0][i] + s
      i = i +1
    end

    res = head + s.sub(/(零.)*零元$/, '元').sub(/(零.)+/, '零').sub(/^整$/, '零元整')
    # p res
    return res
  end
end

file_name = "/tmp/export-1-#{Time.now.strftime("%Y%m%d%H%M%S")}.csv"

puts file_name
File.open("#{file_name}","w+:gbk") do |f|

  f.puts  "出票人-全称, 账户, 开户银行, 收款人-全称, 账户, 开户银行,  金额, 数字"
  200.times do |i|
  # a = Money.new.cb(10107001.315)
          company = Faker::Name.name
          account = Faker::Number.number(16)
          bank =  BANKS.sample
          reciver_name = Faker::Name.name
          reciver_account = Faker::Number.number(16)
          reciver_bank = BANKS.sample
          money = Faker::Number.between(1000, 99999999)
          cn_money = Money.new.cb(money)
          address = Faker::Address.state+ "  "+ Faker::Address.city_prefix + Faker::Address.city_suffix

          id_card = Faker::Number.number(16)
          cell_phone =   Faker::PhoneNumber.cell_phone

          f.puts "#{company},   #{account},  #{bank},  #{reciver_name},  #{reciver_account},  #{reciver_bank},  #{cn_money},  #{money}"
          # company = Faker::Company.name

          #  Faker::Address.city
          # p Faker::Address.street_name
  end

  f.close
end

file_name = "/tmp/export-#{Time.now.strftime("%Y%m%d%H%M%S")}.csv"

puts file_name

File.open("#{file_name}","w+:gbk") do |f|
  f.puts "汇-户名, 账户, 开户银行, 收款-全称, 账户, 开户银行, 地点, 证件号码, 电话, 金额, 数字"
  200.times do |i|
          company = Faker::Name.name
          account = Faker::Number.number(16)
          bank =  BANKS.sample
          reciver_name = Faker::Name.name
          reciver_account = Faker::Number.number(16)
          reciver_bank = BANKS.sample
          money = Faker::Number.between(1000, 99999999)
          cn_money = Money.new.cb(money)
          address = Faker::Address.state+ "  "+ Faker::Address.city_prefix + Faker::Address.city_suffix
          id_card = Faker::Number.number(16)
          cell_phone =   Faker::PhoneNumber.cell_phone

          f.puts "#{company},   #{account},  #{bank},  #{reciver_name},  #{reciver_account},  #{reciver_bank},  #{address}, #{id_card}, #{cell_phone}, #{cn_money},  #{money}"


    # p Faker::Name.name
    # p Faker::Number.number(16)
    # p Faker::Name.name
    # p Faker::Number.number(16)
    # p BANKS.sample
    # p Faker::Address.state+ "  "+ Faker::Address.city_prefix + Faker::Address.city_suffix

  end

  f.close
end
