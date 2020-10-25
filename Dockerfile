### PICK ONE
# FROM lsiobase/nginx:3.12
# FROM lsiobase/alpine:3.12
# FROM lsiobase/ubuntu:bionic
# FROM lsiobase/rdesktop:focal
# FROM lsiobase/mono:LTS
###

LABEL maintainer="Griefed <griefed@griefed.de>"

RUN \
        echo "**** install dependencies and build tools and stuff ****" && \
        apk add --no-cache \
						git && \

				###
				# INSTALL EVERYTHING
				# ÄÄÄWÄÄÄRIIIZIIIING
				###

				echo "**** clone app repository ****" && \
						git clone -b \
								GITURL \
								/app/APPNAME && \
				echo "**** install app, for example with npm ****" && \
						cd /app/APPNAME && \
						npm install && \
						npm run-script build && \
				echo "**** delete unneeded packages and stuff ****" && \
				apk del --purge \
								git && \
				rm -rf \
								/root/.cache \
								/tmp/*

# Copy local files
COPY root/ /

# Communicate ports and volumes to be used
EXPOSE PORT

VOLUME /config /data

## NOTES ##
## Delete files\folders not needed
## The User abc, should be running everything, give that permission in any case you need it.
## When creating init's Use 10's where posible, its to allow add stuff in between when needed. also, do not be afraid to split custom code into several little ones.
## user abc and folders /app /config /defaults are all created by baseimage
## the first available init script is 30<your script>
## you can comment the beginning of each new RUN block but you cannot comment between commands in each RUN block.
