You can append to any HTTP API with &pretty=y to see a formatted json output.

## Volume Server

### Upload File

```bash
curl -F file=@/home/chris/myphoto.jpg http://127.0.0.1:8080/3,01637037d6
{"size": 43234}
```

The size returned is the size stored on SeaweedFS, sometimes the file is automatically gzipped based on the mime type.

### Upload File Directly

```bash
curl -F file=@/home/chris/myphoto.jpg http://localhost:9333/submit
{"fid":"3,01fbe0dc6f1f38","fileName":"myphoto.jpg","fileUrl":"localhost:8080/3,01fbe0dc6f1f38","size":68231}
```

This API is just for convenience. The master server would get an file id and store the file to the right volume server.
It is a convenient API and does not support different parameters when assigning file id. (or you can add the support and send a push request.)

### Delete File

```bash
curl -X DELETE http://127.0.0.1:8080/3,01637037d6
```

### View Manifest File Content for chunked big file

```bash
curl http://127.0.0.1:8080/3,01637037d6?cm=false
```
	
### Create а specific volume on a specific volume server

```bash
curl "http://localhost:8080/admin/assign_volume?replication=000&volume=3"
```

This generates volume 3 on this volume server.

If you use other replicationType, e.g. 001, you would need to do the same on other volume servers to create the mirroring volumes.

### Delete а volume

This API should be protected just in case someone delete your volumes!
It deletes the volume physically.

```bash
curl "http://localhost:8080/admin/volume/delete?volume=volumeId"
```

### Unmount/mount а volume

This API should be protected!

This deactivates a given volume. This is useful to process a volume stopping the volume server. Possible use cases are compaction, index recreation or moving the volume to another server. As soon as a volume is unmounted it won't be accessed by the volume any more and can be safely changed or moved away.

```bash
curl "http://localhost:8080/admin/volume/unmount?volume=volumeId"
```

The counterpart is to mount a volume. This adds a volume file to a volume server without the need to restart the volume server. A use case is to mount a previously unmounted volume again or to add a volume, that has been moved to another server to the new server.

```bash
curl "http://localhost:8080/admin/volume/mount?volume=volumeId"
```

### Delete а specific collection on a specific volume server

This API should be protected just in case someone delete your volumes!

```bash
curl "http://localhost:8080/admin/delete_collection?collection=some_collection_name."
```

### Check Volume Server Status

```bash
curl "http://localhost:8080/status?pretty=y"
{
  "Version": "0.34",
  "Volumes": [
    {
      "Id": 1,
      "Size": 1319688,
      "RepType": "000",
      "Version": 2,
      "FileCount": 276,
      "DeleteCount": 0,
      "DeletedByteCount": 0,
      "ReadOnly": false
    },
    {
      "Id": 2,
      "Size": 1040962,
      "RepType": "000",
      "Version": 2,
      "FileCount": 291,
      "DeleteCount": 0,
      "DeletedByteCount": 0,
      "ReadOnly": false
    },
    {
      "Id": 3,
      "Size": 1486334,
      "RepType": "000",
      "Version": 2,
      "FileCount": 301,
      "DeleteCount": 2,
      "DeletedByteCount": 0,
      "ReadOnly": false
    },
    {
      "Id": 4,
      "Size": 8953592,
      "RepType": "000",
      "Version": 2,
      "FileCount": 320,
      "DeleteCount": 2,
      "DeletedByteCount": 0,
      "ReadOnly": false
    },
    {
      "Id": 5,
      "Size": 70815851,
      "RepType": "000",
      "Version": 2,
      "FileCount": 309,
      "DeleteCount": 1,
      "DeletedByteCount": 0,
      "ReadOnly": false
    },
    {
      "Id": 6,
      "Size": 1483131,
      "RepType": "000",
      "Version": 2,
      "FileCount": 301,
      "DeleteCount": 1,
      "DeletedByteCount": 0,
      "ReadOnly": false
    },
    {
      "Id": 7,
      "Size": 46797832,
      "RepType": "000",
      "Version": 2,
      "FileCount": 292,
      "DeleteCount": 0,
      "DeletedByteCount": 0,
      "ReadOnly": false
    }
  ]
}
```

