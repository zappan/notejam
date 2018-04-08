#!/bin/bash

APP_PATH=/var/www/html
NGINX_CONFIG_DIR=/etc/nginx
SYSTEMD_CONFIG_DIR=/etc/systemd

DEPLOYMENT_CONFIG_DIR=$APP_PATH/conf
DEPLOYMENT_NGINX_CONFIG_DIR=$DEPLOYMENT_CONFIG_DIR/nginx
DEPLOYMENT_SYSTEMD_CONFIG_DIR=$DEPLOYMENT_CONFIG_DIR/systemd

chown -R www-data:www-data $APP_PATH

#### CONFIG
## notejam app systemd start script
cp $DEPLOYMENT_SYSTEMD_CONFIG_DIR/system/notejam.service $SYSTEMD_CONFIG_DIR/system/notejam.service
systemctl enable notejam

## nginx site config & restart to pick up new <site.conf>
cp $DEPLOYMENT_NGINX_CONFIG_DIR/sites-available/notejam $NGINX_CONFIG_DIR/sites-available/default
cp $DEPLOYMENT_NGINX_CONFIG_DIR/conf.d/proxy.conf $NGINX_CONFIG_DIR/conf.d/

## Initialize DB if it doesn't exist
if [ ! -f ${APP_PATH}/notejam.db ]; then
  cd ${APP_PATH} && node db.js ; cd -
  chown www-data:www-data ${APP_PATH}/notejam.db
fi

#### Delete config templates
rm -rf $DEPLOYMENT_CONFIG_DIR/

#### Add app backups to cron
BACKUP_CRON_FREQ="0 4 * * *"
BACKUP_CRON_CMD="${APP_PATH}/cron/db-backup.sh"
BACKUP_CRON_JOB="$BACKUP_CRON_FREQ $BACKUP_CRON_CMD"
( crontab -u root -l | grep -v "$BACKUP_CRON_CMD" ; echo "$BACKUP_CRON_JOB" ) | crontab -u root -

exit 0
