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

#### (Re)start node app and nginx server
systemctl restart notejam
systemctl restart nginx

#### Delete config templates
rm -rf $DEPLOYMENT_CONFIG_DIR/

exit 0
