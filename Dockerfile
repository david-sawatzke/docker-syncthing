FROM alpine
MAINTAINER David Sawatzke <david@sawatzke.de>

WORKDIR /srv
VOLUME ["/srv/data", "/srv/config"]

RUN apk add --no-cache ca-certificates
ADD ./init.sh /
RUN chmod  544 /init.sh

# get syncthing
ENV SYNCTHING_VERSION 0.14.0
RUN wget -O syncthing.tar.gz https://github.com/syncthing/syncthing/releases/download/v$SYNCTHING_VERSION/syncthing-linux-amd64-v$SYNCTHING_VERSION.tar.gz \
  && tar -xzf syncthing.tar.gz \
  && rm -f syncthing.tar.gz \
  && mv syncthing-linux-amd64-v* syncthing \
  && rm -rf syncthing/etc \
  && rm -rf syncthing/*.pdf \
  && mkdir -p /srv/config \
  && mkdir -p /srv/data

ENTRYPOINT ["/init.sh"]
