#!/usr/bin/env bash

set -e

: "${BUCKET_NAME:?must be set}"
: "${SYNC_INTERVAL:?must be set}"

while :;
do
    rsync -av --delete clojars.org::clojars .
    #echo 'aws s3 sync' || continue
    sleep ${SYNC_INTERVAL}
done

