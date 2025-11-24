#!/bin/sh

DATE=$(date +%H-%M-%S)
BACKUP=db-$DATE.sql
# MariaDB variables
DB_HOST=$1
DB_PASSWORD=$2
DB_NAME=$3

# AWS variables
AWS_ID=$4
AWS_SECRET=$5
BUCKET_NAME=$6

mariadb-dump -u root -h $DB_HOST -p$DB_PASSWORD  $DB_NAME > /tmp/$BACKUP && \
export AWS_ACCESS_KEY_ID=$AWS_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET
echo "Uploading your backup of $DB_NAME at $(date)"
aws s3 cp /tmp/db-$DATE.sql s3://$BUCKET_NAME/$BACKUP