# 对爬取后文件按照 excel 进行批量重命名

require 'spreadsheet'
require 'fileutils'

root_path="/Users/chenwei/Desktop/code"

file="#{root_path}/names.xls"

old_folder="#{root_path}/name"

new_folder="#{root_path}/code_moved"


FileUtils.mkdir_p(new_folder)

book = Spreadsheet.open(file)
# sheet = book.worksheets
sheet1 = book.worksheet 0

sheet1.each_with_index do |row, index|
	current_file = "#{old_folder}/#{index+1}.csv"
	new_file = "#{new_folder}/#{index+1}.#{row[0]}.csv"
	FileUtils.cp(current_file, new_file)
end


