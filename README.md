# docker-derbynet

**Application**

Unraid docker instance of the Cubscout Pinewood Derby cloud based derbynet-server race management tool created by Jeff Piazza

http://jeffpiazza.github.io/derbynet/

**Description**

DerbyNet is the new standard in race management software for Pinewood Derby events. It's free, and it's open source. With DerbyNet, multiple browsers connect to a web server running on your laptop or in the cloud.  

Docs:
/usr/share/derbynet/docs

Config Locations:
/etc/derbynet.conf
/var/lib/derbynet/

**Build notes**

Latest stable jeffpiazza release from GitHub.

**Usage**
Make sure your client machines such as photo and timer utilize the same passwords set at run.

docker run -d \
    -p 8050:80 \
    -p 8051:443 \
    --name=<container name> \
    -v <local path for data files>:/var/lib/derbynet \
    -v /etc/localtime:/etc/localtime:ro \
    -e TIMER_PASSWORD=<password> \
    -e RACE_CREW_PASSWORD=<password> \
    -e RACE_COORD_PASSWORD=<password> \
    -e PHOTO_PASSWORD=<password> \
    -e UMASK=<umask for created files> \
    -e PUID=<uid for user> \
    -e PGID=<gid for user> \
    mitchellriley/docker-derbynet_server
```

Please replace all user variables in the above command defined by <> with the correct values.

**Access application**

`http://<host ip>:8050`

**Example**
The following example employs the default passwords the clients are using:

docker run -d \
    -p 8050:80 \
    --name=derbynet_server \
    -v /apps/docker/derbynet/data:/var/lib/derbynet \
    -v /etc/localtime:/etc/localtime:ro \
    -e TIMER_PASSWORD="" \
    -e RACE_CREW_PASSWORD=murphy \
    -e RACE_COORD_PASSWORD=doyourbest \
    -e PHOTO_PASSWORD=flashbulb \
    -e UMASK=000 \
    -e PUID=0 \
    -e PGID=0 \
    mitchellriley/docker-derbynet_server
```

**Notes**

User ID (PUID) and Group ID (PGID) can be found by issuing the following command for the user you want to run the container as:-

I would recommend using the letsencrypt docker to handle encryption and proxy for the port 80 of this docker rather than the self signed certs via the docker port 443
```
id <username>
```
___

[Documentation](https://jeffpiazza.org/derbynet/builds/Installation-%20Debian.pdf)
