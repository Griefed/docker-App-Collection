[![APP_NAME](https://i.griefed.de/images/2020/10/17/template.png)](https://github.com/ CREATOR_NAME / REPO_NAME)

[![Docker Pulls](https://img.shields.io/docker/pulls/griefed/
DOCKER_REPONAME
?style=flat-square)](https://hub.docker.com/repository/docker/griefed/
DOCKER_REPONAME
)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/griefed/
DOCKER_REPONAME
?label=Image%20size&sort=date&style=flat-square)](https://hub.docker.com/repository/docker/griefed/
DOCKER_REPONAME
)
[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/griefed/
DOCKER_REPONAME
?label=Docker%20build&style=flat-square)](https://hub.docker.com/repository/docker/griefed/
DOCKER_REPONAME
)
[![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/griefed/
DOCKERREPONAME
?label=Docker%20build&style=flat-square)](https://hub.docker.com/repository/docker/griefed/
DOCKER_REPONAME
)
[![GitHub Repo stars](https://img.shields.io/github/stars/Griefed/
GITHUB_REPONAME
?label=GitHub%20Stars&style=social)](https://github.com/Griefed/
GITHUB_REPONAME
)
[![GitHub forks](https://img.shields.io/github/forks/Griefed/
GITHUB_REPONAME
?label=GitHub%20Forks&style=social)](https://github.com/Griefed/
GITHUB_REPONAME
)

APP_NAME DESCRIPTION

![APP_NAME]( EXAMPLE_IMAGE )

---

Creates a Container which runs [CREATOR_PROFILE](https://github.com/ CREATOR_PROFILE ) [APP_NAME](https://github.com/d-zone-org/ APP_NAME ), with [lsiobase/alpine](https://hub.docker.com/r/lsiobase/alpine) as the base image, as seen on EXAMPLE_SITE_IF_EXISTS.

The lasiobase/alpine image is a custom base image built with [Alpine linux](https://alpinelinux.org/) and [S6 overlay](https://github.com/just-containers/s6-overlay).
Using this image allows us to use the same user/group ids in the container as on the host, making file transfers much easier

## Deployment

### Pre-built images

```docker-compose.yml
version: '3.6'
services:
  APP_NAME:
    container_name: APP_NAME
    image: griefed/APP_NAME
    restart: unless-stopped
    volumes:
      - ./path/to/config:/config
      - ./path/to/data:/data
    environment:
      - TZ=Europe/Berlin
      - PUID=1000  # User ID
      - PGID=1000  # Group ID
    ports:
      - 80:80
```

## Configuration

Configuration | Explanation
------------ | -------------
[Restart policy](https://docs.docker.com/compose/compose-file/#restart) | "no", always, on-failure, unless-stopped
config volume | Contains config files and logs.
data volume | Contains your/the containers important data.
TZ | Timezone
PUID | for UserID
PGID | for GroupID
ports | The port where the service will be available at.

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
  APP_NAME:
    container_name: APP_NAME
    build: ./APP_NAME/
    restart: unless-stopped
    volumes:
      - ./path/to/config/files:/config
    environment:
      - TZ=Europe/Berlin
      - PUID=1000  # User ID
      - PGID=1000  # Group ID
    ports:
      - 80:80
```

1. Clone the repository: `git clone REPOSITORY_LINK ./APP_NAME`
1. Prepare docker-compose.yml file as seen above
1. `docker-compose up -d --build APP_NAME`
1. Visit IP.ADDRESS.OF.HOST:80
1. ???
1. Profit!
