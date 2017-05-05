#!/usr/bin/env bash

# # # # # # # # BEGIN INIT INFO # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2017 cheenwe.
#  filename    : deal_and_move_file.rb
#  author      : chenwei
#  version     : 0.0.1
#  created     : 2017.03.09
#  description : 处理数据脚本 (结合rails项目使用)
#                   文件读写、文件夹创建、文件复制
#  history     :
#               1. Date: 2017.05.05
#               Author:  cheenwe
#               Modification: 读取数据库中数据，把部分数据写入到txt中，图片等数据复制到新文件夹中
# # # # # # # # END INIT INFO # # # # # # # # # # # # # # #

  ROOT_DIST_PTH = "E:\\pic\\"
  ROOT_SRC_PTH = "E:\\公告数据\\pictures\\"

  def check_and_create_path(name)
    path = ROOT_DIST_PTH + name
    if File::exist?(path)
    else
      FileUtils.mkdir_p(path)# unless File.exists?(path)
    end
    return "#{path}"
  end

  def deal_record
    current_path = "#{self.车型类别}/#{self.big_pinpai}/#{self.产品型号}"
    out_path = check_and_create_path(current_path)
    f = open("#{out_path}/0.txt","w")
    f.puts txt_content
    f.close
    move_pic(out_path)

  end

  def had_no_category
    self.车型类别 == ""
  end

  def is_moto
    self.车辆名称.include?("摩托")
  end

  def self.run_all
    sn = 0
    Che.all.each do | che |
      sn += 1
      if che.is_moto
        puts "moto"
        logger.info "== #{sn} === this is moto =====  ID: #{che.CPNO} "
      elsif che.had_no_category
        puts "no category"

        logger.info "== #{sn} === had_no_category =====  ID: #{che.CPNO} "
      elsif !che.is_moto&&!che.had_no_category
        puts "success"
        che.deal_record # unless che.had_no_category
        logger.info "== #{sn} === success =====  ID: #{che.CPNO} "
      end
    end
  end

  def move_pic(out_path)
    src_path = "#{ROOT_SRC_PTH}#{self.批次}"
    old_file1 = "#{src_path}\\#{self.照片}.jpg"
    old_file2 = ("#{src_path}\\#{self.后部照片}.jpg" rescue '')
    old_file3 = ("#{src_path}\\#{self.照片1}.jpg"  rescue '')
    old_file4 = ("#{src_path}\\#{self.照片2}.jpg"  rescue '')
    old_file5 = ("#{src_path}\\#{self.照片3}.jpg"  rescue '')
    old_file6 = ("#{src_path}\\#{self.侧后防护}.jpg"  rescue '')
    cp_file(old_file1, "#{out_path}\\1.jpg")
    cp_file(old_file2, "#{out_path}\\2.jpg")
    cp_file(old_file3, "#{out_path}\\3.jpg")
    cp_file(old_file4, "#{out_path}\\4.jpg")
    cp_file(old_file5, "#{out_path}\\5.jpg")
    cp_file(old_file6, "#{out_path}\\6.jpg")
  end

  def cp_file(src, dist)
    FileUtils.cp(src, dist)  rescue ''
  end

  def txt_content
"ID: #{self.id}
产品商标: #{self.产品商标}
中文品牌: #{self.中文品牌}
企业名称: #{self.企业名称}
车型类别: #{self.车型类别}
车辆型号: #{self.车辆型号}
车辆名称: #{self.车辆名称}
产品型号: #{self.产品型号}
长: #{self.长}
宽: #{self.宽}
高: #{self.高}
货厢长: #{self.货厢长}
货厢宽: #{self.货厢宽}
货厢高: #{self.货厢高}
轮胎规格: #{self.轮胎规格}
识别代号: #{self.识别代号.to_s.gsub("\n"," ")}"
  end
