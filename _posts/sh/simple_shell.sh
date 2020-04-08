
$ cat /usr/local/bin/up
#!/bin/sh
#
# 简单文件上传
#
#
#地址配置
# URL=localhost:3006/f
URL=v.xx.cn:3005/f

#验证
auth='t=cw'

#上传文件
exec curl -F $auth -F file=@$1 $URL


$ cat /usr/local/bin/down
#!/bin/sh
#
# 简单文件下载
#
#
#地址配置
# URL=localhost:3006/f
URL= v.xx.cn:3005/file

#验证
auth='t=cw'

#请求地址
url=`curl -X GET -F $auth $URL/$1`

# 下载文件
curl -O $url


$ cat /usr/local/bin/sys

#!/bin/sh
#
# 简单文件同步
#
# usage: sys /tmp/1.txt host1

rsync  -avz --progress $1 $2:$1
