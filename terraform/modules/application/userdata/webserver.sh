#!/bin/bash

## DataDog logging agent
DD_API_KEY={{DATADOG_API_KEY}} bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"


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


## Enable logs collection in datadog
MATCH='# logs_enabled: false'
INSERT='logs_enabled: true'
DATADOG_YAML='/etc/datadog-agent/datadog.yaml'
sed -i "s/$MATCH/$MATCH\n\n$INSERT\n/" $DATADOG_YAML


## Enable nginx status and logs collection
chmod a+x /var/log/nginx
chmod a+r /var/log/nginx/*
cat <<EOF > /etc/datadog-agent/conf.d/nginx.d/conf.yaml
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

exit 0;
