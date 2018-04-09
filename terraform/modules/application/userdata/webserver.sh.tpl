#!/bin/bash

#### EFS SETUP
apt-get -y install nfs-common
mkdir -p /efs
chown ubuntu:ubuntu /efs
FSTAB_EFS_MOUNT_STRING="${efs_dns_name}:/ /efs nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 0 0"
echo $FSTAB_EFS_MOUNT_STRING | sudo tee -a /etc/fstab
mount -a -t nfs4

## DataDog logging agent - install & add to 'adm' group for getting logs R/O access
DD_API_KEY=${datadog_api_key} bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"
usermod -a -G adm dd-agent

## Enable status check for nginx (via localhost only)
cat <<EOF > /etc/nginx/conf.d/status.conf
server {
  listen 81;
  server_name localhost;

  access_log off;
  allow 127.0.0.1;
  deny all;

  location /nginx_status {
    # Choose your status module

    # freely available with open source NGINX
    stub_status;

    # available only with NGINX Plus
    # status;
  }
}
EOF


#### Datadog config
DATADOG_YAML='/etc/datadog-agent/datadog.yaml'

## Enable logs collection in datadog
MATCH='# logs_enabled: false'
INSERT='logs_enabled: true'
sed -i "s/$MATCH/$MATCH\n\n$INSERT\n/" $DATADOG_YAML

## Enable collecting data about system processes for debugging bottlenecks
cat <<EOM >> $DATADOG_YAML

process_config:
  enabled: "true"
EOM


## Enable system logs collection
DD_SYSLOG_CONF_DIR=/etc/datadog-agent/conf.d/syslog.d
mkdir -p $${DD_SYSLOG_CONF_DIR}
cat <<EOF > $${DD_SYSLOG_CONF_DIR}/conf.yaml
logs:
  - type: file
    path: /var/log/syslog
    service: system
    source: syslog
    sourcecategory: system_logs
EOF


## Enable nginx status and logs collection
DD_NGINX_CONF_DIR=/etc/datadog-agent/conf.d/nginx.d
mkdir -p $${DD_NGINX_CONF_DIR}
cat <<EOF > $${DD_NGINX_CONF_DIR}/conf.yaml
init_config:

instances:
  - nginx_status_url: http://localhost:81/nginx_status/

logs:
  - type: file
    path: /var/log/nginx/access.log
    service: nginx
    source: nginx
    sourcecategory: http_web_access

  - type: file
    path: /var/log/nginx/error.log
    service: nginx
    source: nginx
    sourcecategory: http_web_access
EOF


## Restart services whose configs have changed
systemctl restart nginx
systemctl restart datadog-agent

#### CREATE deploy dir for AWS CodeDeploy (it expects an empty dir to mark installation finished)
DEPLOY_APP_PATH=/var/www/html
mkdir -p $DEPLOY_APP_PATH
chown www-data:www-data $DEPLOY_APP_PATH

exit 0;
