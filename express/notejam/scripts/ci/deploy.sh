#!/bin/bash
set -e

# install dependencies
sudo apt install -y python-dev
sudo npm install aws-code-deploy -g

# target environment base on the source branch
case ${CIRCLE_BRANCH} in
  "master")
    ENV=prod ;;
  "release/*")
    ENV=stg ;;
  "dev" | *)
    ENV=dev ;;
esac

export AWS_CODE_DEPLOY_REGION=us-east-1
export AWS_CODE_DEPLOY_APPLICATION_NAME=ToptalDevOpsScreening.Notejam
export AWS_CODE_DEPLOY_DEPLOYMENT_GROUP_NAME=ToptalDevOpsScreening.Notejam-deploy-${ENV}
export AWS_CODE_DEPLOY_DEPLOYMENT_CONFIG_NAME=CodeDeployDefault.AllAtOnce
export AWS_CODE_DEPLOY_APP_SOURCE=$(pwd)
export AWS_CODE_DEPLOY_S3_BUCKET=toptal.devops.codedeploy
export AWS_CODE_DEPLOY_S3_KEY_PREFIX=notejam/${CIRCLE_BRANCH}
export AWS_CODE_DEPLOY_S3_FILENAME=notejam__build-${CIRCLE_BUILD_NUM}__${CIRCLE_SHA1:0:7}.zip
export AWS_CODE_DEPLOY_S3_LIMIT_BUCKET_FILES=7
export AWS_CODE_DEPLOY_OUTPUT_STATUS_LIVE=false
export AWS_CODE_DEPLOY_DEPLOYMENT_OVERVIEW=false

npm install --only=production
node db.js

aws-code-deploy

exit 0;
