#!/bin/bash
set -e


# only run the uid/gid creation on first run
if [ ! -f /app/runonce ]; then

   echo "Performing first time setup"
   
   #sanity check uid/gid
   if [ $SICK_UID -ne 0 -o $SICK_UID -eq 0 2>/dev/null ]; then
      if [ $SICK_UID -lt 100 -o $SICK_UID -gt 65535 ]; then
         echo "[warn] SICK_UID out of (100..65535) range, using default of 500"
         SICK_UID=500
      fi
   else
      echo "[warn] SICK_UID non-integer detected, using default of 500"
      SICK_UID=500
   fi

   if [ $SICK_GID -ne 0 -o $SICK_GID -eq 0 2>/dev/null ]; then
      if [ $SICK_GID -lt 100 -o $SICK_GID -gt 65535 ]; then
         echo "[warn] SICK_GID out of (100..65535) range, using default of 500"
         SICK_GID=500
      fi
   else
      echo "[warn] SICK_GID non-integer detected, using default of 500"
      SICK_GID=500
   fi

   # add UID/GID or use existing
   groupadd --gid $SICK_GID sickrage || echo "Using existing group $SICK_GID"
   useradd --gid $SICK_GID --no-create-home --uid $SICK_UID sickrage
   
   # set runonce so it... runs once
   touch /app/runonce

fi

# make nzbget destination directory and take control of folders
mkdir -p /config /tv /downloads /sickrage

if [ -d /sickrage/.git ]; then
  cd /sickrage && git pull
else
  git clone https://github.com/SickRage/SickRage.git /sickrage
fi


chown -R $SICK_UID:$SICK_GID /config
chown -R $SICK_UID:$SICK_GID /downloads
chown -R $SICK_UID:$SICK_GID /tv
chown -R $SICK_UID:$SICK_GID /sickrage


# spin it up
exec su sickrage -c "/usr/bin/python2.7 /sickrage/SickBeard.py --config=/config/config.ini --datadir=/config/data"
                          