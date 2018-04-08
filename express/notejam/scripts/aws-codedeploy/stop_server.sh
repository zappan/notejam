#!/bin/bash

IS_EXIST_NGINX=`pgrep nginx`
if [[ -n  $IS_EXIST_NGINX ]]; then
  systemctl stop nginx
fi

IS_EXIST_NODE=`pgrep node`
if [[ -n  $IS_EXIST_NODE ]]; then
  systemctl stop notejam
fi
