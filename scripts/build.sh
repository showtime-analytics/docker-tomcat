#!/bin/bash

DOCKER_REGISTRY=$1
IMAGE_NAME=$2
VERSION=$3

cd $(dirname $0)/..

PROJECT_NAME=$(basename `pwd`)

: ${IMAGE_NAME:=${PROJECT_NAME}}
: ${VERSION:=`cat version`}

if [ -z ${DOCKER_REGISTRY} ]; then
    REPOSITORY=${IMAGE_NAME}
else
    REPOSITORY="${DOCKER_REGISTRY}/${IMAGE_NAME}"
fi

(set -x; docker build --no-cache=true --tag="${REPOSITORY}:${VERSION}" .)