SeaweedFS can support replication. The replication is implemented not on file level, but on volume level.

SeaweedFS 可以支持复制。 复制不是在文件级别上，而是在卷级别上实现的。

## How to use

Basically, the way it works is:

1. start weed master, and optionally specify the default replication type

1. 启动weed master，并可以指定默认的复制类型

   ```bash
   ./weed master -defaultReplication=001
   ```

2. start volume servers as this:
2. 启动卷服务器，如下所示：

   ```bash
   ./weed volume -port=8081 -dir=/tmp/1 -max=100 -mserver="master_address:9333" -dataCenter=dc1 -rack=rack1
   ./weed volume -port=8082 -dir=/tmp/2 -max=100 -mserver="master_address:9333" -dataCenter=dc1 -rack=rack1
   ```
On another rack,
   ```bash
   ./weed volume -port=8081 -dir=/tmp/1 -max=100 -mserver="master_address:9333" -dataCenter=dc1 -rack=rack2
   ./weed volume -port=8082 -dir=/tmp/2 -max=100 -mserver="master_address:9333" -dataCenter=dc1 -rack=rack2
   ```

No change to Submitting, Reading, and Deleting files.

## The meaning of replication type

## 复制类型的含义

*Note: This subject to change.*


##在特定数据中心分配文件密钥

现在，当请求一个文件密钥时，可选的“dataCenter”参数可以将分配的数量限制到特定的数据中心。例如，这个指定

Value | Meaning
---|---
000 | no replication, just one copy
001 | replicate once on the same rack
010 | replicate once on a different rack in the same data center
100 | replicate once on a different data center
200 | replicate twice on two other different data center
110 | replicate once on a different rack, and once on a different data center
... | ...


值|含义
--- | ---
000 |没有复制，只有一个副本
001 |在同一个机架上复制一次
010 |在同一个数据中心的不同机架上复制一次
100 |在不同的数据中心复制一次
200 |在另外两个不同的数据中心上复制两次
110 |在不同的机架上复制一次，并在不同的数据中心复制一次
... | ...

So if the replication type is xyz

Column | Meaning
---|---
**x** | number of replica in other data centers
**y** | number of replica in other racks in the same data center
**z** | number of replica in other servers in the same rack

x,y,z each can be 0, 1, or 2. So there are 9 possible replication types, and can be easily extended. 
Each replication type will physically create x+y+z+1 copies of volume data files.


所以如果复制类型是xyz

列|含义
--- | ---
** x ** |其他数据中心的副本数量
** y ** |同一数据中心其他机架中的副本数量
** z ** |同一机架中其他服务器的副本数量

x，y，z每个可以是0,1或2.所以有9种可能的复制类型，并且可以很容易地扩展。
每个复制类型将物理地创建卷数据文件的x + y + z + 1副本。

## Allocate File Key on specific data center
## 在特定数据中心分配文件密钥

Now when requesting a file key, an optional "dataCenter" parameter can limit the assigned volume to the specific data center. For example, this specify

现在，当请求一个文件密钥时，可选的“dataCenter”参数可以将分配的数量限制到特定的数据中心。

```bash
http://localhost:9333/dir/assign?dataCenter=dc1
```