docker-sickrage
================

Alpine based sickrage.  Just sickrage.  Under 85MB.

Complete run command with all options

    docker run -d -p 8081:8081 \
    	--restart=always
        -v /myconfgidir:/config \
        -v /mydownloaddir:/downloads \
        -v /mytvdir:/tv \
        -v /myblackholedir:/blackhole \
        -v /etc/localtime:/etc/localtime:ro \
        -e APP_UID=500 -e APP_GID=500 \
        jbogatay/sickrage


Change directory mappings as appropriate (myconfigdir, mydownloaddir, tv, blackhole).

APP_UID and APP_GID are optional, but will default to 500/500.   Specify the UID/GID that corresponds to the **HOST** UID/GID you want to own the downloads, config and tv directories.