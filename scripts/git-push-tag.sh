#!/bin/bash

cd $(dirname $0)/..

VERSION=$1

: ${VERSION:=`cat version`}

set -x

git tag -f ${VERSION}
git push origin ${VERSION}