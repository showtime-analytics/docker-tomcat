#!/bin/bash

source $(dirname $0)/variables.sh

cd $(dirname $0)/..

if [ -z ${GO_PIPELINE_COUNTER+x} ]; then
    echo "Environment variable \"GO_PIPELINE_COUNTER\" does not exist!"
    exit 1
fi

if [ ! -f build_version ]; then
    echo "File \"build_version\" not found!"
    exit 1
fi

(set -x; ./scripts/test.sh $IMAGE_NAME `cat build_version` ${IMAGE_NAME}-${GO_PIPELINE_COUNTER})