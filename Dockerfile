FROM lsiobase/nginx:3.12

LABEL maintainer="Griefed <griefed@griefed.de>"

ARG TGEN_VERSION="1.2.5"

RUN \
    echo "**** Install dependencies, build tools and stuff ****" && \
    apk add --no-cache \
      git \
      jq \
      make \
      npm \
      python3 && \
    echo "**** Cleanup ****" && \
    rm -rf \
      /root/.cache \
      /tmp/* && \
    echo $TGEN_VERSION > /version.txt

# Copy local files
COPY root/ /

# Communicate ports and volumes to be used
EXPOSE 80 443

VOLUME /config
