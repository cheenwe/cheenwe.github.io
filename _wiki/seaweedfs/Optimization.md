Here are the strategies or best ways to optimize SeaweedFS.

## Preallocate volume file disk spaces

In some Linux file system, e.g., XFS, ext4, Btrfs, etc, SeaweedFS can optionally allocate disk space for the volume files. This ensures file data is on contiguous blocks, which can improve performance when files are large and may cover multiple extents. 

To enable disk space preallcation, start the master with these options on a Linux OS with supporting file system.
```
  -volumePreallocate
    	Preallocate disk space for volumes.
  -volumeSizeLimitMB uint
    	Master stops directing writes to oversized volumes. (default 30000)
```

## Increase concurrent writes

By default, SeaweedFS grows the volumes automatically. For example, for no-replication volumes, there will be concurrently 7 writable volumes allocated.

If you want to distribute writes to more volumes, you can do so by instructing SeaweedFS master via this URL.

```bash	
curl http://localhost:9333/vol/grow?count=12&replication=001
```

This will assign 12 volumes with 001 replication. Since 001 replication means 2 copies for the same data, this will actually consumes 24 physical volumes.

## Increase concurrent reads

Same as above, more volumes will increase read concurrency.

In addition, increase the replication will also help. Having the same data stored on multiple servers will surely increase read concurrency.

## Add more hard drives

More hard drives will give you better write/read throughput.

## Increase user open file limit

The SeaweedFS usually only open a few actual disk files. But the network file requests may exceed the default limit, usually default to 1024. For production, you will need root permission to increase the limit to something higher, e.g., "ulimit -n 10240".

## Gzip content

SeaweedFS determines the file can be gzipped based on the file name extension. So if you submit a textual file, it's better to use an common file name extension, like ".txt", ".html", ".js", ".css", etc. If the name is unknown, like ".go", SeaweedFS will not gzip the content, but just save the content as is.

You can also manually gzip content before submission. If you do so, make sure the submitted file has file name with ends with ".gz". For example, "my.css" can be gzipped to "my.css.gz" and sent to SeaweedFS. When retrieving the content, if the http client supports "gzip" encoding, the gzipped content would be sent back. Otherwise, the unzipped content would be sent back.

## Memory consumption

For volume servers, the memory consumption is tightly related to the number of files. For example, one 32G volume can easily have 1.5 million files if each file is only 20KB. To store the 1.5 million entries of meta data in memory, currently SeaweedFS consumes 36MB memory, about 24bytes per entry in memory. So if you allocate 64 volumes(2TB), you would need 2~3GB memory. However, if the average file size is larger, say 200KB, only 200~300MB memory is needed.

SeaweedFS also has leveldb, boltdb, and btree mode support, which reduces memory consumption even more.

To use it, "weed server -volume.index=[memory|leveldb|boltdb|btree]", or "weed volume -index=[memory|leveldb|boltdb|btree]". You can switch between the 4 modes any time, as often as possible. If the files for leveldb or boltdb is outdated or missing, they will be re-generated as needed.

boltdb is fairly slow to write, about 6 minutes for recreating index for 1553934 files. Boltdb loads 1,553,934 x 16 = 24,862,944bytes from disk, and generate the boltdb as large as 134,217,728 bytes in 6 minutes.
To compare, leveldb recreates index as large as 27,188,148 bytes in 8 seconds.

To test the memory consumption, the leveldb or boltdb index are created. There are 7 volumes in benchmark collection, each with about 1553K files. The server is restarted, then I start the benchmark tool to read lots of files.
For leveldb, server memory starts at 142,884KB, and stays at 179,340KB.
For boltdb, server memory starts at 73,756KB, and stays at 144,564KB.
For in-memory, server memory starts at 368,152KB, and stays at 448,032KB.

To test the write speed, I use the benchmark tool with default parameters.
For boltdb, the write is about 4.1MB/s, 4.1K files/s
For leveldb, the writes is about 10.4MB/s, 10.4K files/s
For in-memory, it is a tiny bit faster, not statistically different. But I am using SSD, and os buffer cache also affect the numbers. So your results may be different.

Btree mode is added in v0.75, to optimize memory for out-of-order customized file key. Btree mode can cost more memory for normal file key assigned by SeaweedFS master, but are usually more efficient than customized file key. Please test for your cases.

Note: BoltDB has a limit that the max db size is 256MB on 32bit systems.

## Insert with your own keys

The file id generation is actually pretty trivial and you could use your own way to generate the file keys.

A file key has 3 parts:

- volume id: a volume with free spaces
- file id: a monotonously increasing and unique number
- file cookie: a random number, you can customize it in whichever way you want

You can directly ask master server to assign a file key, and replace the file id part to your own unique id, e.g., user id.

Also you can get each volume's free space from the server status.

```bash
curl "http://localhost:9333/dir/status?pretty=y"
```

Once you are sure about the volume free spaces, you can use your own file ids. Just need to ensure the file key format is compatible.

The assigned file cookie can also be customized.

Customizing the file id and/or file cookie is an acceptable behavior. "strict monotonously increasing" is not necessary, but keeping file id in a "mostly" increasing order is expected in order to keep the in memory data structure efficient.

## Upload large files

If files are large and network is slow, the server will take time to read the file. Please increase the "-readTimeout=3" limit setting for volume server. It cut off the connection if uploading takes a longer time than the limit.

### Upload large files with Auto Split/Merge

If the file is large, it's better to upload this way:

```bash
weed upload -maxMB=64 the_file_name
```

This will split the file into data chunks of 64MB each, and upload them separately. The file ids of all the data chunks are saved into an additional meta chunk. The meta chunk's file id are returned.

When downloading the file, just

```bash
weed download the_meta_chunk_file_id
```

The meta chunk has the list of file ids, with each file id on each line. So if you want to process them in parallel, you can download the meta chunk and deal with each data chunk directly.

### Collection as a Simple Name Space

When assigning file ids,

```bash
curl http://master:9333/dir/assign?collection=pictures
curl http://master:9333/dir/assign?collection=documents
```

will also generate a "pictures" collection and a "documents" collection if they are not created already. Each collection will have its dedicated volumes, and they will not share the same volume.

Actually, the actual data files have the collection name as the prefix, e.g., "pictures_1.dat", "documents_3.dat".

In case you need to delete them later, you can go to the volume servers and delete the data files directly, for now. Later maybe a deleteCollection command may be implemented, if someone asks...

## Logging

When going to production, you will want to collect the logs. SeaweedFS uses glog. Here are some examples:

```bash
weed -v=2 master
weed -log_dir=. volume
```