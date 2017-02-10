docker-sickrage
================

Alpine based sickrage.  Just sickrage.  

Complete run command with all options

    docker run -d -p 8081:8081 \
    	--restart=unless-stopped
        -v /myconfgidir:/config \
        -v /mydownloaddir:/downloads \
        -v /mytvdir:/tv \
        -v /myblackholedir:/blackhole \
        -e PUID=500 -e PGID=500 \
        jbogatay/sickrage


Change directory mappings as appropriate (myconfigdir, mydownloaddir, tv, blackhole).

APP_UID and APP_GID are optional, but will default to 911/911.   Specify the UID/GID that corresponds to the **HOST** UID/GID you want to own the downloads, config and tv directories.