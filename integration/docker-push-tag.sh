#!/bin/bash

source $(dirname $0)/variables.sh

cd $(dirname $0)/..

if [ -z ${DOCKER_REGISTRY+x} ]; then
    echo "Environment variable \"GO_PIPELINE_COUNTER\" does not exist!"
    exit 1
fi

if [ ! -f build_version ]; then
    echo "File \"build_version\" not found!"
    exit 1
fi

if [ ! -f version ]; then
    echo "File \"version\" not found!"
    exit 1
fi

REPOSITORY=${DOCKER_REGISTRY}/${IMAGE_NAME}
BUILD_TAG=`cat build_version`
RELEASE_TAG=`cat version`

set -x

if [ $DOCKER_REGISTRY = "showtimeanalytics" ]; then
    docker login --email="${DOCKER_HUB_EMAIL}" --username="${DOCKER_HUB_USERNAME}" --password="${DOCKER_HUB_PASSWORD}"
fi


# Push build version
docker tag -f ${IMAGE_NAME}:${BUILD_TAG} ${REPOSITORY}:${BUILD_TAG}
docker push ${REPOSITORY}:${BUILD_TAG}

# Push release version
docker tag -f ${IMAGE_NAME}:${BUILD_TAG} ${REPOSITORY}:${RELEASE_TAG}
docker push ${REPOSITORY}:${RELEASE_TAG}

# Clean images
docker rmi ${REPOSITORY}:${RELEASE_TAG}
docker rmi ${REPOSITORY}:${BUILD_TAG}
docker rmi ${IMAGE_NAME}:${BUILD_TAG}
