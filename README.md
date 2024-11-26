# [docker-NFSv4]
# NFSv4 server image for Docker &amp; Kubernetes

## Description
This is an oppinioneted implementation of an NFSv4 server with Alpine as its base.
Parameters are taken from files mounted to the container mainly /etc/exports & /etc/nfs.conf, this simplies the configuration logic for the service and makes explicit to each implementation.


Based on the great work of:
- [ehough/docker-nfs-server](https://github.com/ehough/docker-nfs-server)
- [normal-computing/docker-nfs-server](https://github.com/normal-computing/docker-nfs-server)
- [sjiveson/nfs-server-alpine](https://github.com/sjiveson/nfs-server-alpine)

## Run example
```
docker run -d \
  --env
  peterfalken/nfsv4:latest
```

## TODOs
- Add an appropiate HEALTHCHECK
- Check tags for image
