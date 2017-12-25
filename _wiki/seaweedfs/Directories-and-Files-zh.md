## 介绍

When talking about file systems, many people would assume directories, list files under a directory, etc. These are expected if we want to hook up SeaweedFS with linux by FUSE, or with Hadoop, etc.

在谈论文件系统的时候，很多人会想到查看目录和目录下的文件等。如果我们希望用FUSE或者Hadoop等来连接SeaweedFS和linux。

### 使用示例

Two ways to start a weed filer
两种方式使用 weed filer

```bash
# assuming you already started weed master and weed volume
# 如果已经存在  weed master 和 weed volume
weed filer

# Or assuming you have nothing started yet,
# this command starts master server, volume server, and filer in one shot.
# It's strictly the same as starting them separately.

# 或者还没有开始 Weed
# 此命令一次启动主服务器，卷服务器和文件管理器。
# 和单独启动完全一样。
weed server -filer=true
```

Now you can add/delete files, and even browse the sub directories and files
现在你可以添加/删除文件,甚至浏览子目录和文件.

```bash
# 文件上传和读取
curl -F "filename=@README.md" "http://localhost:8888/path/to/sources/"
curl "http://localhost:8888/path/to/sources/README.md"

# 上传新文件和读取
curl -F "filename=@Makefile" "http://localhost:8888/path/to/sources/new_name"
curl "http://localhost:8888/path/to/sources/new_name"

# 列出子文件夹内文件列表
curl "http://localhost:8888/path/to/sources/?pretty=y"

# 如果文件夹有大量的文件,通过分页和查询展示
curl "http://localhost:8888/path/to/sources/?lastFileName=abc.txt&limit=50&pretty=y"
```

`缺陷`: 多次往一个目录上传一个文件, 目录下文件个数只有一个, 但是在不同的卷上会出现多个记录, 造成空间的浪费.


### 设计

A common file system would use inode to store meta data for each folder and file. The folder tree structure are usually linked. And sub folders and files are usually organized as an on-disk b+tree or similar variations. This scales well in terms of storage, but not well for fast file retrieval due to multiple disk access just for the file meta data, before even trying to get the file content.

一个通用的文件系统将使用inode为每个文件夹和文件存储元数据。 文件夹树结构通常是链接的。 子文件夹和文件通常以磁盘b +树或类似的变化形式组织。 就存储而言，这可以很好地扩展，但是，即使是在获取文件内容之前，由于对文件元数据的多个磁盘访问而进行的快速文件检索也不是很好。


SeaweedFS wants to make as small number of disk access as possible, yet still be able to store a lot of file metadata. So we need to think very differently.

SeaweedFS希望尽可能少的磁盘访问，但仍然能够存储大量的文件元数据。 所以我们需要非常不同的想法。

We can take the following steps to map a full file path to the actual data block:

我们可以采取以下步骤将完整的文件路径映射到实际的数据块：

1. file_parent_directory => directory_id
2. directory_id+fileName => file_id
3. file_id => data_block

Because default SeaweedFS only provides file_id=>data_block mapping, only the first 2 steps need to be implemented.

由于默认的SeaweedFS只提供file_id => data_block映射，所以只需要执行前两个步骤。

There are several data features I noticed:
有几个我注意到的数据特征：

1. the number of directories usually is small, or very small
2. the number of files can be small, medium, large, or very large

1.目录的数量通常很小，或者很小
2.文件的数量可以是小，中，大或非常大

This leads to a novel (as far as I know now) approach to organize the meta data for the directories and files separately.

这导致了一种新颖的（就我所知现在）来分别组织目录和文件的元数据。

A "weed filer" server is to provide these two missing parent_directory=>directory_id, and directory_id+filename=>file_id mappings, completing the "common" file storage interface.

“weed filer”服务器将提供这两个缺少的parent_directory => directory_id和directory_id + filename => file_id映射，从而完成“通用”文件存储界面。

#### Assumptions
####假设

I believe these are reasonable assumptions:
我相信这是合理的假设：

1. The number of directories are smaller than the number of files by one or more magnitudes.
1.目录数量比文件数量少一个或多个数量级。

2. Very likely for big systems, the number of files under one particular directory can be very high, ideally unlimited, far exceeding the number of directories.
2.很有可能对于大型系统来说，一个特定目录下的文件数量可能非常高，理想情况下是无限的，远远超过目录数量。

3. Directory meta data is accessed very often.
3.目录元数据经常被访问。

#### Data Structure
####  数据结构

This assumed differences between directories and files lead to the design that the metadata for directories and files should have different data structure.

假定目录和文件之间的差异导致目录和文件的元数据应该具有不同的数据结构。

1. Store directories in memory
    1. all of directories hopefully all be in memory
    2. efficient to move/rename/list_directories
2. Store files in a sorted string table in <dir_id/filename, file_id> format
    1. efficient to list_files, just simple iterator
    2. efficient to locate files, binary search


1.将目录存储在内存中
     1.所有的目录希望都在内存中
     2.高效地 移动/重命名/显示目录
2.以<dir_id / filename，file_id>格式将文件存储在已排序的字符串表中
     1.有效的list_files，只是简单的迭代器
     2.高效查找文件，二进制搜索

#### Complexity
#### 复杂

For one file retrieval, if the parent directory includes n folders, then it will take n steps to navigate from root to the file folder. However, this O(n) step is all in memory. So in practice, it will be very fast.

对于一个文件检索，如果父目录包含n个文件夹，则需要n个步骤从根目录导航到文件夹。 但是，这个O（n）步骤全部在内存中。 所以在实践中，这将是非常快的。

For one file retrieval, the dir_id+filename=>file_id lookup will be O(logN) using LevelDB, a log-structured-merge (LSM) tree implementation. The complexity is the same as B-Tree.

对于一个文件检索，dir_id + filename => file_id查找将使用LevelDB（日志结构合并（LSM）树实现）的O（logN）。 复杂性与B-Tree相同。

For file listing under a particular directory, the listing in LevelDB is just a simple scan, since the record in LevelDB is already sorted. For B-Tree, this may involves multiple disk seeks to jump through.

对于特定目录下的文件列表，LevelDB中的列表只是一个简单的扫描，因为LevelDB中的记录已经排序。 对于B-Tree来说，这可能涉及多个磁盘寻道。

For directory renaming, it's just trivially change the name or parent of the directory. Since the directory_id stays the same, there are no change to files metadata.

对于目录重命名，只是简单地更改目录的名称或父目录。 由于directory_id保持不变，所以文件元数据没有改变。

For file renaming, it's just trivially delete and then add a row in leveldb.

对于文件重命名，只是简单地删除，然后在leveldb中添加一行。

### Details
### 细节

In the current first version, the path_to_file=>file_id mapping is stored with an efficient embedded leveldb. Being embedded, it runs on single machine. So it's not linearly scalable yet. However, it can handle LOTS AND LOTS of files on SeaweedFS on other master/volume servers.

在当前的第一个版本中，path_to_file => file_id映射与高效的嵌入leveldb一起存储。 嵌入式，它在单机上运行。 所以它不是线性可扩展的。 但是，它可以在其他主/卷服务器上处理SeaweedFS上的大量文件。

Switching from the embedded leveldb to an external distributed database is very feasible. Your contribution is welcome!

从嵌入式leveldb切换到外部分布式数据库是非常可行的。 你的贡献是值得欢迎的

The in-memory directory structure can improve on memory efficiency. Current simple map in memory works when the number of directories is less than 1 million, which will use about 500MB memory. But I would expect common use case would have a few, not even more than 100 directories.

内存中的目录结构可以提高内存效率。 目前内存中的简单映射工作在目录数约100万时，使用约500MB的内存。 但是通常情况下目录个数会更少，甚至不超过100个目录。

### Use Cases
### 用例
Clients can assess one "weed filer" via HTTP, list files under a directory, create files via HTTP POST, read files via HTTP POST directly.

客户端可以通过HTTP评估一个“weed filer”，列出目录下的文件，通过HTTP POST创建文件，直接通过HTTP POST读取文件。

Although one "weed filer" can only sits in one machine, you can start multiple "weed filer" on several machines, each "weed filer" instance running in its own collection, having its own namespace, but sharing the same SeaweedFS storage.

虽然一个“weed filer”只能放在一台机器上，但是你可以在多台机器上启动多个“weed filer”，每个“weed filer”实例运行在自己的集合中，拥有自己的名字空间，但共享相同的SeaweedFS存储。

### Mount as FUSE
###挂载为FUSE

This uses bazil.org/fuse, which enables writing FUSE file systems on Linux and OS X. On OS X, it requires OSXFUSE (http://osxfuse.github.com/).

这使用 azil.org/fuse，它可以在Linux和OS X上编写FUSE文件系统。在OS X上，它需要OSXFUSE（http://osxfuse.github.com/）。

```bash
# assuming you already started weed master, weed volume and filer
weed mount -filer=localhost:8888 -dir=/some/existing/dir
```

Now you can browse/delete directories and files, and read file as in local file system. For efficiency, only no more than 100 sub directories and files under the same directory will be listed. To unmount, just shut it down.

现在，您可以浏览/删除目录和文件，并像在本地文件系统中一样读取文件。 为了提高效率，同一目录下只能有不超过100个子目录和文件。 要卸载，只需关闭它。

### Future
### 未来

Later, FUSE or HCFS plugins will be created, to really integrate SeaweedFS to existing systems.

为了，FUSE或HCFS插件将被创建，真正将SeaweedFS集成到现有的系统中。

### Helps Wanted
### 帮助通缉

This is a big step towards more interesting SeaweedFS usage and integration with existing systems.

这是更有趣的SeaweedFS使用和与现有系统集成的一大步。

Help on FUSE is needed.

需要FUSE帮助。