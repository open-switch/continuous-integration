#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

set -x

pushd src/DEBIAN
  v="$(grep ^Version: control)"
  if [[ $v == *"+"* ]]; then s="."; else s="+"; fi
  v="${s}git$(date +%Y%m%d).$(git rev-parse --short HEAD)"
  sed -i '/^Version: / s/$/'"$v"'/' control
popd

rsync -a src/ src-artifacts
