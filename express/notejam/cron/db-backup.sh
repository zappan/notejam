#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${SCRIPT_DIR}/../

TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
HOSTNAME=$(hostname)
APP_DIR=$(pwd)
DB_FILE=notejam.db
ENV=$(cat ${APP_DIR}/env.txt)

BACKUP_FILENAME=${TIMESTAMP}_${HOSTNAME}_notejam-db.tar.gz
BACKUP_LOCAL_PATH=/tmp/${BACKUP_FILENAME}
BACKUP_S3_PATH=s3://topal.devops.notejam.backup/${ENV}/${BACKUP_FILENAME}

tar -czf $BACKUP_LOCAL_PATH -C $APP_DIR $DB_FILE
/usr/local/bin/aws s3 cp $BACKUP_LOCAL_PATH $BACKUP_S3_PATH --quiet
rm ${BACKUP_LOCAL_PATH}

exit 0
