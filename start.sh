#!/bin/bash
# strict mode http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# if uid not specified then use default uid for user nobody 
if [[ -z "${PUID}" ]]; then
    PUID="99"
fi

# if gid not specifed then use default gid for group users
if [[ -z "${PGID}" ]]; then
    PGID="100"
fi

# set user nobody to specified user id (non unique)
usermod -o -u "${PUID}" nobody
echo "[info] Env var PUID  defined as ${PUID}"

# set group users to specified group id (non unique)
groupmod -o -g "${PGID}" users
echo "[info] Env var PGID defined as ${PGID}"

# if this if the first run, generate a useful config
if [ ! -f /srv/config/config.xml ]; then
  echo "generating config"
  /srv/syncthing/syncthing --generate="/srv/config"
  # don't take the whole volume with the default so that we can add additional folders
  sed -e "s/id=\"default\" path=\"\/root\/Sync\"/id=\"default\" path=\"\/srv\/data\/default\"/" -i /srv/config/config.xml
  # ensure we can see the web ui outside of the docker container
	sed -e "s/<address>127.0.0.1:8384/<address>0.0.0.0:8384/" -i /srv/config/config.xml
fi

/srv/syncthing/syncthing -home=/srv/config

