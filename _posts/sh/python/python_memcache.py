# python 读写  memcached

## 安装

```
sudo apt install memcached
pip install pymemcache
```


## 示例

```
from pymemcache.client.base import Client

client = Client(('localhost', 11211))

client.set('some_key', 'some_value')
result = client.get('some_key')

```
