#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

set -x

pushd rootfs
  ./build.sh "$DIST" amd64
popd

find rootfs -name 'opx-rootfs_*.tar.gz' -exec mv -t rootfs-artifacts/ {} +
