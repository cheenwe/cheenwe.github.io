#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  author      : chenwei
#  description : 判断磁盘使用率,超过阈值部分发送到监控服务器
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

current_file_path="/Users/chenwei/workspace/project/autohome/tmp/photos"



function changeName(){
  sed '6d;27,81d;86,136d'  $1 > file.copy
  mv file.copy $1
}

for shname in `ls $current_file_path`

do

  flist=`ls  $current_file_path/$shname`
    #echo $flist
    for f in $flist
    do
      echo $current_file_path/$shname/$f

      changeName $current_file_path/$shname/$f
    done

done



current_file_path="/home/chenwei/project/sc/app/views/ui"


# 删除第一行到第326行

function changeName(){
  sed '1,326d'  $1 > file.copy
  mv file.copy $1
}

for shname in `ls $current_file_path`

do
  flist=`ls  $current_file_path/$shname`
    #echo $flist
    echo $current_file_path/$shname

    changeName $current_file_path/$shname
done




current_file_path="/home/chenwei/project/sc/app/views/ui"

"<footer class"

# 删除第一行到第326行

function changeName(){
myfile=/home/chenwei/project/sc/app/views/ui/test.html
num=33
max=`sed -n '$=' $myfile`
let sLine=$max-$num+1
sed -i $sLine',$d' $myfile

# sss="'"$sLine,$max"d'"
# sh=echo "sed  $sss $myfile > file.copy"
# mv file.copy $myfile

# #从起始行删除到最后行bai

#   # mv file.copy $1
}

for shname in `ls $current_file_path`

do
  flist=`ls  $current_file_path/$shname`
    #echo $flist
    echo $current_file_path/$shname

    changeName $current_file_path/$shname

done





## 删除最后几行
myfile=test.1
num=3 #要删除的行数bai 
max=`sed -n '$=' $myfile` 
let sLine=max-num+1 #删除的起始zhi行 
sed -i $sLine',$d' $myfile #从起始行删除到最后行dao





#!/bin/bash

function changeName(){
  myfile=$1
  num=33
  max=`sed -n '$=' $1`
  let sLine=$max-$num

  sss="'"$sLine,"dd'"
  echo "sed -i  $sss $myfile "
}

current_file_path="/home/chenwei/project/sc/app/views/ui/docs"

for shname in `ls $current_file_path`

do
  flist=`ls  $current_file_path/$shname`
    #echo $flist
    # echo $current_file_path/$shname

    changeName $current_file_path/$shname

done
