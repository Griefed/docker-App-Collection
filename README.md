[![docker-App-Collection](https://i.griefed.de/images/2020/11/18/docker-App-Collection_header.png)](https://github.com/Griefed/docker-App-Collection)

---

[![Docker Pulls](https://img.shields.io/docker/pulls/griefed/app-collection?style=flat-square)](https://hub.docker.com/repository/docker/griefed/app-collection)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/griefed/app-collection?label=Image%20size&sort=date&style=flat-square)](https://hub.docker.com/repository/docker/griefed/app-collection)
[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/griefed/app-collection?label=Docker%20build&style=flat-square)](https://hub.docker.com/repository/docker/griefed/app-collection)
[![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/griefed/app-collection?label=Docker%20build&style=flat-square)](https://hub.docker.com/repository/docker/griefed/app-collection)
[![GitHub Repo stars](https://img.shields.io/github/stars/Griefed/docker-App-Collection?label=GitHub%20Stars&style=social)](https://github.com/Griefed/docker-App-Collection)
[![GitHub forks](https://img.shields.io/github/forks/Griefed/docker-App-Collection?label=GitHub%20Forks&style=social)](https://github.com/Griefed/docker-App-Collection)

# docker-App-Collection

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

# Deployment

Tags | Description
-----|------------
`latest` | Using the `latest` tag will pull the latest image for amd64/x86_64 architecture.
`arm` | Using the `arm`tag will pull the latest image for arm architecture. Use this if you intend on running the container on a Raspberry Pi 3B, for example.

## Pre-built images

using docker-compose:

```docker-compose.yml
version: "2"
services:
  app-collection:
    image: griefed/app-collection:latest
    container_name: app-collection
    restart: unless-stopped
    environment:
      - TZ=Europe/Berlin # Timezone
      - PUID=1000 # User ID
      - PROTOCOL=https # The protocol used to access this container. Either HTTP or HTTPS.
      - PGID=1000 # Group ID
      - INSTALL_TRIANGULATOR=true # Whether to install triangulator. Either true or false.
      - INSTALL_TGEN=true # Whether to install tgen. Either true or false.
      - INSTALL_NGINXCONFIG_IO=true # Whether to install NGINXConfig.io. Either true or false.
      - INSTALL_DCC=true # Whether to install dcc. Either true or false.
      - INSTALL_COMPOSERIZE=true # Whether to install composerize. Either true or false.
      - INSTALL_ACTIVE_GITHUB_FORKS=true # Whether to install Active GitHub Forks. Either true or false.
      - DOMAIN=www.example.com # The address of the device this container is running on. Can be an IP or sub.domain.tld.
    volumes:
      - /host/path/to/config:/config # Contains all application data and base-image config files
    ports:
      - 443:443 # https
      - 80:80 # http
```

Using CLI:

```bash
docker create \
  --name=app-collection \
  -e TZ=Europe/Berlin \
  -e PUID=1000 \
  -e PROTOCOL=https \
  -e PGID=1000 \
  -e INSTALL_TRIANGULATOR=true \
  -e INSTALL_TGEN=true \
  -e INSTALL_NGINXCONFIG_IO=true \
  -e INSTALL_DCC=true \
  -e INSTALL_COMPOSERIZE=true \
  -e INSTALL_ACTIVE_GITHUB_FORKS=true \
  -e DOMAIN=www.example.com \
  -v /host/path/to/config:/config \
  -p 443:443 \
  -p 80:80 \
  --restart unless-stopped \
  griefed/app-collection:latest
```
## Raspberry Pi

To run this container on a Raspberry Pi, use the `arm`-tag. I've tested it on a Raspberry Pi 3B.

`griefed/app-collection:arm`

# Configuration

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

## INSTALL and .lock files

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

# Building the image yourself

Use the [Dockerfile](https://github.com/Griefed/docker-App-Collection/Dockerfile) to build the image yourself, in case you want to make any changes to it

docker-compose.yml

```docker-compose.yml
version: '3.6'
services:
  app-collection:
    build: ./docker-App-Collection/
    container_name: app-collection
    restart: unless-stopped
    environment:
      - TZ=Europe/Berlin # Timezone
      - PUID=1000 # User ID
      - PROTOCOL=https # The protocol used to access this container. Either HTTP or HTTPS.
      - PGID=1000 # Group ID
      - INSTALL_TRIANGULATOR=true # Whether to install triangulator. Either true or false.
      - INSTALL_TGEN=true # Whether to install tgen. Either true or false.
      - INSTALL_NGINXCONFIG_IO=true # Whether to install NGINXConfig.io. Either true or false.
      - INSTALL_DCC=true # Whether to install dcc. Either true or false.
      - INSTALL_COMPOSERIZE=true # Whether to install composerize. Either true or false.
      - INSTALL_ACTIVE_GITHUB_FORKS=true # Whether to install Active GitHub Forks. Either true or false.
      - DOMAIN=www.example.com # The address of the device this container is running on. Can be an IP or sub.domain.tld.
    volumes:
      - /host/path/to/config:/config # Contains all application data and base-image config files
    ports:
      - 443:443 # https
      - 80:80 # http
```

1. Clone the repository: `git clone https://github.com/Griefed/docker-App-Collection.git ./docker-App-Collection`
1. Prepare docker-compose.yml file as seen above
1. `docker-compose up -d --build app-collection`
1. Visit IP.ADDRESS.OF.HOST:8080
1. ???
1. Profit!

# App Information

## Active GitHub Forks

* works after providing a **personal GitHub token**. It is used only to increase the limits to query to API. The token is stored in Local Storage only, not sent anywhere except for the GitHub API.
* include the **original repository** in the list, marked in bold
* after expanding **Options**, it is possible to increase the **maximum amount of forks** to retrieve and to utilize some kind of caching
* retrieve **commits of each fork** and show the differences
* click on box in the **Diff** column to see the commits

**Optimizations**

Because this version retrieves commits from every fork which is slow and uses your quota (it resets every hour, don't worry), I added two options for caching results:
* **Same size** - if a fork has the same size as a fork that has already been read, it is assumed to be the same and contain the same commits.
* **Same Push Date** - same but looks at the Last Push date.
If both are selected, both conditions have to be satisfied at the same time.
If the condition is satisfied, commits for the second fork are not retrieved but assumed to be the same as in the first fork.

## dcc Web

I've changed the index.html and .css under [/gh-pages](https://github.com/Griefed/dcc-web/tree/gh-pages) in order for the website to be deployed with regular apache's, for example a httpd:alpine docker container. 

## NGINXConfig

A lot of features with corresponding configuration directives. You can deep dive into the NGINX documentation right now OR you can use this tool to check how NGINX works, observe how your inputs are affecting the output, generate the best config for your specific use-case (and in parallel you can still use the docs).

## SUI Dashboard Status

**Changing color themes**
 - Click the options button on the left bottom

**Apps**

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

**Bookmarks**

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


**Color themes**

These can be added or customized in the themer.js file. When changing the name of a theme or adding one, make sure to edit this section in index.html accordingly:

```
    <section  class="themes">
```

## tgen

**Quick usage and examples**

```javascript
    // initialize the generator
    var generator = tgen.init(256, 256);


    // --- texture 1 --------------------------------------------------------------

    var canvas1 = generator
            .do('waves')
            .toCanvas();

    // set img src, and width height
    $('#img1').attr('src', canvas1.toDataURL("image/png")).css({width: canvas1.width, height: canvas1.height});


    // --- texture 2 --------------------------------------------------------------

    var canvas2 = generator
            .do('fill')
            .do('waves', {blend: 'difference'})
            .do('waves', {blend: 'difference'})
            .do('contrast', {"adjust": 50})
            .toCanvas();

    // set img src, and width height
    $('#img2').attr('src', canvas2.toDataURL("image/png")).css({width: canvas2.width, height: canvas2.height});


    // --- texture 3 --------------------------------------------------------------

    var texture3 = generator
            .clear() // remove previous layers
            .do('fill')
            .do('clouds', {blend: 'difference'})
            .do('spheres', {blend: 'lineardodge', 'dynamic': true})
            .do('vibrance', {"adjust": 50});

    var canvas3 = texture3.toCanvas();

    // set img src, and width height
    $('#img3').attr('src', canvas3.toDataURL("image/png")).css({width: canvas3.width, height: canvas3.height});


    // --- texture 4 --------------------------------------------------------------

    // get the generated params of texture3
    var params = texture3.params();

    // get number of layers
    var layers = params.items.length;

    // change the color of clouds
    params.items[layers - 3][2].rgba = [255, 50, 10, 0.85];

    // change the blending method
    params.items[layers - 2][2].blend = 'overlay';

    // generate new texture with modified params of texture3
    var canvas4 = generator.render(params).toCanvas();

    // set img src, and width height
    $('#img4').attr('src', canvas4.toDataURL("image/png")).css({width: canvas4.width, height: canvas4.height});


    // --- texture 5 --------------------------------------------------------------

    var params = {
        "width":  256, // texture width in pixel
        "height": 256, // texture height in pixel
        "debug": true, // render info to console log, default value: false
        "items":  [
            [0, "lines2", { // layer number and effect name
                "blend": "opacity", // layer blend mode
                "count": 21, // square count
                "size":  [5, 15], // random size between 5-15%
                "rgba":  [
                    255, // fixed red channel
                    [128, 192], // random green channel between 128 and 192
                    [200, 255], // random blue channel between 200 and 255
                    [0.2, 0.6] // random opacity between 0.2 and 0.6
                ]
            }],
            [1, "spheres", { // second layer
                "blend":   "lighten",
                "origin":  "random",
                "dynamic": true, //
                "count":   21,
                "size":    [20, 100],
                "rgba":    [200, 200, 200, 0.7]
            }],
            [2, "copy", 0], // copy layer 0 to layer 1
            [2, "merge", { // merge layer 1 in to 2
                "layer": 1,
                "blend": "lighten"
            }],
            [2, "brightness", {"adjust": -10, "legacy": true}], // set brightness
            [2, "vibrance", {"adjust": 50}], // set vibrance
            [2, "contrast", {"adjust": 50}] // set contrast
        ]
    };

    // generate
    var canvas5 = generator.render(params).toCanvas();

    // set img src, and width height
    $('#img5').attr('src', canvas5.toDataURL("image/png")).css({width: canvas5.width, height: canvas5.height});


    // --- texture 6 --------------------------------------------------------------

    // change layer of texture 5 merge blend method
    params.items[3] = [2, "merge", {
        "layer": 1,
        "blend": "difference"
    }];

    // render and add new effects
    var canvas6 = generator
            .render(params)
            .do('sharpen')
            .do('noise')
            .toCanvas();

    // set img src, and width height
    $('#img6').attr('src', canvas6.toDataURL("image/png")).css({width: canvas6.width, height: canvas6.height});


    // --- available effects -------------------------------------------------------

    // dump all effects and default config parameters
    for (key in tgen.defaults) {

        var params = tgen.defaults[key];
        var item = $('<span><h2>' + key + '</h2>' + JSON.stringify(params) + '</span>');
        $('.defaults').append(item);

    }
```

**Available other options**

* map (cool effect)
* merge (copy layer with blend)
* copy (copy layer without blend)
* history (store last x generated texture params in localStorage)

**Available events**

* beforeRender
* afterRender
* beforeEffect
* afterEffect