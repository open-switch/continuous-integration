#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

set -x

rsync -a opx-onie-installer/ /mnt/opx-onie-installer
pushd /mnt
  /opt/opx-build/scripts/opx_rel_pkgasm.py \
    -b opx-onie-installer/release_bp/OPX_dell_base.xml \
    --dist "$DIST" -n 0
popd

find /mnt -name 'PKGS*' -exec mv -t opx-onie-installer-artifacts/ {} +
