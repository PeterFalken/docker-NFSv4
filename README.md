# [docker-NFSv4]
# NFSv4 server image for Docker &amp; Kubernetes

## Description
This is an opinionated implementation of an NFSv4 server with Alpine as its base.
Parameters are taken from files mounted to the container mainly /etc/exports & /etc/nfs.conf, this simplies the configuration logic for the service and makes explicit to each implementation.


Based on the great work of:
- [ehough/docker-nfs-server](https://github.com/ehough/docker-nfs-server)
- [normal-computing/docker-nfs-server](https://github.com/normal-computing/docker-nfs-server)
- [sjiveson/nfs-server-alpine](https://github.com/sjiveson/nfs-server-alpine)

## Configuration
The image will look for `exports` & `nfs.conf` under the `/etc/` directory, thes two configuration files should be mounted as readonly volumen on the image, this allows full freedom of the NFS exports and the configuration for the RPC services in use (rpc.mound & rpc.nfsd)

The image will need priviledge access to the kernel modules to load `nfsd`, you can add `SYS_ADMIN` & `SYS_MODULE` capabilities or run the container with the `--privileged` flag.

### Sample conf files
exports - mounts to `/etc/exports`
```
## NFSv4 Shares to export
/mnt/NFS    *(rw,async,no_root_squash,no_subtree_check,crossmnt,fsid=0)
```
nfs.conf - mounts to `/etc/nfs.conf`
```
[mountd]
# debug=general

[nfsd]
# debug=all
udp=n
grace-time=10
lease-time=10
vers3=n
```

## Running the image
```
docker run -d \
  --name NFSv4 \
  --volume /lib/modules:/lib/modules:ro \
  --volume /opt/NFS.exports:/etc/exports:ro \
  --volume /opt/NFS_nfs.conf:/etc/nfs.conf:ro \
  --volume /opt/NFS_Shares:/mnt/NFS \
  --cap-add SYS_ADMIN \
  --cap-add SYS_MODULE \
  --publish 2049:2049 \
  peterfalken/docker-nfsv4:latest
```

## TODOs
- Add an appropiate HEALTHCHECK
