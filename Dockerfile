FROM alpine:3.4
MAINTAINER David Sawatzke <david@sawatzke.de>

VOLUME ["/data", "/config"]

ADD ./init.sh /

# get syncthing
ENV SYNCTHING_VERSION 0.14.4
ENV SYNCTHING_INOTIFY_VERSION 0.8.3
RUN apk add --no-cache ca-certificates openssl \
    && wget -O /tmp/syncthing.tar.gz https://github.com/syncthing/syncthing/releases/download/v$SYNCTHING_VERSION/syncthing-linux-amd64-v$SYNCTHING_VERSION.tar.gz \
    && tar -xzf /tmp/syncthing.tar.gz -C /tmp \
    && rm -f /tmp/syncthing.tar.gz \
    && rm -rf /tmp/syncthing-*/etc \
    && rm -rf /tmp/syncthing-*/*.pdf \
    && mv /tmp/syncthing-* /syncthing \
    && wget -O /tmp/syncthing-inotify.tar.gz https://github.com/syncthing/syncthing-inotify/releases/download/v$SYNCTHING_INOTIFY_VERSION/syncthing-inotify-linux-amd64-v$SYNCTHING_INOTIFY_VERSION.tar.gz \
    && tar -xzf /tmp/syncthing-inotify.tar.gz -C / \
    && rm -f /tmp/syncthig-inotify.tar.gz \
    && mkdir -p /data \
    && chmod 544 /init.sh

ENTRYPOINT ["/init.sh"]
