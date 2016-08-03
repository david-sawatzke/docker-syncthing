FROM alpine:3.4
MAINTAINER David Sawatzke <david@sawatzke.de>

WORKDIR /
VOLUME ["/data", "/config"]

RUN apk add --no-cache ca-certificates openssl
ADD ./init.sh /
RUN chmod  544 /init.sh

# get syncthing
ENV SYNCTHING_VERSION 0.14.3
RUN wget -O /tmp/syncthing.tar.gz https://github.com/syncthing/syncthing/releases/download/v$SYNCTHING_VERSION/syncthing-linux-amd64-v$SYNCTHING_VERSION.tar.gz \
  && tar -xzf /tmp/syncthing.tar.gz -C /tmp \
  && rm -f /tmp/syncthing.tar.gz \
  && rm -rf /tmp/syncthing-*/etc \
  && rm -rf /tmp/syncthing-*/*.pdf \
  && mv /tmp/syncthing-* /syncthing \
  && mkdir -p /config \
  && mkdir -p /data

ENTRYPOINT ["/init.sh"]
