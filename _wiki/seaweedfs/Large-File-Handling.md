In order to achieve high concurrency, SeaweedFS tries to read and write the whole file into memory. But this would not work for large files. 

The following is implemented in "weed upload" command. For 3rd party clients, here is the spec.

To support large files, SeaweedFS supports these two kinds of files:
* Chunk File. Each chunk file is actually just normal files to SeaweedFS.
* Chunk Manifest. A simple json file with the list of all the chunks. 

This piece of code shows the json file structure:

https://github.com/chrislusf/seaweedfs/blob/master/weed/operation/chunked_file.go#L24

```
type ChunkInfo struct {
	Fid    string `json:"fid"`
	Offset int64  `json:"offset"`
	Size   int64  `json:"size"`
}

type ChunkList []*ChunkInfo

type ChunkManifest struct {
	Name   string    `json:"name,omitempty"`
	Mime   string    `json:"mime,omitempty"`
	Size   int64     `json:"size,omitempty"`
	Chunks ChunkList `json:"chunks,omitempty"`
}
```

When reading Chunk Manifest files, the SeaweedFS will find and send the data file based on the list of ChunkInfo.

## Create new large file

SeaweedFS delegates the effort to the client side. The steps are:

1. split large files into chunks
1. upload each file chunk as usual, with mime type "application/octet-stream". Save the related info into ChunkInfo struct. Each chunk can be spread onto different volumes, possibly giving faster parallel access.
1. upload the manifest file with mime type "application/json", and add url parameter "cm=true". The FileId to store the manifest file is the entry point of the large file.


## Update large file

Usually we just append large files. Updating a specific chunk of file is almost the same.

The steps to append a large file:

1. upload the new file chunks as usual, with mime type "application/octet-stream". Save the related info into ChunkInfo struct.
1. update the updated manifest file with mime type "application/json", and add url parameter "cm=true".

## Notes
There are no particular limit in terms of chunk file size. Each chunk size does not need to be the same, even in the same file. The rule of thumb is to just being able to keep the whole chunk file in memory, and not to have too many small chunk files.