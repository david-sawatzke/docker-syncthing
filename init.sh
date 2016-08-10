#!/bin/sh
# if this if the first run, generate a useful config
if [ ! -f /config/config.xml ]; then
	echo "generating config"
	/srv/syncthing/syncthing --generate=/config
	# don't take the whole volume with the default so that we can add additional folders
	sed -e "s/id=\"default\" path=\"\/root\/Sync\"/id=\"default\" path=\"\/data\/default\"/" -i /config/config.xml
	# ensure we can see the web ui outside of the docker container
	sed -e "s/<address>127.0.0.1:8384/<address>0.0.0.0:8384/" -i /config/config.xml
fi
chmod -R 700 /config
/syncthing-inotify -home=/config -logflags=0 &
exec /syncthing/syncthing -home=/config
