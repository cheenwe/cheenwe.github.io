SeaweedFS can support replication. The replication is implemented not on file level, but on volume level.

## How to use

Basically, the way it works is:

1. start weed master, and optionally specify the default replication type

   ```bash
   ./weed master -defaultReplication=001
   ```

2. start volume servers as this:

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

*Note: This subject to change.*

Value | Meaning
---|---
000 | no replication, just one copy
001 | replicate once on the same rack
010 | replicate once on a different rack in the same data center
100 | replicate once on a different data center
200 | replicate twice on two other different data center
110 | replicate once on a different rack, and once on a different data center
... | ...

So if the replication type is xyz

Column | Meaning
---|---
**x** | number of replica in other data centers
**y** | number of replica in other racks in the same data center
**z** | number of replica in other servers in the same rack

x,y,z each can be 0, 1, or 2. So there are 9 possible replication types, and can be easily extended. 
Each replication type will physically create x+y+z+1 copies of volume data files.


## Allocate File Key on specific data center

Now when requesting a file key, an optional "dataCenter" parameter can limit the assigned volume to the specific data center. For example, this specify

```bash
http://localhost:9333/dir/assign?dataCenter=dc1
```