---
layout: post
title: 测试存储性能脚本
tags:     disk
category:   disk
---

使用 dd 命令测试存储性能

```
test_dir=/tmp/test/test666
rm $test_dir

time sudo dd if=/dev/zero bs=50G count=8 of=$test_dir iflag=fullblock
rm $test_dir
sleep 5
time sudo dd if=/dev/zero bs=8G count=50 of=$test_dir iflag=fullblock
rm $test_dir
sleep 5
time sudo dd if=/dev/zero bs=2G count=200 of=$test_dir iflag=fullblock
rm $test_dir
sleep 5
time sudo dd if=/dev/zero bs=500M count=100 of=$test_dir iflag=fullblock
rm $test_dir
sleep 5
time sudo dd if=/dev/zero bs=100M count=500 of=$test_dir iflag=fullblock
rm $test_dir
sleep 5
time sudo dd if=/dev/zero bs=10M count=5000 of=$test_dir iflag=fullblock
rm $test_dir
sleep 5
time sudo dd if=/dev/zero bs=3M count=17000 of=$test_dir iflag=fullblock
rm $test_dir
sleep 5
time sudo dd if=/dev/zero bs=1M count=50000 of=$test_dir iflag=fullblock
rm $test_dir
sleep 5
time sudo dd if=/dev/zero bs=500K count=100000 of=$test_dir iflag=fullblock
rm $test_dir
sleep 5
time sudo dd if=/dev/zero bs=50K count=1000000 of=$test_dir iflag=fullblock
rm $test_dir
sleep 5
time sudo dd if=/dev/zero bs=5K count=10000000 of=$test_dir iflag=fullblock
rm $test_dir 


``` 
