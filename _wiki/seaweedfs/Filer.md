This page aims to consolidate the pages on the [[single-node filer|Directories and Files]] and [[distributed filer]] into one.

## Background

SeaweedFS comes with a lightweight "filer" server, which provides a RESTful wrapper around SeaweedFS's arbitrary blob API, mapping content to a traditional file directory of paths.

## Backends

SeaweedFS's built-in filer supports three different backends (although pull requests to add more are always welcome).

The default backend, LevelDB, is for simple, non-distributed single nodes.

The other backends, Redis and Cassandra, are for clustering backing stores that can be distributed across several nodes at high scale.

The LevelDB backend is very capable and efficient; the main disadvantage it has, relative to the distributed backends, is that it presents a single point of failure. In "[pets vs. cattle][pvc]" terms, the LevelDB backend is only suitable for "pet" servers, while the Redis and Cassandra backends are suitable for "cattle" servers.

[pvc]: https://blog.engineyard.com/2014/pets-vs-cattle

## Initialization

The LevelDB and Redis backends need no initialization.

### Initializing the Cassandra backend

Here is the CQL to create the table used by SeaweedFS's Cassandra store, as well as a keyspace for specifying the replication strategy to use.

While the table name and field structure must match what is written here, you are free to rename the keyspace and use whatever replication settings you wish. For production, you would want to set replication_factor to 3
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

## Starting the Filer

To start the filer, after you have started the master and volume servers (with `weed server`, or `weed master` and `weed volume` respectively), you can start a filer server with `weed filer`, providing backing store location options to use the Redis or Cassandra backends:

```bash
# to use the default LevelDB backend:
weed filer

# to use the Redis backend:
weed filer -redis.server=localhost:6379

# to use the Cassandra backend:
weed filer -cassandra.server=localhost
```

Alternatively, to start all servers in one shot, you can start a filer server alongside a master server and volume server with the `-filer` option to `weed server`:

```
# this is equivalent to `weed master`, `weed volume`, and `weed filer` together
weed server -filer
```

## Using the Filer

The filer provides a simple RESTful interface, where POST requests to a path upload the file content for that path, and GET requests retrieve the content for that path.

```
# POST a file and read it back
curl -F "filename=@README.md" "http://localhost:8888/path/to/sources/"
curl "http://localhost:8888/path/to/sources/README.md"

# POST a file with a new name and read it back
curl -F "filename=@Makefile" "http://localhost:8888/path/to/sources/new_name"
curl "http://localhost:8888/path/to/sources/new_name"
```

You may also request a "listing" for a directory:

```
# list sub folders and files
curl "http://localhost:8888/path/to/sources/?pretty=y"

# if lots of files under this folder, here is a way to efficiently paginate through all of them
curl "http://localhost:8888/path/to/sources/?lastFileName=abc.txt&limit=50&pretty=y"
```

The Redis and Cassandra backends are currently implemented as ["flat namespace" stores](https://github.com/chrislusf/seaweedfs/blob/master/weed/filer/flat_namespace/flat_namespace_filer.go), so filers using them may not perform directory listings at this time.