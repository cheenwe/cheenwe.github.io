#!/bin/bash
# # # # # # # # BEGIN INIT INFO # # # # # # # # # # # # # #
#  copyright   : Copyright (c) 2019 cheenwe.
#  filename    : betch_zip_folder.sh
#  author      : chenwei
#  version     : 0.0.1
#  created     : 2019.12.24
#  description : 批量打包当前目录下指定日期的文件夹
#                   功能点: 日期格式化, 日期遍历, 读取键盘输入, 条件判断, 耗时统计等.
#
# # # # # # # # END INIT INFO # # # # # # # # # # # # # # #

####  你要设置日期的地方
date_start="2019-12-22" #开始时间
date_end="2019-12-24" #结束时间
####################

t_start=$(date +%s)
THIS="$0"
THIS_DIR=`dirname "$THIS"`
cd ${THIS_DIR}
beg_s=`date -d "$date_start" +%s`
end_s=`date -d "$date_end" +%s`

echo "处理时间范围：$date_start 至 $date_end"
#提示“请输入是否执行命令”并等待 10 秒，把用户的输入保存入变量val中
read -t 10 -p "请确认是否正确 Y/N:" val
echo $val

if [ "$val" = "y" ]||[ "$val" = "Y" ]; then
    while [ "$beg_s" -le "$end_s" ];do
        while_start=$(date +%s)
        day=`date -d @$beg_s +"%Y-%m-%d"`;
        echo "当前日期：$day"

        if [ -d ${day} ]; then
            echo "目录: $day 存在"
            tar -zcvf "$day.tar.gz" "./$day"
        else
            echo "目录: $day 不存在"
        fi
        while_end=$(date +%s)
        echo "====日期: $day 的数据处理完成!,  耗时:$(($while_end-$while_start)) seconds"
        beg_s=$((beg_s+86400));
    done
fi
t_end=$(date +%s)
echo "日期: $date_start ~ $date_end 的数据处理完成!,总耗时:$(($t_end-$t_start)) seconds"
