#!/bin/bash

cd $(dirname $0)/..

if [ ! -f build_version ]; then
    echo "File \"build_version\" not found!"
    exit 1
fi

set -x

git tag -f `cat build_version`
git push origin `cat build_version`