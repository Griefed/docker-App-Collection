[![docker-App-Collection](https://i.griefed.de/images/2020/11/18/docker-App-Collection_header.png)](https://github.com/Griefed/docker-App-Collection)

---

[![Docker Pulls](https://img.shields.io/docker/pulls/griefed/app-collection?style=flat-square)](https://hub.docker.com/repository/docker/griefed/app-collection)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/griefed/app-collection?label=Image%20size&sort=date&style=flat-square)](https://hub.docker.com/repository/docker/griefed/app-collection)
[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/griefed/app-collection?label=Docker%20build&style=flat-square)](https://hub.docker.com/repository/docker/griefed/app-collection)
[![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/griefed/app-collection?label=Docker%20build&style=flat-square)](https://hub.docker.com/repository/docker/griefed/app-collection)
[![GitHub Repo stars](https://img.shields.io/github/stars/Griefed/docker-App-Collection?label=GitHub%20Stars&style=social)](https://github.com/Griefed/docker-App-Collection)
[![GitHub forks](https://img.shields.io/github/forks/Griefed/docker-App-Collection?label=GitHub%20Forks&style=social)](https://github.com/Griefed/docker-App-Collection)

docker-App-Collection

App-Collection is, as the name implies, a collection of various apps which I have previously released in separate Docker Containers and am now moving/collecing into one single container.<br/><br/>Please keep in mind that the first start of the container may take a while.<br/>That is due to the apps and how they are installed on first run as they are not part of the image itself.<br/>Especially Composerize can take a couple of minutes to finish.

Current applications:

Creator | Repository
--------|------------
[lukaszmn](https://github.com/lukaszmn) | [active-forks](https://github.com/lukaszmn/active-forks), <br/>a fork of <br/>[techgaun's](https://github.com/techgaun) [active-forks](https://github.com/techgaun/active-forks)
[magicmark](https://github.com/magicmark) | [composerize](https://github.com/magicmark/composerize)
[Griefed](https://github.com/Griefed) | [dcc-web](https://github.com/Griefed/dcc-web), <br/>a fork of <br/>[bucherfa's](https://github.com/bucherfa) [dcc-web](https://github.com/bucherfa/dcc-web)
[digitalocean](https://github.com/digitalocean) | [nginxconfig.io](https://github.com/digitalocean/nginxconfig.io)
[ThreadR-r](https://github.com/ThreadR-r) | [sui-dashboard-status](https://github.com/ThreadR-r/sui-dashboard-status), <br/>a fork of <br/>[jeroenpardon's](https://github.com/jeroenpardon) [sui](https://github.com/jeroenpardon/sui)
[maeglin89273](https://github.com/maeglin89273) | [triangulator](https://github.com/maeglin89273/triangulator)
[schalkt](https://github.com/schalkt) | [tgen](https://github.com/schalkt/tgen)


App-Collection | Screenshots
------|------
[![active-forks](https://i.griefed.de/images/2020/11/19/docker-App-Collection_forks_screenshot.png)](https://github.com/lukaszmn/active-forks) | [![composerize](https://i.griefed.de/images/2020/11/19/docker-App-Collection_composerizescreenshot.png)](https://github.com/magicmark/composerize)
[![dcc-web](https://i.griefed.de/images/2020/11/19/docker-App-Collection_dcc_screenshot.png)](https://github.com/bucherfa/dcc-web) | [![nginxconfig.io](https://i.griefed.de/images/2020/11/19/docker-App-Collection_nginxconfig.io_screenshot.png)](https://github.com/digitalocean/nginxconfig.io)
[![sui-dashboard-status](https://i.griefed.de/images/2020/11/19/docker-App-Collection_screenshot.png)](https://github.com/ThreadR-r/sui-dashboard-status) | [![triangulator](https://i.griefed.de/images/2020/11/19/docker-App-Collection_triangulator_screenshot.png)](https://github.com/maeglin89273/triangulator)
[![tgen](https://i.griefed.de/images/2020/11/28/docker-App-Collection_tgen_screenshot.png)](https://github.com/schalkt/tgen) | Hi.

---

Creates a Container which runs [Griefed's](https://github.com/Griefed) [docker-App-Collection](https://github.com/Griefed/docker-App-Collection), with [lsiobase/nginx](https://hub.docker.com/r/lsiobase/lsiobase/nginx) as the base image, similar to https://apps.griefed.de.

The [lsiobase/nginx](https://hub.docker.com/r/lsiobase/nginx) image is a custom base image built with [Alpine linux](https://alpinelinux.org/) and [S6 overlay](https://github.com/just-containers/s6-overlay).
Using this image allows us to use the same user/group ids in the container as on the host, making file transfers much easier

## Deployment

Tags | Description
-----|------------
`latest` | Using the `latest` tag will pull the latest image for amd64/x86_64 architecture.
`arm` | Using the `arm`tag will pull the latest image for arm architecture. Use this if you intend on running the container on a Raspberry Pi 3B, for example.

### Pre-built images

```docker-compose.yml
version: '3.6'
services:
  app-collection:
    container_name: app-collection
    image: griefed/app-collection
    restart: unless-stopped
    volumes:
      - ./path/to/config:/config
    environment:
      - TZ=Europe/Berlin
      - PUID=1000  # User ID
      - PGID=1000  # Group ID
      - DOMAIN=www.example.com
      - PROTOCOL=https
      - INSTALL_DCC=true
      - INSTALL_COMPOSERIZE=true
      - INSTALL_NGINXCONFIG_IO=true
      - INSTALL_TGEN=true
      - INSTALL_TRIANGULATOR=true
      - INSTALL_ACTIVE_GITHUB_FORKS=true
    ports:
      - 80:80
      - 443:443
```

## Raspberry Pi

To run this container on a Raspberry Pi, use the `arm`-tag. I've tested it on a Raspberry Pi 3B.

`griefed/app-collection:arm`

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
INSTALL_DCC | Either `true` or `false`.
INSTALL_COMPOSERIZE | Either `true` or `false`.
INSTALL_NGINXCONFIG_IO | Either `true` or `false`.
INSTALL_TGEN | Either `true` or `false`.
INSTALL_TRIANGULATOR | Either `true` or `false`.
INSTALL_ACTIVE_GITHUB_FORKS | Either `true` or `false`.
ports | The port where the service will be available at.

## SUI configuration

### Apps
Add your apps by editing apps.json:

    {
	    "apps" : [
		    {"name":"Name of app 1","hostname":"sub1.example.com","port":80,"href":"https://sub1.example.com" ,"icon":"icon-name"},
		    {"name":"Name of app 2","hostname":"sub2.example.com""port":8080,"href":"https://sub1.example.com" ,"icon":"icon-name"}
	    ]
    }

Please note:

 - No `,` at the end of the last app's line
 - Find the names  of icons to use at [Material Design Icons](https://materialdesignicons.com/)

### Bookmarks
Add your bookmarks by editing links.json:

```
{
   "bookmarks":[
      {
         "category":"Category1",
         "links":[
            {
               "name":"Link1",
               "url":"http://example.com"
            },
            {
               "name":"Link2",
               "url":"http://example.com"
            }
         ]
      },
      {
         "category":"Category2",
         "links":[
            {
               "name":"Link1",
               "url":"http://example.com"
            },
            {
               "name":"Link2",
               "url":"http://example.com"
            }
         ]
      }
   ]
}
```
Add names for the categories you wish to define and add the bookmarks for each category.

Please note:

 - No `,` at the end of the last bookmark in a category and at the end of the last category

### INSTALL and .lock files

If `INSTALL_`-variable is set to `false`, App-Collection will not install that app during boot. If set to `true`, App-Collection will install the corresponding app and place a `appname.lock` file in the `/config/www/` folder.
If at any point you wish to reinstall one of the apps, make sure the corresponding `appname.lock` file is deleted.
If at any point you wish to uninstall one of the apps:
1. Stop the container with `docker stop app-collection`
1. Set the `INSTALL_`-variable for the app you do not want to install to `false`
1. Delete the config folder
1. Run `docker-compose up -d app-collection`


## User / Group Identifiers

When using volumes, permissions issues can arise between the host OS and the container. [Linuxserver.io](https://www.linuxserver.io/) avoids this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

### Building the image yourself

Use the [Dockerfile](https://github.com/Griefed/docker-App-Collection/Dockerfile) to build the image yourself, in case you want to make any changes to it

#### docker-compose.yml

```docker-compose.yml
version: '3.6'
services:
  app-collection:
    container_name: app-collection
    build: ./docker-App-Collection/
    restart: unless-stopped
    volumes:
      - ./path/to/config/files:/config
    environment:
      - TZ=Europe/Berlin
      - PUID=1000  # User ID
      - PGID=1000  # Group ID
      - DOMAIN=www.example.com
      - PROTOCOL=https
      - INSTALL_DCC=true
      - INSTALL_COMPOSERIZE=true
      - INSTALL_NGINXCONFIG_IO=true
      - INSTALL_TGEN=true
      - INSTALL_TRIANGULATOR=true
      - INSTALL_ACTIVE_GITHUB_FORKS=true
    ports:
      - 8080:80
      - 443:443
```

1. Clone the repository: `git clone https://github.com/Griefed/docker-App-Collection.git ./docker-App-Collection`
1. Prepare docker-compose.yml file as seen above
1. `docker-compose up -d --build app-collection`
1. Visit IP.ADDRESS.OF.HOST:8080
1. ???
1. Profit!

