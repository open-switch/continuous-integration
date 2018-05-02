#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

set -x

rsync -a rootfs-tarball/opx-rootfs_*.tar.gz rootfs-artifacts/rootfs.tar.gz
echo "$(cat rootfs/VERSION)-$DIST" >rootfs-artifacts/version
echo "$DIST" >rootfs-artifacts/tags
