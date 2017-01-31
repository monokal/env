#!/bin/bash

NAMESPACE='monokal'
IMAGE='env'
TAG='latest'

echo "${IMAGE} > Building \"${IMAGE}:${TAG}\" image..." && \
docker build -t "${NAMESPACE}/${IMAGE}:${TAG}" . && \
echo "${IMAGE} > Pushing \"${IMAGE}:${TAG}\" image..." && \
docker push "${NAMESPACE}/${IMAGE}:${TAG}" && \
echo "${IMAGE} > Done."
