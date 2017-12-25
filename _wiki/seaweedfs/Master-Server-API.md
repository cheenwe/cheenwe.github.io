## Master server

You can append to any HTTP API with &pretty=y to see a formatted json output.

### Assign a file key
This operation is very cheap. Just increase a number in master server's memory.

```bash
# Basic Usage:
curl http://localhost:9333/dir/assign
{"count":1,"fid":"3,01637037d6","url":"127.0.0.1:8080",
 "publicUrl":"localhost:8080"}
# To assign with a specific replication type:
curl "http://localhost:9333/dir/assign?replication=001"
# To specify how many file ids to reserve
curl "http://localhost:9333/dir/assign?count=5"
# To assign a specific data center
curl "http://localhost:9333/dir/assign?dataCenter=dc1"
```

### Lookup volume

We would need to find out whether the volumes have moved.

```bash
curl "http://localhost:9333/dir/lookup?volumeId=3&pretty=y"
{
  "locations": [
    {
      "publicUrl": "localhost:8080",
      "url": "localhost:8080"
    }
  ]
}
# Other usages:
# You can actually use the file id to lookup, if you are lazy to parse the file id.
curl "http://localhost:9333/dir/lookup?volumeId=3,01637037d6"
# If you know the collection, specify it since it will be a little faster
curl "http://localhost:9333/dir/lookup?volumeId=3&collection=turbo"
```

### Force garbage collection

If your system has many deletions, the deleted file's disk space will not be synchronously re-claimed. There is a background job to check volume disk usage. If empty space is more than the threshold, default to 0.3, the vacuum job will make the volume readonly, create a new volume with only existing files, and switch on the new volume. If you are impatient or doing some testing, vacuum the unused spaces this way.

```bash
curl "http://localhost:9333/vol/vacuum"
curl "http://localhost:9333/vol/vacuum?garbageThreshold=0.4"
```

The garbageThreshold=0.4 is optional, and will not change the default threshold. You can start volume master with a different default garbageThreshold.

This operation is not trivial. It will try to make a copy of the .dat and .idx files, skipping deleted files, and switch to the new files, removing the old files.

### Pre-Allocate Volumes

One volume servers one write a time. If you need to increase concurrency, you can pre-allocate lots of volumes. Here are examples. You can combine all the different options also.

```bash
# specify a specific replication
curl "http://localhost:9333/vol/grow?replication=000&count=4"
{"count":4}
# specify a collection
curl "http://localhost:9333/vol/grow?collection=turbo&count=4"
# specify data center
curl "http://localhost:9333/vol/grow?dataCenter=dc1&count=4"
# specify ttl
curl "http://localhost:9333/vol/grow?ttl=5d&count=4"
```

This generates 4 empty volumes.

### Check System Status

```bash
curl "http://10.0.2.15:9333/cluster/status?pretty=y"
{
  "IsLeader": true,
  "Leader": "10.0.2.15:9333",
  "Peers": [
    "10.0.2.15:9334",
    "10.0.2.15:9335"
  ]
}
curl "http://localhost:9333/dir/status?pretty=y"
{
  "Topology": {
    "DataCenters": [
      {
        "Free": 3,
        "Id": "dc1",
        "Max": 7,
        "Racks": [
          {
            "DataNodes": [
              {
                "Free": 3,
                "Max": 7,
                "PublicUrl": "localhost:8080",
                "Url": "localhost:8080",
                "Volumes": 4
              }
            ],
            "Free": 3,
            "Id": "DefaultRack",
            "Max": 7
          }
        ]
      },
      {
        "Free": 21,
        "Id": "dc3",
        "Max": 21,
        "Racks": [
          {
            "DataNodes": [
              {
                "Free": 7,
                "Max": 7,
                "PublicUrl": "localhost:8081",
                "Url": "localhost:8081",
                "Volumes": 0
              }
            ],
            "Free": 7,
            "Id": "rack1",
            "Max": 7
          },
          {
            "DataNodes": [
              {
                "Free": 7,
                "Max": 7,
                "PublicUrl": "localhost:8082",
                "Url": "localhost:8082",
                "Volumes": 0
              },
              {
                "Free": 7,
                "Max": 7,
                "PublicUrl": "localhost:8083",
                "Url": "localhost:8083",
                "Volumes": 0
              }
            ],
            "Free": 14,
            "Id": "DefaultRack",
            "Max": 14
          }
        ]
      }
    ],
    "Free": 24,
    "Max": 28,
    "layouts": [
      {
        "collection": "",
        "replication": "000",
        "writables": [
          1,
          2,
          3,
          4
        ]
      }
    ]
  },
  "Version": "0.47"
}
```
