[![App-Collection](https://i.griefed.de/images/2020/10/17/template.png)](https://github.com/Griefed/docker-App-Collection)

[![Docker Pulls](https://img.shields.io/docker/pulls/griefed/App-Collection?style=flat-square)](https://hub.docker.com/repository/docker/griefed/App-Collection)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/griefed/App-Collection?label=Image%20size&sort=date&style=flat-square)](https://hub.docker.com/repository/docker/griefed/App-Collection)
[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/griefed/App-Collection?label=Docker%20build&style=flat-square)](https://hub.docker.com/repository/docker/griefed/App-Collection)
[![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/griefed/App-Collection?label=Docker%20build&style=flat-square)](https://hub.docker.com/repository/docker/griefed/App-Collection)
[![GitHub Repo stars](https://img.shields.io/github/stars/Griefed/docker-App-Collection?label=GitHub%20Stars&style=social)](https://github.com/Griefed/docker-App-Collection)
[![GitHub forks](https://img.shields.io/github/forks/Griefed/docker-App-Collection?label=GitHub%20Forks&style=social)](https://github.com/Griefed/docker-App-Collection)

# WORK IN PROGESS

App-Collection

App-Collection is, as the name implies, a collection of various apps which I've previously released in separate Docker Containers and am now moving/collecing into one single container.

Current applications:
- [techgaun's](https://github.com/techgaun) [Active GitHub Forks](https://github.com/techgaun/active-forks)
- [magicmark's](https://github.com/magicmark/) [Composerize](https://github.com/magicmark/composerize)
- [bucherfa's](https://github.com/bucherfa) [dcc-web](https://github.com/bucherfa/dcc-web)
- [digitalocean's](https://github.com/digitalocean) [nginxconfig.io](https://github.com/digitalocean/nginxconfig.io)
- [jeroenpardon's](https://github.com/jeroenpardon) [SUI](https://github.com/jeroenpardon/sui)
- [maeglin89273's](https://github.com/maeglin89273) [triangulator](https://github.com/maeglin89273/triangulator), a fork of [javierbyte](https://github.com/javierbyte) [triangulator](https://github.com/javierbyte/triangulator)

![App-Collection]( EXAMPLE_IMAGE )

---

Creates a Container which runs [Griefed's](https://github.com/Griefed) [App-Collection](https://github.com/Griefed/App-Collection), with [lsiobase/nginx](https://hub.docker.com/r/lsiobase/nginx) as the base image, as seen on EXAMPLE_SITE_IF_EXISTS.

The lasiobase/alpine image is a custom base image built with [Alpine linux](https://alpinelinux.org/) and [S6 overlay](https://github.com/just-containers/s6-overlay).
Using this image allows us to use the same user/group ids in the container as on the host, making file transfers much easier

## Deployment

### Pre-built images

```docker-compose.yml
version: '3.6'
services:
  app-Collection:
    container_name: app-Collection
    image: griefed/App-Collection
    restart: unless-stopped
    volumes:
      - ./path/to/config:/config
    environment:
      - TZ=Europe/Berlin
      - PUID=1000  # User ID
      - PGID=1000  # Group ID
      - DOMAIN=www.example.com
      - PROTOCOL=https
      - DISABLE_DCC=false
      - DISABLE_COMPOSERIZE=false
      - DISABLE_NGINXCONFIG_IO=false
      - DISABLE_TRIANGULATOR=false
      - DISABLE_ACTIVE_GITHUB_FORKS=false
    ports:
      - 80:80
```

## Configuration

Configuration | Explanation
------------ | -------------
[Restart policy](https://docs.docker.com/compose/compose-file/#restart) | "no", always, on-failure, unless-stopped
config volume | Contains config files and logs.
TZ | Timezone
PUID | for UserID
PGID | for GroupID
DOMAIN | The address of the device this container is running on. Can be an IP or sub.domain.tld.
PROTOCOL | The protocol used to access this container. Either HTTP or HTTPS.
DISABLE_DCC | Either `true` or `false`.
DISABLE_COMPOSERIZE | Either `true` or `false`.
DISABLE_NGINXCONFIG_IO | Either `true` or `false`.
DISABLE_TRIANGULATOR | Either `true` or `false`.
DISABLE_ACTIVE_GITHUB_FORKS | Either `true` or `false`.
ports | The port where the service will be available at.

### DISABLE and .lock files

If `DISABLE_`-variable is set to `false`, App-Collection will not install that app during boot. If set to `true`, App-Collection will install the correpsonding app and place a `appname.lock` file in the `/config/www/` folder.
If at any point you wish to reinstall one of the apps, make sure the `DISABLE_`-variable is set to `false` and the corresponding `appname.lock` file is deleted.

## User / Group Identifiers

When using volumes, permissions issues can arise between the host OS and the container. [Linuxserver.io](https://www.linuxserver.io/) avoids this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

### Raspberry Pi & building the image yourself

Using the [Dockerfile]( LINK_TO_DOCKERFILE ), this container can be built and run on a Raspberry Pi.
I've tested it on a Raspberry Pi 3B.

#### docker-compose.yml

```docker-compose.yml
version: '3.6'
services:
  app-collection:
    container_name: app-collection
    build: ./App-Collection/
    restart: unless-stopped
    volumes:
      - ./path/to/config:/config
    environment:
      - TZ=Europe/Berlin
      - PUID=1000  # User ID
      - PGID=1000  # Group ID
      - DOMAIN=www.example.com
      - PROTOCOL=https
      - DISABLE_DCC=false
      - DISABLE_COMPOSERIZE=false
      - DISABLE_NGINXCONFIG_IO=false
      - DISABLE_TRIANGULATOR=false
      - DISABLE_ACTIVE_GITHUB_FORKS=false
    ports:
      - 80:80
```

1. Clone the repository: `git clone REPOSITORY_LINK ./App-Collection`
1. Prepare docker-compose.yml file as seen above
1. `docker-compose up -d --build app-collection`
1. Visit IP.ADDRESS.OF.HOST:80
1. ???
1. Profit!
