#!/bin/bash

#sql文件路径
dir=/data_1/bigdata/sql/

for file in `ls $dir*.sql`; do
    #sql文件名
    file_name=${file#*/sql/}
    echo "====== start: "$file_name
    cd $dir
    #删除1-120行并保存为新的copy文件
    sed '1,120d' $file > "${file_name}".copy

    #======== 第二段要删除内容的关键词
    str="DROP TABLE IF EXISTS"
    #根据关键词找出所在行数即起始行
    del_start_num=`grep -n "${str}" "${file_name}".copy | cut -d ":" -f 1`
    #根据起始行计算出结束行
    let del_end=$del_start_num+17
    let del_start=$del_start_num-32
    #   echo $del_end_num

    #删除行
    sed  "${del_start},${del_end}d" "${file_name}".copy  > "${file_name}".copy1  

    #======== 第3段要删除内容的关键词

    str="SET TIME_ZONE=@OLD_TIME_ZONE"
    #根据关键词找出所在行数即起始行
    del_start_num=`grep -n "${str}" "${file_name}".copy1 | cut -d ":" -f 1`
    #根据起始行计算出结束行
    let del_end=$del_start_num+10
    let del_start=$del_start_num
    # echo $del_start

    #   #删除行
    sed  "${del_start},${del_end}d" "${file_name}".copy1 > "${file_name}"

    rm -rf "${file_name}.copy"
    rm -rf "${file_name}.copy1"
    echo "====== === success === ======"

done

cat *.sql >all.sql