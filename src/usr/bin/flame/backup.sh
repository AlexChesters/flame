#!/bin/bash
set -e

export AWS_ACCESS_KEY_ID=$1
export AWS_SECRET_ACCESS_KEY=$2
export DB_ROOT_PASSWORD=$3

YEAR=$(date "+%Y")
MONTH=$(date "+%m")
DATE=$(date "+%d")

function log ()
{
  msg=$1
  timestamp=$(date "+%Y-%m-%d %H:%M")
  echo "$timestamp - $msg"
}

log "[INFO] - starting flame backup"

zip -r -9 /tmp/flame.zip /data/compose/26/data

/usr/local/bin/aws s3 cp \
  /tmp/flame.zip \
  s3://flame-backups-bucket/$YEAR/$MONTH/$DATE/backup.zip
/usr/local/bin/aws cloudwatch put-metric-data \
  --namespace flame-backups \
  --metric-data MetricName=BackupCompleted,Unit=Count,Value=1,StorageResolution=60 \
  --region eu-west-1

log "[SUCCESS] - uploaded backup to S3"
