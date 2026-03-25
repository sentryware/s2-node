#!/bin/bash

set -ex

export DOCKER_DEFAULT_PLATFORM="${DOCKER_DEFAULT_PLATFORM:-linux/amd64}"

for node in 24 22 20
do
  docker run -i --rm \
    -e AWS_DEFAULT_REGION \
    -e AWS_ACCESS_KEY_ID \
    -e AWS_SECRET_ACCESS_KEY \
    -e AWS_SESSION_TOKEN \
    node:$node \
    bash -c 'mkdir /app && cd /app && tar xf - && npm install && JOBS=max npx node-pre-gyp rebuild package unpublish publish' \
    < <(tar cf - --exclude-from=.dockerignore .)
done
