#!/usr/bin/env bash

set -euo pipefail
export OPENSSL_DIR=${PREFIX}
export OPENSSL_NO_VENDOR=1

# install bun
curl -fsSL https://bun.sh/install | bash

# build dashboard assets using bun
pushd ./src/daft-dashboard/frontend
~/.bun/bin/bun install
~/.bun/bin/bun run build
popd

cargo-bundle-licenses --format yaml --output THIRDPARTY.yml
${PYTHON} -m pip install . -vv --no-deps --no-build-isolation
