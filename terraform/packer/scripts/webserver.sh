#!/bin/bash
set -x

###############################################################################################################################
##
## UPDATE SYSTEM - NON-INTERACTIVE MODE
## https://devops.stackexchange.com/questions/1139/how-to-avoid-interactive-dialogs-when-running-apt-get-upgrade-y-in-ubuntu-16
## https://askubuntu.com/questions/146921/how-do-i-apt-get-y-dist-upgrade-without-a-grub-config-prompt
## https://stackoverflow.com/questions/40748363/virtual-machine-apt-get-grub-issue/40751712
##
## AWS CODE DEPLOY AGENT:
## http://docs.aws.amazon.com/codedeploy/latest/userguide/codedeploy-agent-operations-install-ubuntu.html
## On Ubuntu Server 16.04:
## bucket-name is the name of the Amazon S3 bucket that contains the AWS CodeDeploy Resource Kit files for your region.
## wget https://bucket-name.s3.amazonaws.com/latest/install
## For example, for the US East (Ohio) Region, replace bucket-name with aws-codedeploy-us-east-2.
## For a list of bucket names, see Resource Kit Bucket Names by Region.
## To check that the service is running, run the following command: sudo service codedeploy-agent status
##
###############################################################################################################################

#### CONFIG VARS
CODE_DEPLOY_AGENT_BUCKET=aws-codedeploy-us-east-1.s3.amazonaws.com
DEPLOY_APP_PATH=/var/www/html

#### ADD ADDITIONAL REPOS NEEDED
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

#### UPDATE SYSTEM
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o DPkg::options::="--force-confdef" -o DPkg::options::="--force-confold" upgrade

#### PREREQUISITES
sudo apt-get install -y curl unzip ruby

#### INSTALL NODE.JS
sudo apt-get install -y nodejs build-essential
sudo npm i -g npm

#### INSTALL NGINX
sudo apt-get install -y nginx

#### CLEANUP for AWS CodeDeploy
sudo mv $DEPLOY_APP_PATH $DEPLOY_APP_PATH.bak


#### INSTALL NON-APT PACKAGES ####
mkdir -p ~/tmp
cd ~/tmp

# ## AWS CLI - not needed currently (no sync of keys from S3)
# sudo apt-get update && sudo apt-get install -y python-dev
# curl -O https://bootstrap.pypa.io/get-pip.py
# sudo python get-pip.py
# sudo pip install awscli

## AWS CODE DEPLOY AGENT
curl -O https://$CODE_DEPLOY_AGENT_BUCKET/latest/install
chmod +x ./install
sudo ./install auto

if [ -e "/etc/init.d/codedeploy-agent.service" ]; then
  if [ ! -e /lib/systemd/system/codedeploy-agent.service ] && [ ! -e /usr/lib/systemd/system/codedeploy-agent.service ]; then
    echo "Moving CodeDeploy service file to correct location."
    sudo mv /etc/init.d/codedeploy-agent.service /lib/systemd/system/
  else
    echo "CodeDeploy service file found in both /etc/init.d and a correct systemd directory -- removing /etc/init.d one"
    sudo rm -f /etc/init.d/codedeploy-agent.service
  fi
  echo "CodeDeploy service file changed, reloading systemctl daemon."
  sudo systemctl daemon-reload
  sleep 2s
else
    echo "CodeDeploy service file not in /etc/init.d, no change made."
fi

# Set to run at boot, then start (note --now does not always work)
sudo systemctl enable codedeploy-agent

cd ~/
#### END :: INSTALL NON-APT PACKAGES ####


#### CREATE deploy dir for AWS CodeDeploy (it expects an empty dir to mark installation finished)
sudo mkdir -p $DEPLOY_APP_PATH

exit 0;
