## Introduction

When talking about file systems, many people would assume directories, list files under a directory, etc. These are expected if we want to hook up SeaweedFS with linux by FUSE, or with Hadoop, etc.

### Sample usage

Two ways to start a weed filer

```bash
# assuming you already started weed master and weed volume
weed filer

# Or assuming you have nothing started yet,
# this command starts master server, volume server, and filer in one shot. 
# It's strictly the same as starting them separately.
weed server -filer=true
```

Now you can add/delete files, and even browse the sub directories and files

```bash
# POST a file and read it back
curl -F "filename=@README.md" "http://localhost:8888/path/to/sources/"
curl "http://localhost:8888/path/to/sources/README.md"

# POST a file with a new name and read it back
curl -F "filename=@Makefile" "http://localhost:8888/path/to/sources/new_name"
curl "http://localhost:8888/path/to/sources/new_name"

# list sub folders and files
curl "http://localhost:8888/path/to/sources/?pretty=y"

# if lots of files under this folder, here is a way to efficiently paginate through all of them
curl "http://localhost:8888/path/to/sources/?lastFileName=abc.txt&limit=50&pretty=y"
```

### Design

A common file system would use inode to store meta data for each folder and file. The folder tree structure are usually linked. And sub folders and files are usually organized as an on-disk b+tree or similar variations. This scales well in terms of storage, but not well for fast file retrieval due to multiple disk access just for the file meta data, before even trying to get the file content.

SeaweedFS wants to make as small number of disk access as possible, yet still be able to store a lot of file metadata. So we need to think very differently.

We can take the following steps to map a full file path to the actual data block:

1. file_parent_directory => directory_id
2. directory_id+fileName => file_id
3. file_id => data_block

Because default SeaweedFS only provides file_id=>data_block mapping, only the first 2 steps need to be implemented.

There are several data features I noticed:

1. the number of directories usually is small, or very small
2. the number of files can be small, medium, large, or very large

This leads to a novel (as far as I know now) approach to organize the meta data for the directories and files separately.

A "weed filer" server is to provide these two missing parent_directory=>directory_id, and directory_id+filename=>file_id mappings, completing the "common" file storage interface.

#### Assumptions

I believe these are reasonable assumptions:

1. The number of directories are smaller than the number of files by one or more magnitudes.
2. Very likely for big systems, the number of files under one particular directory can be very high, ideally unlimited, far exceeding the number of directories.
3. Directory meta data is accessed very often.

#### Data Structure

This assumed differences between directories and files lead to the design that the metadata for directories and files should have different data structure.

1. Store directories in memory
    1. all of directories hopefully all be in memory
    2. efficient to move/rename/list_directories
2. Store files in a sorted string table in <dir_id/filename, file_id> format
    1. efficient to list_files, just simple iterator
    2. efficient to locate files, binary search

#### Complexity

For one file retrieval, if the parent directory includes n folders, then it will take n steps to navigate from root to the file folder. However, this O(n) step is all in memory. So in practice, it will be very fast.

For one file retrieval, the dir_id+filename=>file_id lookup will be O(logN) using LevelDB, a log-structured-merge (LSM) tree implementation. The complexity is the same as B-Tree.

For file listing under a particular directory, the listing in LevelDB is just a simple scan, since the record in LevelDB is already sorted. For B-Tree, this may involves multiple disk seeks to jump through.

For directory renaming, it's just trivially change the name or parent of the directory. Since the directory_id stays the same, there are no change to files metadata.

For file renaming, it's just trivially delete and then add a row in leveldb.

### Details

In the current first version, the path_to_file=>file_id mapping is stored with an efficient embedded leveldb. Being embedded, it runs on single machine. So it's not linearly scalable yet. However, it can handle LOTS AND LOTS of files on SeaweedFS on other master/volume servers.

Switching from the embedded leveldb to an external distributed database is very feasible. Your contribution is welcome!

The in-memory directory structure can improve on memory efficiency. Current simple map in memory works when the number of directories is less than 1 million, which will use about 500MB memory. But I would expect common use case would have a few, not even more than 100 directories.

### Use Cases

Clients can assess one "weed filer" via HTTP, list files under a directory, create files via HTTP POST, read files via HTTP POST directly.

Although one "weed filer" can only sits in one machine, you can start multiple "weed filer" on several machines, each "weed filer" instance running in its own collection, having its own namespace, but sharing the same SeaweedFS storage.

### Mount as FUSE

This uses bazil.org/fuse, which enables writing FUSE file systems on Linux and OS X. On OS X, it requires OSXFUSE (http://osxfuse.github.com/).

```bash
# assuming you already started weed master, weed volume and filer
weed mount -filer=localhost:8888 -dir=/some/existing/dir
```

Now you can browse/delete directories and files, and read file as in local file system. For efficiency, only no more than 100 sub directories and files under the same directory will be listed. To unmount, just shut it down.

### Future

Later, FUSE or HCFS plugins will be created, to really integrate SeaweedFS to existing systems.

### Helps Wanted

This is a big step towards more interesting SeaweedFS usage and integration with existing systems.

Help on FUSE is needed.