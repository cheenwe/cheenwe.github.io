
在kubernetes(k8s)中对于存储的资源抽象了两个概念，分别是PersistentVolume(PV)、PersistentVolumeClaim(PVC)。

- PV是集群中的资源
- PVC是对这些资源的请求。

如上面所说PV和PVC都只是抽象的概念，在k8s中是通过插件的方式提供具体的存储实现。目前包含有NFS、iSCSI和云提供商指定的存储系统，更多的存储实现参考官方文档。


这里PV又有两种提供方式: 静态或者动态

## 静态 PV

首先我们需要一个NFS服务器，用于提供底层存储。

创建静态 pv，指定容量，访问模式，回收策略，存储类等；

```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-es-0
spec:
  capacity:
    storage: 4Gi
  accessModes:
    - ReadWriteMany
  volumeMode: Filesystem
  persistentVolumeReclaimPolicy: Recycle
  storageClassName: "es-storage-class"
  nfs:
    # 根据实际共享目录修改
    path: /data/es0
    # 根据实际 nfs服务器地址修改
    server: 192.168.20.216
```


## 创建动态PV

在一个工作k8s 集群中，PVC请求会很多，如果每次都需要管理员手动去创建对应的 PV资源，那就很不方便；因此 K8S还提供了多种 provisioner来动态创建 PV，不仅节省了管理员的时间，还可以根据StorageClasses封装不同类型的存储供 PVC 选用。

项目中的 role: cluster-storage目前支持自建nfs 和aliyun_nas 的动态provisioner


```
storage:
  # nfs server 参数
  nfs:
    enabled: "yes"
    server: "192.168.20.216"
    server_path: "/data/nfs"
    storage_class: "nfs-dynamic-class"
    provisioner_name: "nfs-provisioner-01"
```
