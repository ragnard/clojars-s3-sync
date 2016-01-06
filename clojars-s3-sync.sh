#!/usr/bin/env bash

set -e

: "${BUCKET_NAME:?must be set}"
: "${SYNC_PAUSE:?must be set}"

while :;
do
    echo "syncing clojars to local volume"
    rsync -av --delete clojars.org::clojars .

    echo "syncing s3 bucket ${BUCKET_NAME}"
    aws s3 sync . s3://${BUCKET_NAME}
    sleep ${SYNC_PAUSE}
done
