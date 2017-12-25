
You can append to any HTTP API with &pretty=y to see a formatted json output.

## Filer server

### POST/PUT/Get files
```bash
# Basic Usage:
	//create or overwrite the file, the directories /path/to will be automatically created
	POST /path/to/file
	//get the file content
	GET /path/to/file
	//create or overwrite the file, the filename in the multipart request will be used
	POST /path/to/
	//return a json format subdirectory and files listing
	GET /path/to/
        Accept: application/json
```
Examples:
```bash
# Basic Usage:
> curl -F file=@report.js "http://localhost:8888/javascript/"
{"name":"report.js","size":866,"fid":"7,0254f1f3fd","url":"http://localhost:8081/7,0254f1f3fd"}
> curl  "http://localhost:8888/javascript/report.js"   # get the file content
...
> curl -F file=@report.js "http://localhost:8888/javascript/new_name.js"    # upload the file with a different name
{"name":"report.js","size":866,"fid":"3,034389657e","url":"http://localhost:8081/3,034389657e"}
> curl  -H "Accept: application/json" "http://localhost:8888/javascript/?pretty=y"            # list all files under /javascript/
{
  "Directory": "/javascript/",
  "Files": [
    {
      "name": "new_name.js",
      "fid": "3,034389657e"
    },
    {
      "name": "report.js",
      "fid": "7,0254f1f3fd"
    }
  ],
  "Subdirectories": null
}
```

### List files under a directory
This is for embedded filer only.

Some folder can be very large. To efficiently list files, we use a non-traditional way to iterate files. Every pagination you provide a "lastFileName", and a "limit=x". The filer locate the "lastFileName" in O(log(n)) time, and retrieve the next x files.

```bash
curl  "http://localhost:8888/javascript/?pretty=y&lastFileName=new_name.js&limit=2"
{
  "Directory": "/javascript/",
  "Files": [
    {
      "name": "report.js",
      "fid": "7,0254f1f3fd"
    }
  ]
}

```

### Move a directory
This is for embedded filer only.

Rename a folder is an O(1) operation, even for folders with lots of files.

```bash
# Change folder name from /javascript to /assets
> curl  "http://localhost:8888/admin/mv?from=/javascript&to=/assets"

# no files under /javascript now
> curl  "http://localhost:8888/javascript/?pretty=y"
{
  "Directory": "/javascript/",
  "Files": null,
  "Subdirectories": null
}

# files are moved to /assets folder
> curl  "http://localhost:8888/assets/?pretty=y"
{
  "Directory": "/assets/",
  "Files": [
    {
      "name": "new_name.js",
      "fid": "3,034389657e"
    },
    {
      "name": "report.js",
      "fid": "7,0254f1f3fd"
    }
  ],
  "Subdirectories": null
}
```

# Delete a file
```bash
> curl -X DELETE "http://localhost:8888/assets/report.js"
```
