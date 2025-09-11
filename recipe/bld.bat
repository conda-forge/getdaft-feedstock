set OPENSSL_DIR=%LIBRARY_PREFIX%
set OPENSSL_NO_VENDOR=1

REM install bun
powershell -c "irm bun.sh/install.ps1|iex"

REM build dashboard assets using bun
pushd .\src\daft-dashboard\frontend
"$env:USERPROFILE\.bun\bin\bun" install
"$env:USERPROFILE\.bun\bin\bun" run build
popd

cargo-bundle-licenses --format yaml --output THIRDPARTY.yml
%PYTHON% -m pip install . -vv --no-deps --no-build-isolation
