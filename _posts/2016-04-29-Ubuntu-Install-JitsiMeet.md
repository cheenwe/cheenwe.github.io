---
layout: post
title: Ubuntu 源码安装 Jitsi Meet
tags: java sdk
category: java
---


# Ubuntu 源码安装 Jitsi Meet

This describes configuring a server 182.61.25.227( jitsi.example.com) running Debian or a Debian Derivative. You will need to change references to that to match your host, and generate some passwords for  `videobridge_password`, `jicofo_password`, `auth_password` .

There are also some complete [example config files](https://github.com/jitsi/jitsi-meet/tree/master/doc/example-config-files/) available, mentioned in each section.


## Install prosody

```console
echo deb http://packages.prosody.im/debian $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list
wget https://prosody.im/files/prosody-debian-packages.key -O- | sudo apt-key add -
sudo apt-get update

sudo apt-get install prosody unzip git
```

## Configure prosody
Add config file in `/etc/prosody/conf.avail/182.61.25.227.cfg.lua` :

- add your domain virtual host section:

```console
VirtualHost "182.61.25.227"
    authentication = "anonymous"
    ssl = {
        key = "/var/lib/prosody/182.61.25.227.key";
        certificate = "/var/lib/prosody/182.61.25.227.crt";
    }
    modules_enabled = {
        "bosh";
        "pubsub";
    }
VirtualHost "auth.182.61.25.227"
    authentication = "internal_plain"
admins = { "focus@auth.182.61.25.227" }

Component "conference.182.61.25.227" "muc"
Component "jitsi-videobridge.182.61.25.227"
    component_secret = "videobridge_password"
Component "focus.182.61.25.227"
    component_secret = "jicofo_password"
```

Add link for the added configuration

```console
ln -s /etc/prosody/conf.avail/182.61.25.227.cfg.lua /etc/prosody/conf.d/182.61.25.227.cfg.lua
```

Generate certs for the domain:

```console
prosodyctl cert generate 182.61.25.227
```

Create conference focus user:

```console
prosodyctl register focus auth.182.61.25.227 auth_password
```

Restart prosody XMPP server with the new config

```console
prosodyctl restart
```

## Install nginx

```console
sudo apt-get install nginx
```

Add a new file `182.61.25.227` in `/etc/nginx/sites-available` (see also the example config file):
```
    # nano /etc/nginx/sites-available182.61.25.227
server_names_hash_bucket_size 64;

server {
    listen 80;
    server_name 182.61.25.227;
    # set the root
    root /srv/182.61.25.227;
    index index.html;
    location ~ ^/([a-zA-Z0-9=\?]+)$ {
        rewrite ^/(.*)$ / break;
    }
    location / {
        ssi on;
    }
    # BOSH
    location /http-bind {
        proxy_pass      http://localhost:5280/http-bind;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header Host $http_host;
    }
}
```

Add link for the added configuration

```console
cd /etc/nginx/sites-enabled
ln -s ../sites-available/182.61.25.227 182.61.25.227
```

## Install Jitsi Videobridge

```console
wget https://download.jitsi.org/jitsi-videobridge/linux/jitsi-videobridge-linux-x64-725.zip
unzip jitsi-videobridge-linux-x64-725.zip
```

Install Oracle JDK if missing:

```console
sudo apt-get install -y python-software-properties  software-properties-common

sudo add-apt-repository ppa:webupd8team/java

sudo apt-get update

sudo apt-get install oracle-java7-installer

echo 'export JAVA_HOME=/usr/lib/jvm/java-7-oracle' >> /etc/profile
echo 'export JRE_HOME=${JAVA_HOME}/jre' >> /etc/profile
echo 'export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib' >> /etc/profile
echo 'export PATH=${JAVA_HOME}/bin:$PATH' >> /etc/profile

update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-7-oracle/bin/java 300
update-alternatives --config java
```

_NOTE: When installing on older Debian releases keep in mind that you need JRE >= 1.7._

In the user home that will be starting Jitsi Videobridge create `.sip-communicator` folder and add the file `sip-communicator.properties` with one line in it:

```
org.jitsi.impl.neomedia.transform.srtp.SRTPCryptoContext.checkReplay=false
```

Start the videobridge with:

```console
./jvb.sh --host=localhost --domain=182.61.25.227 --port=5347 --secret=videobridge_password &
```
Or autostart it by adding the line in `/etc/rc.local`:

```console
/bin/bash /root/jitsi-videobridge-linux-x64-725/jvb.sh --host=localhost --domain=182.61.25.227 --port=5347 --secret=videobridge_password </dev/null >> /var/log/jvb.log 2>&1
```

## Install Jitsi Conference Focus (jicofo)

```console
sudo apt-get install maven
```

Clone source from Github repo:

```console
git clone https://github.com/jitsi/jicofo.git
```
Build distribution packag

```console
mvn -U package -DskipTests -Dassembly.skipAssembly=false
```

Run jicofo:

```console
cd target
unzip jicofo-linux-x64-1.0-SNAPSHOT.zip
./jicofo-linux-x64-1.0-SNAPSHOT/jicofo.sh --domain=182.61.25.227 --secret=jicofo_password --user_domain=auth.182.61.25.227 --user_name=focus --user_password=auth_password
```

## Deploy Jitsi Meet
Checkout and configure Jitsi Meet:

```console
cd /srv
git clone https://github.com/jitsi/jitsi-meet.git
mv jitsi-meet/ 182.61.25.227
nano package.json
>change     "lib-jitsi-meet": "jitsi/lib-jitsi-meet",

"lib-jitsi-meet": "git://github.com/jitsi/lib-jitsi-meet",

```

```console
sudo apt-get install npm nodejs-legacy
cd 182.61.25.227
npm install browserify
npm install

```
Install lib-jitsi-meet

```console
git clone git://github.com/jitsi/lib-jitsi-meet ../lib-jitsi-meet
cd lib-jitsi-meet
 #nano package.json
 #change "jitsi-meet-logger": ...

>"jitsi-meet-logger": "git://github.com/jitsi/jitsi-meet-logger",

npm link

cd ../182.61.25.227
npm link lib-jitsi-meet

```

To build the Jitsi Meet application, just type

```console
make
```

Edit host names in `/srv/182.61.25.227/config.js` (see also the example config file):

```console
var config = {
    hosts: {
        domain: '182.61.25.227',
        muc: 'conference.182.61.25.227',
        bridge: 'jitsi-videobridge.182.61.25.227'
    },
    useNicks: false,
    bosh: '//182.61.25.227/http-bind', // FIXME: use xep-0156 for that
    desktopSharing: 'false' // Desktop sharing method. Can be set to 'ext', 'webrtc' or false to disable.
    //chromeExtensionId: 'diibjkoicjeejcmhdnailmkgecihlobk', // Id of desktop streamer Chrome extension
    //minChromeExtVersion: '0.1' // Required version of Chrome extension
};
```

Restart nginx to get the new configuration:

```console
invoke-rc.d nginx restart
```

## Running behind NAT
Jitsi-Videobridge can run behind a NAT, provided that all required ports are routed (forwarded) to the machine that it runs on. By default these ports are (TCP/443 or TCP/4443 and UDP 10000-20000).

The following extra lines need to be added the file `~/.sip-communicator/sip-communicator.properties` (in the home directory of the user running the videobridge):

```console
org.jitsi.videobridge.NAT_HARVESTER_LOCAL_ADDRESS=127.0.0.1
org.jitsi.videobridge.NAT_HARVESTER_PUBLIC_ADDRESS=182.61.25.227
```

So the file should look like this at the end:

```console
org.jitsi.impl.neomedia.transform.srtp.SRTPCryptoContext.checkReplay=false
org.jitsi.videobridge.NAT_HARVESTER_LOCAL_ADDRESS=127.0.0.1
org.jitsi.videobridge.NAT_HARVESTER_PUBLIC_ADDRESS=182.61.25.227
```

## Hold your first conference
You are now all set and ready to have your first meet by going to http://182.61.25.227


## Enabling recording
Currently recording is only supported for linux-64 and macos. To enable it, add
the following properties to sip-communicator.properties:

```console
org.jitsi.videobridge.ENABLE_MEDIA_RECORDING=true
org.jitsi.videobridge.MEDIA_RECORDING_PATH=/path/to/recordings/dir
org.jitsi.videobridge.MEDIA_RECORDING_TOKEN=secret
```

where /path/to/recordings/dir is the path to a pre-existing directory where recordings
will be stored (needs to be writeable by the user running jitsi-videobridge),
and "secret" is a string which will be used for authentication.

Then, edit the Jitsi-Meet config.js file and set:

```console
enableRecording: true
```

Restart jitsi-videobridge and start a new conference (making sure that the page
is reloaded with the new config.js) -- the organizer of the conference should
now have a "recording" button in the floating menu, near the "mute" button.