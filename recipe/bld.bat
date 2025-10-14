set OPENSSL_DIR=%LIBRARY_PREFIX%
set OPENSSL_NO_VENDOR=1

cargo-bundle-licenses --format yaml --output THIRDPARTY.yml
%PYTHON% -m pip install . -vv --no-deps --no-build-isolation
