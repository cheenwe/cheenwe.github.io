# 1 region



env:

* 2 pc E5_2630@2.30GHz * 2
    * DELL_SAS2.5_600G * 2
    * RAID bus controller: LSI Logic / Symbios Logic MegaRAID SAS 2208 [Thunderbolt] (rev 05)
        * raid 10 
    * ext3
    * 128G mem
* run benchmark from 1pc 
* fio 顺序写 iops 18k `fio -filename=./a -direct=1 -iodepth 1 -thread -rw=write -ioengine=psync -bs=16k -size=1G -numjobs=30 -runtime=1000 -group_reporting -name=mytest`
* 随机写2k
* 添加preallocate，无优化。`I0708 08:14:27 29165 volume_create_linux.go:16] Preallocated 31457280000 bytes disk space for data/benchmark_2.dat`
* 启动命令 `./weed server -master.peers "10.64.7.106:9666,10.4.23.114:9666,10.4.23.115:9666"  -ip 10.4.23.114 -ip.bind 10.4.23.114  -master.port 9666 -dir ./data -volume.port 9555 -master.volumeSizeLimitMB 60000 -master.volumePreallocate`


测试命令

修改了源代码，保证每个master只有一个volume

`./weed benchmark -server 10.4.23.115:9666 -size 1000000 -n 40000`

测试结果:
```
This is SeaweedFS version 0.76 linux amd64

------------ Writing Benchmark ----------
Completed 984 of 40000 requests, 2.5% 983.8/s 938.2MB/s
Completed 2026 of 40000 requests, 5.1% 1042.2/s 993.9MB/s
Completed 2843 of 40000 requests, 7.1% 817.0/s 779.2MB/s
Completed 3916 of 40000 requests, 9.8% 1073.0/s 1023.3MB/s
Completed 4970 of 40000 requests, 12.4% 1054.0/s 1005.2MB/s
Completed 5998 of 40000 requests, 15.0% 1028.0/s 980.4MB/s
Completed 7042 of 40000 requests, 17.6% 1044.0/s 995.7MB/s
Completed 8037 of 40000 requests, 20.1% 995.0/s 948.9MB/s
Completed 9068 of 40000 requests, 22.7% 1031.0/s 983.3MB/s
Completed 10097 of 40000 requests, 25.2% 1029.0/s 981.4MB/s
Completed 11150 of 40000 requests, 27.9% 1053.0/s 1004.3MB/s
Completed 12201 of 40000 requests, 30.5% 1051.0/s 1002.3MB/s
Completed 13229 of 40000 requests, 33.1% 1028.0/s 980.4MB/s
Completed 14269 of 40000 requests, 35.7% 1040.0/s 991.8MB/s
Completed 15281 of 40000 requests, 38.2% 1012.0/s 965.2MB/s
Completed 16298 of 40000 requests, 40.7% 1017.0/s 969.9MB/s
Completed 17353 of 40000 requests, 43.4% 1055.0/s 1006.2MB/s
Completed 18353 of 40000 requests, 45.9% 1000.0/s 953.7MB/s
Completed 18995 of 40000 requests, 47.5% 642.0/s 612.3MB/s
Completed 19988 of 40000 requests, 50.0% 992.9/s 946.9MB/s
Completed 21031 of 40000 requests, 52.6% 1043.1/s 994.8MB/s
Completed 22083 of 40000 requests, 55.2% 1052.0/s 1003.3MB/s
Completed 23104 of 40000 requests, 57.8% 1021.0/s 973.7MB/s
Completed 24160 of 40000 requests, 60.4% 1056.0/s 1007.1MB/s
Completed 25176 of 40000 requests, 62.9% 1016.0/s 969.0MB/s
Completed 26198 of 40000 requests, 65.5% 1022.0/s 974.7MB/s
Completed 27270 of 40000 requests, 68.2% 1072.0/s 1022.4MB/s
Completed 28279 of 40000 requests, 70.7% 1009.0/s 962.3MB/s
Completed 28776 of 40000 requests, 71.9% 497.0/s 474.0MB/s
Completed 28776 of 40000 requests, 71.9% 0.0/s 0.0MB/s
Completed 28776 of 40000 requests, 71.9% 0.0/s 0.0MB/s
Completed 28776 of 40000 requests, 71.9% 0.0/s 0.0MB/s
Completed 28958 of 40000 requests, 72.4% 182.0/s 173.6MB/s
Completed 29457 of 40000 requests, 73.6% 499.0/s 475.9MB/s
Completed 29590 of 40000 requests, 74.0% 133.0/s 126.8MB/s
Completed 29702 of 40000 requests, 74.3% 112.0/s 106.8MB/s
Completed 29819 of 40000 requests, 74.5% 117.0/s 111.6MB/s
Completed 29936 of 40000 requests, 74.8% 117.0/s 111.6MB/s
Completed 30109 of 40000 requests, 75.3% 173.0/s 165.0MB/s
Completed 30250 of 40000 requests, 75.6% 141.0/s 134.5MB/s
Completed 30387 of 40000 requests, 76.0% 137.0/s 130.7MB/s
Completed 30483 of 40000 requests, 76.2% 96.0/s 91.6MB/s
Completed 30616 of 40000 requests, 76.5% 133.0/s 126.8MB/s
Completed 30718 of 40000 requests, 76.8% 102.0/s 97.3MB/s
Completed 30820 of 40000 requests, 77.0% 102.0/s 97.3MB/s
Completed 30967 of 40000 requests, 77.4% 147.0/s 140.2MB/s
Completed 31096 of 40000 requests, 77.7% 129.0/s 123.0MB/s
Completed 31223 of 40000 requests, 78.1% 127.0/s 121.1MB/s
Completed 31398 of 40000 requests, 78.5% 175.0/s 166.9MB/s
Completed 31505 of 40000 requests, 78.8% 107.0/s 102.0MB/s
Completed 31631 of 40000 requests, 79.1% 126.0/s 120.2MB/s
Completed 31736 of 40000 requests, 79.3% 105.0/s 100.1MB/s
Completed 31878 of 40000 requests, 79.7% 142.0/s 135.4MB/s
Completed 32033 of 40000 requests, 80.1% 155.0/s 147.8MB/s
Completed 32141 of 40000 requests, 80.4% 108.0/s 103.0MB/s
Completed 32289 of 40000 requests, 80.7% 148.0/s 141.2MB/s
Completed 32397 of 40000 requests, 81.0% 108.0/s 103.0MB/s
Completed 32546 of 40000 requests, 81.4% 149.0/s 142.1MB/s
Completed 32645 of 40000 requests, 81.6% 99.0/s 94.4MB/s
Completed 32776 of 40000 requests, 81.9% 131.0/s 124.9MB/s
Completed 32933 of 40000 requests, 82.3% 157.0/s 149.7MB/s
Completed 33029 of 40000 requests, 82.6% 96.0/s 91.6MB/s
Completed 33139 of 40000 requests, 82.8% 110.0/s 104.9MB/s
Completed 33292 of 40000 requests, 83.2% 153.0/s 145.9MB/s
Completed 33417 of 40000 requests, 83.5% 125.0/s 119.2MB/s
Completed 33540 of 40000 requests, 83.8% 123.0/s 117.3MB/s
Completed 33694 of 40000 requests, 84.2% 154.0/s 146.9MB/s
Completed 33850 of 40000 requests, 84.6% 156.0/s 148.8MB/s
Completed 34006 of 40000 requests, 85.0% 156.0/s 148.8MB/s
Completed 34176 of 40000 requests, 85.4% 170.0/s 162.1MB/s
Completed 34303 of 40000 requests, 85.8% 127.0/s 121.1MB/s
Completed 34491 of 40000 requests, 86.2% 188.0/s 179.3MB/s
Completed 34623 of 40000 requests, 86.6% 132.0/s 125.9MB/s
Completed 34818 of 40000 requests, 87.0% 195.0/s 186.0MB/s
Completed 34978 of 40000 requests, 87.4% 160.0/s 152.6MB/s
Completed 35141 of 40000 requests, 87.9% 163.0/s 155.4MB/s
Completed 35297 of 40000 requests, 88.2% 156.0/s 148.8MB/s
Completed 35430 of 40000 requests, 88.6% 133.0/s 126.8MB/s
Completed 35634 of 40000 requests, 89.1% 204.0/s 194.6MB/s
Completed 35757 of 40000 requests, 89.4% 123.0/s 117.3MB/s
Completed 35913 of 40000 requests, 89.8% 156.0/s 148.8MB/s
Completed 36042 of 40000 requests, 90.1% 129.0/s 123.0MB/s
Completed 36151 of 40000 requests, 90.4% 109.0/s 104.0MB/s
Completed 36299 of 40000 requests, 90.7% 148.0/s 141.1MB/s
Completed 36429 of 40000 requests, 91.1% 130.0/s 124.0MB/s
Completed 36549 of 40000 requests, 91.4% 120.0/s 114.4MB/s
Completed 36683 of 40000 requests, 91.7% 134.0/s 127.8MB/s
Completed 36769 of 40000 requests, 91.9% 86.0/s 82.0MB/s
Completed 36878 of 40000 requests, 92.2% 109.0/s 104.0MB/s
Completed 36983 of 40000 requests, 92.5% 105.0/s 100.1MB/s
Completed 37105 of 40000 requests, 92.8% 122.0/s 116.4MB/s
Completed 37242 of 40000 requests, 93.1% 137.0/s 130.6MB/s
Completed 37360 of 40000 requests, 93.4% 118.0/s 112.5MB/s
Completed 37500 of 40000 requests, 93.8% 140.0/s 133.5MB/s
Completed 37606 of 40000 requests, 94.0% 106.0/s 101.1MB/s
Completed 37742 of 40000 requests, 94.4% 136.0/s 129.7MB/s
Completed 37879 of 40000 requests, 94.7% 137.0/s 130.7MB/s
Completed 38010 of 40000 requests, 95.0% 131.0/s 124.9MB/s
Completed 38105 of 40000 requests, 95.3% 95.0/s 90.6MB/s
Completed 38198 of 40000 requests, 95.5% 93.0/s 88.7MB/s
Completed 38345 of 40000 requests, 95.9% 147.0/s 140.2MB/s
Completed 38457 of 40000 requests, 96.1% 112.0/s 106.8MB/s
Completed 38582 of 40000 requests, 96.5% 125.0/s 119.2MB/s
Completed 38697 of 40000 requests, 96.7% 115.0/s 109.7MB/s
Completed 38833 of 40000 requests, 97.1% 136.0/s 129.7MB/s
Completed 38921 of 40000 requests, 97.3% 88.0/s 83.9MB/s
Completed 38992 of 40000 requests, 97.5% 71.0/s 67.7MB/s
Completed 39057 of 40000 requests, 97.6% 65.0/s 62.0MB/s
Completed 39170 of 40000 requests, 97.9% 113.0/s 107.8MB/s
Completed 39263 of 40000 requests, 98.2% 93.0/s 88.7MB/s
Completed 39329 of 40000 requests, 98.3% 66.0/s 62.9MB/s
Completed 39400 of 40000 requests, 98.5% 71.0/s 67.7MB/s
Completed 39477 of 40000 requests, 98.7% 77.0/s 73.4MB/s
Completed 39584 of 40000 requests, 99.0% 107.0/s 102.0MB/s
Completed 39716 of 40000 requests, 99.3% 132.0/s 125.9MB/s
Completed 39796 of 40000 requests, 99.5% 80.0/s 76.3MB/s
Completed 39965 of 40000 requests, 99.9% 169.0/s 161.2MB/s

Concurrency Level:      16
Time taken for tests:   117.609 seconds
Complete requests:      40000
Failed requests:        0
Total transferred:      40001250749 bytes
Requests per second:    340.11 [#/sec]
Transfer rate:          332149.44 [Kbytes/sec]

Connection Times (ms)
              min      avg        max      std
Total:        7.0      47.0       4373.3      125.6

Percentage of the requests served within a certain time (ms)
   50%     14.8 ms
   66%     17.9 ms
   75%     20.0 ms
   80%     21.7 ms
   90%    150.4 ms
   95%    267.8 ms
   98%    366.6 ms
   99%    445.9 ms
  100%    4373.3 ms

------------ Randomly Reading Benchmark ----------
Completed 2228 of 40000 requests, 5.6% 2227.8/s 2124.7MB/s
Completed 4540 of 40000 requests, 11.3% 2312.0/s 2205.0MB/s
Completed 6790 of 40000 requests, 17.0% 2250.0/s 2145.8MB/s
Completed 9062 of 40000 requests, 22.7% 2272.0/s 2166.8MB/s
Completed 11370 of 40000 requests, 28.4% 2308.0/s 2201.1MB/s
Completed 13691 of 40000 requests, 34.2% 2321.0/s 2213.6MB/s
Completed 15972 of 40000 requests, 39.9% 2280.2/s 2174.6MB/s
Completed 18295 of 40000 requests, 45.7% 2323.6/s 2216.1MB/s
Completed 20611 of 40000 requests, 51.5% 2316.2/s 2209.0MB/s
Completed 22949 of 40000 requests, 57.4% 2338.0/s 2229.8MB/s
Completed 25243 of 40000 requests, 63.1% 2294.0/s 2187.8MB/s
Completed 27550 of 40000 requests, 68.9% 2307.0/s 2200.2MB/s
Completed 29881 of 40000 requests, 74.7% 2331.0/s 2223.1MB/s
Completed 32217 of 40000 requests, 80.5% 2336.0/s 2227.8MB/s
Completed 34514 of 40000 requests, 86.3% 2297.0/s 2190.7MB/s
Completed 36826 of 40000 requests, 92.1% 2311.9/s 2204.9MB/s
Completed 39189 of 40000 requests, 98.0% 2363.0/s 2253.6MB/s

Concurrency Level:      16
Time taken for tests:   17.349 seconds
Complete requests:      40000
Failed requests:        0
Total transferred:      40001249878 bytes
Requests per second:    2305.66 [#/sec]
Transfer rate:          2251686.93 [Kbytes/sec]

Connection Times (ms)
              min      avg        max      std
Total:        1.1      6.8       46.7      4.6

Percentage of the requests served within a certain time (ms)
   50%      5.6 ms
   66%      8.0 ms
   75%      9.7 ms
   80%     10.8 ms
   90%     13.4 ms
   95%     15.5 ms
   98%     18.2 ms
   99%     20.4 ms
  100%     46.7 ms
```

测试结束后，ioutil还是100，写iops还是很大，iotop如下

```
 be/4 root        0.00 B/s    0.00 B/s  0.00 % 99.99 % [flush-8:0]
  663 be/4 root        0.00 B/s    0.00 B/s  0.00 % 99.99 % [kjournald]
```



# 历史测试




#  `./weed benchmark -server 10.4.23.115:9666  -n 10000 -size 1000000 -c 100`

```
Concurrency Level:      100
Time taken for tests:   6.808 seconds
Complete requests:      10000
Failed requests:        0
Total transferred:      10000315338 bytes
Requests per second:    1468.89 [#/sec]
Transfer rate:          1434508.39 [Kbytes/sec]

Connection Times (ms)
              min      avg        max      std
Total:        7.5      67.6       730.1      66.6

Percentage of the requests served within a certain time (ms)
   50%     51.0 ms
   66%     72.0 ms
   75%     84.5 ms
   80%     93.2 ms
   90%    126.8 ms
   95%    208.6 ms
   98%    286.5 ms
   99%    345.1 ms
  100%    730.1 ms
```

 
# ./weed benchmark -server 10.4.23.115:9666  -n 10000 -size 1000000

```
Concurrency Level:      16
Time taken for tests:   8.523 seconds
Complete requests:      10000
Failed requests:        0
Total transferred:      10000317165 bytes
Requests per second:    1173.36 [#/sec]
Transfer rate:          1145892.52 [Kbytes/sec]

Connection Times (ms)
              min      avg        max      std
Total:        7.7      13.6       49.1      2.9

Percentage of the requests served within a certain time (ms)
   50%     13.2 ms
   66%     14.2 ms
   75%     14.9 ms
   80%     15.4 ms
   90%     17.0 ms
   95%     18.5 ms
   98%     20.6 ms
   99%     22.3 ms
  100%     49.1 ms
```


# 2 region

env:

* 3 pc E5_2630@2.30GHz * 2
    * DELL_SAS2.5_600G * 2
    * RAID bus controller: LSI Logic / Symbios Logic MegaRAID SAS 2208 [Thunderbolt] (rev 05)
        * raid 10 
    * 128G mem
    * 2 data region
* run benchmark from 1pc ( I have not got the 4)
* cmd`weed benchmark -server 10.64.7.106:9666 -size 1000000 -n 10000`  rep:000

write
```
Concurrency Level:      16
Time taken for tests:   141.200 seconds
Complete requests:      10000
Failed requests:        0
Total transferred:      10000313420 bytes
Requests per second:    70.82 [#/sec]
Transfer rate:          69163.65 [Kbytes/sec]

Connection Times (ms)
              min      avg        max      std
Total:        7.8      225.6       1986.8      207.2

Percentage of the requests served within a certain time (ms)
   50%    198.9 ms
   66%    281.8 ms
   75%    337.8 ms
   80%    367.9 ms
   90%    476.7 ms
   95%    588.3 ms
   98%    763.7 ms
   99%    892.9 ms
  100%    1986.8 ms
```

read 

```
Concurrency Level:      16
Time taken for tests:   59.509 seconds
Complete requests:      10000
Failed requests:        0
Total transferred:      10000311600 bytes
Requests per second:    168.04 [#/sec]
Transfer rate:          164107.92 [Kbytes/sec]

Connection Times (ms)
              min      avg        max      std
Total:        1.2      94.0       2507.3      152.9

Percentage of the requests served within a certain time (ms)
   50%     75.5 ms
   66%     90.7 ms
   75%     98.3 ms
   80%    102.9 ms
   90%    140.9 ms
   95%    344.9 ms
   98%    639.8 ms
   99%    834.7 ms
  100%    2507.3 ms
```


# conconrrent to 100

`weed benchmark -server 10.64.7.106:9666 -size 1000000 -n 10000 -c 100`

```
Concurrency Level:      100
Time taken for tests:   61.658 seconds
Complete requests:      10000
Failed requests:        0
Total transferred:      10000313519 bytes
Requests per second:    162.18 [#/sec]
Transfer rate:          158388.25 [Kbytes/sec]

Connection Times (ms)
              min      avg        max      std
Total:        8.0      606.1       3317.2      720.7
```



# 1k test

`weed benchmark -server 10.64.7.106:9666  -n 10000 -c 100`

```
------------ Writing Benchmark ----------
Completed 7574 of 10000 requests, 75.7% 7573.6/s 7.6MB/s

Concurrency Level:      100
Time taken for tests:   1.327 seconds
Complete requests:      10000
Failed requests:        0
Total transferred:      10552563 bytes
Requests per second:    7534.50 [#/sec]
Transfer rate:          7764.48 [Kbytes/sec]

Connection Times (ms)
              min      avg        max      std
Total:        0.3      13.0       329.9      14.8

Percentage of the requests served within a certain time (ms)
   50%      1.1 ms
   66%     27.7 ms
   75%     27.8 ms
   90%     28.2 ms
   95%     28.7 ms
   98%     29.6 ms
   99%     55.0 ms
  100%    329.9 ms
```