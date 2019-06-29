#coding = utf-8
import os

output = os.popen('ls /tmp')
print(output.read())

