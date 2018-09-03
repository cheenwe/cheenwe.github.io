#!/bin/ruby
# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2018 cheenwe.
#  filename    : excel_to_csv.rb
#  author      : cheenwe
#  version     : 0.0.1
#  created     : 2018.08.25
#  description : 批量将目录下 excel 文件转成 csv
#                支持转换 xlsx 和 xls 两种文件类型
#
#  history     : 日志文件
#               1. Date: 2018.08.25
#               Author:  cheenwe
#               Modification: first add
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
## excel 转 csv 工具
# 批量将目录下 exce文件转换成 csv 格式

# -   支持转换 xlsx 和 xls 两种文件类型


# ## ubuntu 下环境准备:

# ```sh
# sudo apt install ruby2.3-dev  zlib1g-dev libxml2-dev
# sudo gem install roo spreadsheet
# ```

# ##  测试:

# 1. git clone https://github.com/cheenwe/convert_csv.git
# 2. 进入 `convert_csv` 目录,  执行 ./convert
# 3. 在目录 `csv_result` 能看到转换后的 CSV 文件


# ## 使用步骤:

# 1. 删除 `csv_result` 和  `xlsx` 中测试数据
# 2. 将要转换的文件 复制到 `xlsx` 目录中
# 3. 执行 ./convert
# 4. 在目录 `csv_result` 能看到转换后的 CSV 文件

#
require "pathname"
require 'roo'
require 'spreadsheet'
require 'fileutils'

########  配置区 ########
#
# 当前文件执行目录
root_dir=Pathname.new(File.dirname(__FILE__)).realpath
#
#修改 excel 文件所在路径
@excel_dir="#{root_dir}/xlsx"
#
#修改输出csv 文件路径
@output_csv_dir="#{root_dir}/csv_result"
#
########  配置区 ########

#创建目录
FileUtils.mkdir_p(@output_csv_dir)

# 处理 xls 和 xlsx 文件
def read_xlsx_excel(file)
  book = Roo::Spreadsheet.open(file)
  sheet=book.sheet(0)
  res = sheet.to_csv
end

def read_xls_excel(file)
  book = Spreadsheet.open(file)
  sheet = book.worksheets
  sheet1 = book.worksheet 0
  # p sheet1.last_row.to_s
  # 从第一行到最后一行
  res =''
  sheet1.each do |row|
    rts=''
    # 每一行中数据处理
    column_size = row.size-1
    0.upto(column_size) do |i|
      rts += "#{row[i]},"
    end
    res +=  "#{rts} \n"
  end
  res
end

# 写文件
# file_name = "/Users/chenwei/Library/Logs/tmp/75670089.csv"
def write_csv_file(file, data)
  File.open(file,"w+:utf-8") do |f|
    f.puts data
    f.close
  end
end

def read_and_write_xlsx_file(file, file_name)
  data = read_xlsx_excel(file)
  csv_file = "#{@output_csv_dir}/#{file_name}.csv"
  write_csv_file(csv_file, data)
end

def read_and_write_xls_excel(file, file_name)
  data = read_xls_excel(file)
  csv_file = "#{@output_csv_dir}/#{file_name}.csv"
  write_csv_file(csv_file, data)
end


i=0
Dir.foreach(@excel_dir) do |file|
  file_name = file.split('.').first
  file_path = "#{@excel_dir}/#{file}"

  if file !="." and file != ".." and file != ".DS_Store" and !File.directory?(file_path)
    i = i+ 1
    p "[#{i}] ... 处理文件 #{file}"
    #验证文件格式
    file_extend_name = file.split('.').last
    case file_extend_name
    when "xls"
      xls = true
    when "xlsx"
      xlsx = true
    else
      xls = xlsx = false
    end

    #根据不同格式分别处理，并转换为csv文件
    if xls
      read_and_write_xls_excel(file_path, file_name)
      puts "生成第#{i}个csv文件完毕！"

    elsif xlsx
      read_and_write_xlsx_file(file_path, file_name)
      puts "生成第#{i}个csv文件完毕！"
    end
  end
end
