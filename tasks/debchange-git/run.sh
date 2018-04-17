#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

set -x

pushd src
  # bump version with date and git sha
  v="$(dpkg-parsechangelog -SVersion)"
  if [[ $v == *"+"* ]]; then s="."; else s="+"; fi
  v="${v}${s}git$(date +%Y%m%d).$(git rev-parse --short HEAD)"
  debchange \
    --newversion "$v" \
    --distribution unstable \
    --controlmaint \
    "$(git log --oneline -1)"
popd

rsync -a src/ src-artifacts
