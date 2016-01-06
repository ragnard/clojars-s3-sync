# clojars-s3-sync

Synchronise the [clojars](https://clojars.org) repository to an s3
bucket.

## Why?

An S3 bucket with static website hosting enabled provides a simple and highly available way of mirroring clojars. This repo provides a docker image that can replicate the clojars repository to an s3 bucket of your choice.

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

## S3 bucket configuration

To use the s3 bucket as a mirror, it needs to be configured for statis website hosting, and have the appropriate permissions set.

This bucket policy will allow anyone to get objects, which is what is required to use it as a mirror.

```json
{
	"Version": "2012-10-17",
	"Id": "Policy1452088453823",
	"Statement": [
		{
			"Sid": "Stmt1452088451255",
			"Effect": "Allow",
			"Principal": "*",
			"Action": "s3:GetObject",
			"Resource": "arn:aws:s3:::name-of-bucket/*"
		}
	]
}
```
