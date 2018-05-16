#!/usr/bin/env bash

if [[ -n "$SUFFIX" ]]; then
  SUFFIX="-s '$SUFFIX'"
else
  SUFFIX=""
fi

set -o errexit
set -o nounset
set -o pipefail

set -x

rsync -a opx-onie-installer/ /mnt/opx-onie-installer

pushd /mnt
  /opt/opx-build/scripts/opx_rel_pkgasm.py \
    -b opx-onie-installer/release_bp/OPX_dell_base.xml \
    --dist "$OPX_RELEASE" -n 0 $SUFFIX

  for f in PKGS_OPX-*.bin; do
    sha256sum "$f" >"$f.sha256"
  done
popd

find /mnt -name 'PKGS*' -exec mv -t opx-onie-installer-artifacts/ {} +
ls -lh opx-onie-installer-artifacts/
