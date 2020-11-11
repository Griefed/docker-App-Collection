FROM lsiobase/nginx:3.12

LABEL maintainer="Griefed <griefed@griefed.de>"

RUN \
    echo "**** Install dependencies, build tools and stuff ****" && \
    apk add --no-cache \
      git \
      make \
      jq \
      npm && \
    echo "**** Cleanup ****" && \
    rm -rf \
      /root/.cache \
      /tmp/*

# Copy local files
COPY root/ /

# Communicate ports and volumes to be used
EXPOSE 80 443

VOLUME /config
