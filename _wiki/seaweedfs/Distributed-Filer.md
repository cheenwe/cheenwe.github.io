The default weed filer is in standalone mode, storing file metadata on disk.
It is quite efficient to go through deep directory path and can handle
millions of files.

However, no SPOF is a must-have requirement for many projects.

Luckily, SeaweedFS is so flexible that we can use a completely different way
to manage file metadata.

This distributed filer uses Redis or Cassandra to store the metadata.

## Redis Setup

No setup required.

## Cassandra Setup

Here is the CQL to create the table.CassandraStore.
Optionally you can adjust the keyspace name and replication settings.
For production, you would want to set replication_factor to 3
if there are at least 3 Cassandra servers.

```cql
create keyspace seaweed WITH replication = {
  'class':'SimpleStrategy',
  'replication_factor':1
};

use seaweed;

CREATE TABLE seaweed_files (
   path varchar,
   fids list<varchar>,
   PRIMARY KEY (path)
);
```

## Sample usage

To start a weed filer in distributed mode with Redis:

```bash
# assuming you already started weed master and weed volume
weed filer -redis.server=localhost:6379
```

To start a weed filer in distributed mode with Cassandra:

```bash
# assuming you already started weed master and weed volume
weed filer -cassandra.server=localhost
```

Now you can add/delete files

```bash
# POST a file and read it back
curl -F "filename=@README.md" "http://localhost:8888/path/to/sources/"
curl "http://localhost:8888/path/to/sources/README.md"
# POST a file with a new name and read it back
curl -F "filename=@Makefile" "http://localhost:8888/path/to/sources/new_name"
curl "http://localhost:8888/path/to/sources/new_name"
```

## Limitation

List sub folders and files are not supported because Redis or Cassandra
does not support prefix search.

## Flat Namespace Design

Instead of using both directory and file metadata, this implementation uses
a flat namespace.

If storing each directory metadata separately, there would be multiple
network round trips to fetch directory information for deep directories,
impeding system performance.

A flat namespace would take more space because the parent directories are
repeatedly stored. But disk space is a lesser concern especially for
distributed systems.

So either Redis or Cassandra is a simple file_full_path ~ file_id mapping.
(Actually Cassandra is a file_full_path ~ list_of_file_ids mapping
with the hope to support easy file appending for streaming files.)

## Complexity

For one file retrieval, the full_filename=>file_id lookup will be O(logN)
using Redis or Cassandra. But very likely the one additional network hop would
take longer than the actual lookup.

## Deployment Notes

Replication is controlled by the client side. The filer's default replication is "000". To enable it, start filer with similar option like this:

```bash
  -defaultReplicaPlacement=001
```

The same setting on master server would not take effect since filer will always use the specified or filer's default replication to write.

## Use Cases

Clients can assess one "weed filer" via HTTP, create files via HTTP POST,
read files via HTTP POST directly.

## Future

SeaweedFS can support other distributed databases. It will be better
if that database can support prefix search, in order to list files
under a directory.

## Helps Wanted

Please implement your preferred metadata store!

Just follow the cassandra_store/cassandra_store.go file and send me a pull
request. I will handle the rest.