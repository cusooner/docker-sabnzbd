![SABnzbd Logo](https://www.usenet.com/wp-content/uploads/2017/05/Screenshot_2-1.png)

** sabnzbd container **
===

[![Actions Status](https://github.com/thebungler/docker-sabnzbd/workflows/Docker%20Build/badge.svg)](https://github.com/thebungler/sabnzbd/actions)

===

This is part of my learning project, trying to build compact docker images to run on
my light powered NAS

## Usage

shell
```shell
docker run -d \
    -p 5055:5055 \
    -v /blahblah/config:/config \
    -v ... complete \
    -v .... incomplete
    thebungler/sabnzbd
```

docker-compose
```docker-compose
  overseerr:
    image: thebungler/sabnzbd:latest
    container_name: sabnzbd
    environment:
      - PUID=1001
      - PGID=100
      - TZ=Europe/Berlin
    volumes:
      - /mydockervol/sabnzbd:/config
    ports:
      - 8080:8080
    restart: unless-stopped
```

## Environment

- `$TZ`           - Timezone

## Volume

- `/config`       - where config is stored

## Network

- `5055/tcp`      - web interface