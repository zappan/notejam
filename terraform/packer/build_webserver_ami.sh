#!/bin/bash

set -e

packer build \
  -var "aws_access_key=$AWS_ACCESS_KEY" \
  -var "aws_secret_key=$AWS_SECRET_KEY" \
  packer/templates/webserver.json | tee packer/logs/packer_output.log

cat packer/logs/packer_output.log | tail -n 2 \
  | sed '$ d' \
  | sed "s/us-east-1: /packer_webserver_ami = \"/" \
  | sed -e 's/[[:space:]]*$/\"/' > _packer_webserver_ami.auto.tfvars

cat _packer_webserver_ami.auto.tfvars
