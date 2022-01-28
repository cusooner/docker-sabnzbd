FROM python:3.9-slim-bullseye
# set version label from file (if it exists)
COPY VERSION /VERSION
RUN export VERSION=$(cat /VERSION)
ARG VERSION
ENV VERSION=${VERSION:-3.5.0}
LABEL maintainer="thebungler"

# install libs and utilities needed for sabnzbd
RUN apt-get update && \
    apt-get -y install libffi-dev libssl-dev && \
    apt-get -y install unrar-free par2 unzip p7zip-full wget ca-certificates libgomp1 
RUN python3 -m pip install wheel

# install sabnzbd
WORKDIR /sabnzbd
RUN wget -O- https://codeload.github.com/sabnzbd/sabnzbd/tar.gz/$VERSION | tar -xz \
    && mv sabnzbd-*/* /sabnzbd 
RUN python3 -m pip install -r requirements.txt
#RUN python3 -m compileall .

# enable multi-lang support
RUN python3 tools/make_mo.py

# HEALTHCHECK --interval=120s --timeout=15s --start-period=120s --retries=3 \
#             CMD wget --no-check-certificate --quiet --spider 'http://localhost:8080' && echo "Everything is fine..." || exit 1

EXPOSE 8080
VOLUME ["/config", "/complete", "/incomplete"]
ENTRYPOINT ["python3", "SABnzbd.py", "-b 0 -f /config/sabnzbd.ini -s 0.0.0.0:8080"]
