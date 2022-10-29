# docker-sabnzbd

<!--- 
[![pipeline status](https://gitlab.com/homesrvr/docker-sabnzbd/badges/main/pipeline.svg)](https://gitlab.com/homesrvr/docker-sabnzbd/commits/main) 
[![Sabnzbd Release](https://gitlab.com/homesrvr/docker-sabnzbd/-/jobs/artifacts/main/raw/release.svg?job=PublishBadge)](https://gitlab.com/homesrvr/docker-sabnzbd/-/jobs/artifacts/main/raw/release.txt?job=PublishBadge)
[![Docker link](https://gitlab.com/homesrvr/docker-sabnzbd/-/jobs/artifacts/main/raw/dockerimage.svg?job=PublishBadge)](https://hub.docker.com/r/culater/sabnzbd)
-->


alpine-based dockerized build of sabnzbd.
This is part of a collection of docker images, designed to run on my low-end x86 based QNAP NAS server. It is a very compact image.

# Docker
The resulting docker image can be found here: [https://hub.docker.com/r/culater/sabnzbd](https://hub.docker.com/r/culater/sabnzbd)

## Example usage

docker run example:
```yaml
docker run -d \
  -v [/configdir]:/config \
  -v [/completedir]:/complete \
  -v [/incompletedir]:/incomplete \
  -p 8080:8080 \
  --restart=unless-stopped culater/sabnzbd
````

docker-compose example:
```yaml
---
version: "2.1"
services:
  sabnzbd:
    image: culater/sabnzbd
    container_name: sabnzbd
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Berlin
    volumes:
      - /path/to/data:/config
      - /path/to/downloads:/downloads #optional
      - /path/to/incomplete/downloads:/incomplete-downloads #optional
    ports:
      - 8080:8080
    restart: unless-stopped
````

## Reporting problems
Please report any issues to the [Gitlab issue tracker](https://gitlab.com/homesrvr/docker-sabnzbd/-/issues)

## Authors and acknowledgment
More information about sabnzbd can be found here:
[SABnzbd](https://sabnzbd.org "SABnzbd Project Homepage") 


## Project status
The docker image auto-updates after a new release of sabnzbd within a few days. The current sabnzbd version can be seen from the release tag. 

