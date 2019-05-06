## how

1. install redis-server

sudo apt installl redis-server

2. install python redis 

pip3 install redis

3. run:  bash run.sh & 

4. run: python3 client.py


## redis error
 
 “Ready check failed: NOAUTH Authentication required”
 
 
 sudo nano /etc/redis/redis.conf
 
 find : requirepass
 
 and annotation this line
