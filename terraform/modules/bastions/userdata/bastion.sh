#!/bin/bash

## DataDog logging agent
DD_API_KEY={{DATADOG_API_KEY}} bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"

exit 0;
