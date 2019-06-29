 #!/usr/bin/python
#coding = utf-8
import os, sys

cmd ="ssh "+ sys.argv[1]  +" nvidia-smi -q | grep 'Gpu' | cut -d ':'  -f 2|awk '{print $1}'"
output = os.popen(cmd)
res = output.read()
#print(res)
gpu_arr = res.split("\n")
#print(gpu_arr)
i = 0
list=[]
for usage in gpu_arr:
 i =i+1
 #print(usage)
 if usage == '0':
  #print(i)
  list.append(i)

print(list)
