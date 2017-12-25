Filer is similar to common file systems and people may ask for similar tools.

## Copy to Filer

`weed filer.copy` can copy one or a list of files or directories to filer.

```
// copy all go files under current directory to filer's /github/ folder.
// The directory structure is copied also.
> weed filer.copy -include *.go . http://localhost:8888/github/
...
Copy ./unmaintained/change_replication/change_replication.go => http://localhost:8888/github/./unmaintained/change_replication/change_replication.go
Copy ./unmaintained/fix_dat/fix_dat.go => http://localhost:8888/github/./unmaintained/fix_dat/fix_dat.go
Copy ./unmaintained/see_idx/see_idx.go => http://localhost:8888/github/./unmaintained/see_idx/see_idx.go
Copy ./weed/command/backup.go => http://localhost:8888/github/./weed/command/backup.go
Copy ./weed/command/benchmark.go => http://localhost:8888/github/./weed/command/benchmark.go
Copy ./weed/command/command.go => http://localhost:8888/github/./weed/command/command.go
Copy ./weed/command/compact.go => http://localhost:8888/github/./weed/command/compact.go
...
```

The above `weed copy` command is very efficient. It will contact the master server for a fileId, and submit the file content to volume servers, then just register the (path, fileId) pair on filer. Also, the file copying will also split large files into trunks automatically.

This put very little loads on filer and the master server. Data is only transmitted between the local machine and the volume server.

## Register a file on Filer

As mentioned above, the (path, fileId) can be registered on filer with this http operation.

```

curl --data "path=/path/to/your/file&fileId=3,01637037d6" http://localhost:8888/admin/register

```

## Move a Folder

Moving a folder is a very lightweight operation for embedded filer. Not implemented for flat namespace filer implementation since it is not efficient.

```
curl --data "from=/path/to/your/fileOrDir&to=/path/to/new/folder/" http://localhost:8888/admin/mv
curl --data "from=/path/to/your/fileOrDir&to=/path/to/new/file"    http://localhost:8888/admin/mv
```