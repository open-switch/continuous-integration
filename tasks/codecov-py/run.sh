#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

set -x

pushd src
  pip install -r requirements.txt
  pytest --cov=./
  bash <(curl -s https://codecov.io/bash)
popd

# find src -name 'opx-src_*.tar.gz' -exec mv -t src-artifacts/ {} +
