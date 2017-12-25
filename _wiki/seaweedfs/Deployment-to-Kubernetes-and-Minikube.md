This page explains how to repackage the application in order to be deployed onto minikube (development scale Kubernetes with a single node).

# Intro

`Kubernetes` is an open-source system for automating deployment, scaling, and management of containerized applications.

Developers normally don't setup Kubernetes locally. There is a lot of networking and operational detail to learn which could be overwhelming if one would want to stay productive and focused. Instead, Google built Minikube, which is a single node Kubernetes cluster running inside a VM. So you'll need a virtualisation infrastructure in your local dev environment. I personally use KVM on Linux which allows me to preserve the same IP for my VM between restarts.

This is a really good guideline on how to setup minikube: https://thenewstack.io/tutorial-configuring-ultimate-development-environment-kubernetes/

# Steps

The default docker image is based on alpine Linux which causes issues with the DNS addon in Minikubes (see https://github.com/chrislusf/seaweedfs/issues/474). To get around this problem, I rebuilt the docker image from "scratch".

To do this I added (or modified) the following files to the local repository:

1. Modified the Dockerfile in the docker folder
2. Added a new bash script to build the image using the docker file
3. Added 2 yaml files to create master and volume "deployments" (which create PODs and containers)
4. Added an additional yaml file to expose both volume and master "deployments" through a "service"


## Dockerfile

The new docker file was changed to use `scratch` base image without anything but the application. You can always create different docker files for different needs. For instance, for troubleshooting purposes you could build development images containing other tools than just the application.

```
FROM scratch
ADD weed /
ENTRYPOINT ["/weed"]
```

## Image building script

The script uses the docker file to build my image. Note the followings:
1. I'm building the application with `cgo` disabled which produces a static binary. This is why I can create the image from `scratch` without worrying about missing libraries on the operating system.
2. The image is built using the latest development code. You might want to pull the latest stable tag instead.
3. `192.168.42.23` is the IP of a private docker registry that I've setup from which the image is pulled and deployed to minikube cluster (later steps).

```
#!/bin/sh

go get github.com/chrislusf/seaweedfs/weed/...
CGO_ENABLED=0 GOOS=linux go build github.com/chrislusf/seaweedfs/weed 
docker build -t weed:latest -f ./Dockerfile .
docker tag weed:latest 192.168.42.23:80/weed:latest
docker push 192.168.42.23:80/weed:latest
rm -f weed
docker rmi $(docker images -qa -f 'dangling=true') 2>/dev/null
exit 0
```

## Yaml files

In order to deploy the docker image onto minikube in form of "pods" and "services", we need yaml files. Quickly explaining what POD and Service are:

* A POD is a group of containers that are deployed together on the same host. A given POD by default has 1 container. In this case, I have 2 PODs for master and volume containers (created through "deployment") each of which has 1 container.
* A service is a grouping of pods that are running on the cluster. In this case, I'm creating one service for both master and volume PODs.

**Create master POD**

```
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: weedmasterdeployment
spec:
  template: # create pods using pod definition in this template
    metadata:
      labels:
        app: haystack
    spec:
      containers:
      - name: weedmaster
        image: 192.168.42.23:80/weed:latest
        args: ["-log_dir", "/var/containerdata/logs", "master", "-port", "9333", "-mdir", "/var/containerdata/haystack/master", "-ip", "haystackservice"]
        ports:
        - containerPort: 9333
        volumeMounts:
        - mountPath: /var/containerdata
          name: vlm
      volumes:
      - name: vlm
        hostPath:
          path: '/data/vlm'
```

**Create volume POD**

```
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: weedvolumedeployment
spec:
  template:
    metadata:
      labels:
        app: haystack
    spec:
      containers:
      - name: weedvol
        image: 192.168.42.23:80/weed:latest
        args: ["-log_dir", "/var/containerdata/logs", "volume", "-port", "8080", "-mserver", "haystackservice:9333", "-dir", "/var/containerdata/haystack/volume", "-ip", "haystackservice"]
        ports:
        - containerPort: 8080
        volumeMounts:
        - mountPath: /var/containerdata
          name: vlm
      volumes:
      - name: vlm
        hostPath:
          path: '/data/vlm'
```

**Create a service exposing PODs**

```
apiVersion: v1
kind: Service
metadata:
  name: haystackservice
spec:
  selector:
    app: haystack
  ports:
  - name: mport
    protocol: TCP
    port: 9333
    nodePort: 30069
  - name: vport
    protocol: TCP
    port: 8080
    nodePort: 30070
  type: NodePort
```

Please note:
1. You'll need to slightly modify the yaml files that create deployments (the first 2 yaml files) if you intend to run them against an actual Kubernetes cluster. Essentially, in the `volumes` section of the yaml file, instead of using a `hostpath` you'd need to specify a `persistent volume` (`persistent volume claim` to be exact). For more information about PV and PVC see https://kubernetes.io/docs/concepts/storage/persistent-volumes/.
2. If you're however deploying the application to minikube, you'll have to make sure the `hostpath` exists in the cluster prior to deployment. `ssh` into minikube and create the folders:

```
$$ minikube ssh
$ sudo mkdir -p /data/vlm/logs && \
  sudo mkdir -p /data/vlm/haystack/master && \
  sudo mkdir  /data/vlm/haystack/volume && \
  sudo chown -R docker:root /mnt/sda1/data/
```
_`/data` is a softlink to `/mnt/sda1/data`, hence the use of full path in the last command._

## Deploy and test

You can then deploy everything using kubectl CLI tool (installed when you install minikube).

```
$ kubectl create -f master_pod.yml
deployment "weedmasterdeployment" created
$ kubectl create -f volume_pod.yml
deployment "weedvolumedeployment" created
$ kubectl create -f service.yml
service "haystackservice" created
```

And eventually call the APIs from outside the cluster:

```
http://minikubecluster:30069/dir/assign
curl -F file=@/home/amir/Downloads/hardhat.png http://minikubecluster:30070/2,0333d4fea4
http://minikubecluster:30070/2,0333d4fea4
http://minikubecluster:30070/ui/index.html
```

`minikubecluster` in my environment resolves to the IP address of the minikube's VM which you can get using `minikube ip` command.
The port numbers in these commands are the `node ports` defined as part of the service spec which map to the internal container ports and to which they forward all the requests. For more information about Node Ports see https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport.