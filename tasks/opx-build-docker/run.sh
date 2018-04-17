#!/usr/bin/env bash

source /docker-lib.sh; start_docker

set -o errexit
set -o nounset
set -o pipefail

set -x

pushd opx-build
  ./docker_build.sh
  version="$(git rev-parse --short HEAD)-$DIST"
popd

docker images
docker save "opxhub/build:$DIST" -o opx-build-artifacts/image.tar
echo "$version" >opx-build-artifacts/version
echo "$DIST" >opx-build-artifacts/tags
