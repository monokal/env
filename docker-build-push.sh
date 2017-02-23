#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: ${0} <TAG>"
    echo "E.g: ${0} latest"
    exit 1
fi

NAMESPACE='monokal'
IMAGE='env'
TAG="${1}"

echo "${IMAGE} > Building \"${IMAGE}:${TAG}\" image..." && \
docker build -t "${NAMESPACE}/${IMAGE}:${TAG}" . && \
echo "${IMAGE} > Pushing \"${IMAGE}:${TAG}\" image..." && \
docker login -u "${NAMESPACE}" && \
docker push "${NAMESPACE}/${IMAGE}:${TAG}" && \
echo "${IMAGE} > Done."
