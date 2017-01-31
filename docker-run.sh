#!/bin/bash

NAMESPACE='monokal'
IMAGE='env'
TAG='latest'

docker run --privileged=true -ti --rm -v ~/.ssh:/root/.ssh "${NAMESPACE}/${IMAGE}:${TAG}"
