#!/bin/sh
set -e

if [ ! -d  /app/.git ];  then

   echo "Performing first time setup"

   if [ -z "$APP_UID" ]; then
      echo "[warn] APP_UID using default of 500"
      APP_UID=500
   fi

   if [ -z "$APP_GID" ]; then
      echo "[warn] APP_GID using default of 500"
      APP_GID=500
   fi
   
   # add user
   addgroup -g $APP_GID appuser
   adduser -s /bin/sh -h /app -G appuser -u $APP_UID -D appuser

   #clone it
   mkdir -p /config /tv /downloads /app

   git clone https://github.com/SickRage/SickRage.git /app

   chown -R $APP_UID:$APP_GID /config
   chown -R $APP_UID:$APP_GID /downloads
   chown -R $APP_UID:$APP_GID /tv
   chown -R $APP_UID:$APP_GID /app

fi


# spin it up
exec su appuser -c "/usr/bin/python2.7 /app/SickBeard.py --config=/config/config.ini --datadir=/config/data" 
                          