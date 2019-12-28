## NFS-client-provisioner

The [NFS client provisioner](https://github.com/kubernetes-incubator/external-storage/tree/master/nfs-client) is an automatic provisioner for Kubernetes that uses your *already configured* NFS server, automatically creating Persistent Volumes.

## TL;DR;

```console
$ helm inspect values stable/nfs-client-provisioner > nfs.values
```
# Modify the following
```yaml
nfs:
  server: kmaster.example.com
  path: /var/nfs
  mountOptions:
# For creating the StorageClass automatically:
storageClass:
  create: true
```

## Install

```console
$ helm install nfs stable/nfs-client-provisioner --values nfs.values
```

## Persistent Volume Claim

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  # any PVC name
  name: nfs-client
spec:
  accessModes:
  # ReadWriteMany(RW from multi nodes), ReadWriteOnce(RW from a node), ReadOnlyMany(R from multi nodes)
  - ReadWriteMany
  resources:
     requests:
       # storage size to use
       storage: 1Gi
```

## Lunch the deployment

```yaml
apiVersion: v1
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: satya
  name: satya
spec:
  replicas: 1
  selector:
    matchLabels:
      app: satya
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: satya
    spec:
      containers:
      - image: nginx
        name: nginx
        resources: {}
        volumeMounts:
          - name: nfs-share
            # mount point in container
            mountPath: /usr/share/nginx/html
      initContainers:
      - name: busybox
        image: busybox
        volumeMounts:
        - name: nfs-share
          mountPath: /nginx
        command: ["/bin/sh"]
        args: ["-c", "echo '<h1>Dynamic NFS</h1>' > /nginx/index.html"]
      volumes:
        - name: nfs-share
          persistentVolumeClaim:
            # PVC name you created
            claimName: nfs-client
status: {}
```

## Put your file in your nfs server (as per your nfs server mount path or use init container)

```sh
$ echo "dynamic nfs" > /var/nfs/default-nfs-client-pvc-103e8984-3f24-40a0-bc9d-d51c61d22685/index.html
```

