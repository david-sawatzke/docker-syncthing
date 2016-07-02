FROM alpine
MAINTAINER David Sawatzke <david@sawatzke.de>

ENV SYNCTHING_VERSION 0.13.9

RUN apk update \
  && apk upgrade -U -a \
  && apk add curl

# get syncthing
WORKDIR /srv
RUN curl -L -o syncthing.tar.gz https://github.com/syncthing/syncthing/releases/download/v$SYNCTHING_VERSION/syncthing-linux-amd64-v$SYNCTHING_VERSION.tar.gz \
  && tar -xzvf syncthing.tar.gz \
  && rm -f syncthing.tar.gz \
  && mv syncthing-linux-amd64-v* syncthing \
  && rm -rf syncthing/etc \
  && rm -rf syncthing/*.pdf \
  && mkdir -p /srv/config \
  && mkdir -p /srv/data

VOLUME ["/srv/data", "/srv/config"]

ADD ./start.sh /srv/start.sh
RUN chmod 777 /srv/start.sh

ENTRYPOINT ["/srv/start.sh"]

