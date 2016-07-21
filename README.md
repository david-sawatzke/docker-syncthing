# docker-syncthing

Run syncthing from a docker container

## Usage

```sh
docker run -d --restart=always \
  -v /srv/sync:/srv/data \
  -v /srv/syncthing:/srv/config \
  -p 22000:22000  -p 21025:21025/udp -p 8384:8385 \
  --name syncthing \
  --user "$(id -u):$(id -g)" \
  --net host \
  --restart unless-stopped \
  #Name
```

If you want to add a new folder, make sure you set the path to something in `/srv/data`.

docker-compose sample:
```yml
    syncthing:
	    build: docker-syncthing/.
	    volumes:
		    - /home/user:/srv/data/home
	    network_mode: "host"
	    user: #Add user info
	    restart: unless-stopped
```
