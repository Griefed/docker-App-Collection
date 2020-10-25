FROM lsiobase/nginx:3.12

LABEL maintainer="Griefed <griefed@griefed.de>"

ARG DISABLE_DCC
ARG DISABLE_COMPOSERIZE
ARG DISABLE_NGINXCONFIG_IO
ARG DISABLE_TRIANGULATOR
ARG DISABLE_ACTIVE_GITHUB_FORKS
ARG DOMAIN
ARG PROTOCOL

RUN \
        echo "**** install dependencies and build tools and stuff ****" && \
        apk add --no-cache \
						git \
            make \
            npm && \
            npm install yarn@1.19.1 -g && \
				rm -rf \
						/root/.cache \
						/tmp/*

# Copy local files
COPY root/ /

# Communicate ports and volumes to be used
EXPOSE 80

VOLUME /config
