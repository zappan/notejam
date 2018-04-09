#!/bin/bash

APP_PATH=/var/www/html
EFS_PATH=/efs/var/www/html
NGINX_CONFIG_DIR=/etc/nginx
SYSTEMD_CONFIG_DIR=/etc/systemd

DEPLOYMENT_CONFIG_DIR=$APP_PATH/conf
DEPLOYMENT_NGINX_CONFIG_DIR=$DEPLOYMENT_CONFIG_DIR/nginx
DEPLOYMENT_SYSTEMD_CONFIG_DIR=$DEPLOYMENT_CONFIG_DIR/systemd

## Prepare EFS_PATH and APP_PATH
if [ ! -d $EFS_PATH ]; then
  mkdir -p $EFS_PATH
  chown www-data:www-data $EFS_PATH
fi

chown -R www-data:www-data $APP_PATH

#### CONFIG
## notejam app systemd start script
cp $DEPLOYMENT_SYSTEMD_CONFIG_DIR/system/notejam.service $SYSTEMD_CONFIG_DIR/system/notejam.service
systemctl enable notejam

## nginx site config & restart to pick up new <site.conf>
cp $DEPLOYMENT_NGINX_CONFIG_DIR/sites-available/notejam $NGINX_CONFIG_DIR/sites-available/default
cp $DEPLOYMENT_NGINX_CONFIG_DIR/conf.d/proxy.conf $NGINX_CONFIG_DIR/conf.d/

## Initialize DB on the EFS (shared) storage if it doesn't exist
if [ ! -f ${EFS_PATH}/notejam.db ]; then
  cd ${EFS_PATH} && node ${APP_PATH}/db.js ; cd -
  chown www-data:www-data ${EFS_PATH}/notejam.db
fi

## Symlink to the shared EFS DB if symlink doesn't exist
if [ ! -L ${APP_PATH}/notejam.db ]; then
  cd ${APP_PATH} && ln -s ${EFS_PATH}/notejam.db ; cd -
  chown -h www-data:www-data ${APP_PATH}/notejam.db
fi

#### Delete config templates
rm -rf $DEPLOYMENT_CONFIG_DIR/

#### Add app backups to cron
BACKUP_CRON_FREQ="0 * * * *"
BACKUP_CRON_CMD="${APP_PATH}/cron/db-backup.sh"
BACKUP_CRON_JOB="$BACKUP_CRON_FREQ $BACKUP_CRON_CMD"
( crontab -u root -l | grep -v "$BACKUP_CRON_CMD" ; echo "$BACKUP_CRON_JOB" ) | crontab -u root -

exit 0
