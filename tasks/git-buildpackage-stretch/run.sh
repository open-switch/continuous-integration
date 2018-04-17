#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

set -x

rsync -a src/ /mnt/src
pushd /mnt
  /opt/opx-build/scripts/opx_build src
popd

find /mnt/pool \( -name '*.deb' -o -name '*.dsc' -o -name '*.changes' -o -name '*.tar.gz' -o -name '*.build' -o -name '*.buildinfo' \) \
  -exec cp -t src-artifacts/ {} +
