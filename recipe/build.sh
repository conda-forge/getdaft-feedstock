#!/usr/bin/env bash

set -euo pipefail
export OPENSSL_DIR=${PREFIX}
export OPENSSL_NO_VENDOR=1

# build dashboard assets using bun
cd daft
pushd ./src/daft-dashboard/frontend
${SRC_DIR}/bun/bun install
${SRC_DIR}/bun/bun run build
popd

cargo-bundle-licenses --format yaml --output THIRDPARTY.yml
${PYTHON} -m pip install . -vv --no-deps --no-build-isolation
