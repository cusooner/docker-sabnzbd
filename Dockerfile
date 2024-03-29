FROM alpine:3.15

# FIXME labels
LABEL org.opencontainers.image.authors = "cusooner"
LABEL org.opencontainers.image.source = "https://github.com/cusooner/docker-sabnzbd"
LABEL org.opencontainers.image.description="Dockerized sabnzbd"

ARG UNRAR_VERSION=6.1.4

RUN \
  echo "**** install packages ****" && \
  apk add -U --update --no-cache --virtual=build-dependencies build-base g++ gcc libffi-dev make openssl-dev python3-dev && \
  apk add  -U --update --no-cache curl p7zip par2cmdline python3 py3-pip 
  # echo "**** install unrar from source ****" && \
  # mkdir /tmp/unrar && \
  # curl -o /tmp/unrar.tar.gz -L "https://www.rarlab.com/rar/unrarsrc-${UNRAR_VERSION}.tar.gz" && \  
  # tar xf /tmp/unrar.tar.gz -C /tmp/unrar --strip-components=1 && \
  # cd /tmp/unrar && \
  # make && \
  # install -v -m755 unrar /usr/local/bin && \
  # echo "**** install sabnzbd ****" && \  
  # SABNZBD_VERSION=$(curl -s "https://api.github.com/repos/sabnzbd/sabnzbd/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]'); \
  # mkdir -p /app/sabnzbd && \
  # curl -o /tmp/sabnzbd.tar.gz -L "https://github.com/sabnzbd/sabnzbd/releases/download/${SABNZBD_VERSION}/SABnzbd-${SABNZBD_VERSION}-src.tar.gz" && \
  # tar xf /tmp/sabnzbd.tar.gz -C /app/sabnzbd --strip-components=1 && \
  # cd /app/sabnzbd && \
  # python3 -m pip install --upgrade pip && \
  # pip3 install -U --no-cache-dir wheel apprise pynzb requests && \
  # pip3 install -U --no-cache-dir -r requirements.txt && \
  # echo "**** install nzb-notify ****" && \   
  # NZBNOTIFY_VERSION=$(curl -s "https://api.github.com/repos/caronc/nzb-notify/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  # mkdir -p /app/nzbnotify && \
  # curl -o /tmp/nzbnotify.tar.gz -L "https://api.github.com/repos/caronc/nzb-notify/tarball/${NZBNOTIFY_VERSION}" && \
  # tar xf \
  #   /tmp/nzbnotify.tar.gz -C /app/nzbnotify --strip-components=1 && \
  # cd /app/nzbnotify && \
  # pip3 install -U --no-cache-dir -r requirements.txt && \
  # echo "**** cleanup ****" && \
  # ln -s /usr/bin/python3 /usr/bin/python && \
  # apk del --purge build-dependencies && \
  # rm -rf "/tmp/*" "$HOME/.cache" "/var/cache/apk/*"

# FIXME should run as a non-priviledged user
# RUN addgroup -S sabnzbd && \
#  adduser -S sabnzbd -G sabnzbd && \
#  mkdir /config /complete /incomplete && \
#  chown sabnzbd:sabnzbd /config /complete /incomplete

RUN \
  mkdir /config /complete /incomplete

# user, ports, volume
#USER sabnzbd
EXPOSE 8080
VOLUME ["/config", "/complete", "/incomplete"]

HEALTHCHECK --interval=120s --timeout=15s --start-period=120s --retries=3 \
            CMD wget --no-check-certificate --quiet --spider 'http://localhost:8080' && echo "Everything is fine..." || exit 1

# finally
ENTRYPOINT [ "/usr/bin/python3", "/app/sabnzbd/SABnzbd.py", "-f", "/config/sabnzbd.ini", "-b", "0", "-s", "0.0.0.0:8080" ]
