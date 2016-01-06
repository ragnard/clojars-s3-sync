# clojars-s3-sync

Synchronize the [clojars](https://clojars.org) repository to an s3
bucket.

## Requirements

- an AWS account
- docker
- a persistent volume with enough space for all of clojars (currently ~30G)

## Usage

1. Create an S3 bucket. Ensure that whoever will be running the container has read/write access to this bucket.
2. Run the `clojars-s3-sync` docker image:
  -  mount a persistent volume at `/clojars`
  -  specifying the following options:
    - `BUCKET_NAME`: name of s3 bucket to synchronise to
    - `SYNC_PAUSE`: time in seconds to wait between synchronisation attempts
  
  Example:
  
  ```sh
  $ docker run -v /mnt/clojars:/clojars \
               -e BUCKET_NAME=my-bucket \
               -e SYNC_PAUSE=600 \
               ragge/clojars-s3-sync
  ```

