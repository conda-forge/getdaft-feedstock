#!/usr/bin/env bash

set -euo pipefail
export OPENSSL_DIR=${PREFIX}
export OPENSSL_NO_VENDOR=1

# build dashboard assets using bun
pushd ./src/daft-dashboard/frontend
npm install
npm run build
popd

# aws-lc-sys jitterentropy raises when compiled with -02
for var in $(env | grep -o '^CFLAGS[^=]*'); do
    eval "export $var=\"$(eval echo \$$var | sed 's/-O[0-3]/-O0/g')\""
done

# export AWS_LC_SYS_NO_JITTER_ENTROPY=1

cargo-bundle-licenses --format yaml --output THIRDPARTY.yml
${PYTHON} -m pip install . -vv --no-deps --no-build-isolation
