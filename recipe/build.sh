#!/usr/bin/env bash

set -euo pipefail
export OPENSSL_DIR=${PREFIX}
export OPENSSL_NO_VENDOR=1

cargo-bundle-licenses --format yaml --output THIRDPARTY.yml
${PYTHON} -m pip install . -vv --no-deps --no-build-isolation
