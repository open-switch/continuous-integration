#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

set -x

./build.sh "$DIST" amd64

find /mnt -name 'opx-rootfs_*.tar.gz' -exec mv -t rootfs-artifacts/ {} +
