#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

set -x

dpkg-deb -b src src-artifacts
