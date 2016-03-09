#!/bin/bash

REPOSITORY=$1
VERSION=$2
CONTAINER_NAME=$3

cd $(dirname $0)/..

PROJECT_NAME=$(basename `pwd`)

: ${REPOSITORY:=${PROJECT_NAME}}
: ${VERSION:=`cat version`}
: ${CONTAINER_NAME:=${PROJECT_NAME}}

set -x

# Run container to test
docker run -d --name=${CONTAINER_NAME} ${REPOSITORY}:${VERSION} bash -c "catalina.sh run"

sleep 5

test="`docker exec -i ${CONTAINER_NAME} curl -i 127.0.0.1:8080 &> /dev/null; echo $?`"

# Clean container
docker stop ${CONTAINER_NAME}
docker rm ${CONTAINER_NAME}

exit $test