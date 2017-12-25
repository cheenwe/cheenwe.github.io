### Why my 010 replicated volume files have different size?

This is normal. The compaction may not happen at exactly the same time. Or the replicated writes failed in the middle, so there is a deletion file appended following the partially written file.

### Why weed volume server loses connection with master?
  
You can increase the "-pulseSeconds" on master from default 5 seconds to some higher number.
See #100 https://github.com/chrislusf/seaweedfs/issues/100

### How to store large logs?

The log files are usually very large. But SeaweedFS is mostly for small-to-medium large files. How to store them? "weed filer" can help. 

Usually the logs are collected during a long period of time span. Let's say each day's log is about a manageable 128MB. You can store each day's log via "weed filer" under "/logs/" folder. For example:

    /logs/2015-01-01.log
    /logs/2015-01-02.log
    /logs/2015-01-03.log
    /logs/2015-01-04.log
