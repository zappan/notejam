#!/bin/bash

at -M now + 2 minute <<< $'systemctl restart codedeploy-agent' > /dev/null 2>&1
