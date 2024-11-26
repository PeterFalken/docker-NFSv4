FROM alpine AS base

RUN apk add --no-cache --update \
    bash \
    libcap-utils \
    nfs-utils \
    procps-ng \
  && rm -rf /var/cache/apk /usr/lib/*python* /etc/idmapd.conf /etc/exports \
  && mkdir -p /var/lib/nfs/rpc_pipefs /var/lib/nfs/v4recovery \
  && echo "rpc_pipefs  /var/lib/nfs/rpc_pipefs  rpc_pipefs  defaults  0  0" >> /etc/fstab \
  && echo "nfsd        /proc/fs/nfsd            nfsd        defaults  0  0" >> /etc/fstab

COPY nfs.* /usr/local/bin/
# COPY nfs.lib nfs.server /usr/local/bin/

## Squash into final layer
FROM scratch AS final
COPY --from=base / /
EXPOSE 2049
ENTRYPOINT ["/usr/local/bin/nfs.server"]
# HEALTHCHECK --interval=600s --timeout=5s --start-period=15s \
#   CMD exportfs || exit 1
