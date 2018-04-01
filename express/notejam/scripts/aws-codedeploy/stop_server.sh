#!/bin/bash

IS_EXIST_NGINX=`pgrep nginx`
if [[ -n  $IS_EXIST_NGINX ]]; then
  systemctl stop nginx
fi

