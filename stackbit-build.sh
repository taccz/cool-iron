#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5e544cf4f5c3d400197e5d5c/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5e544cf4f5c3d400197e5d5c 
fi
curl -s -X POST https://api.stackbit.com/project/5e544cf4f5c3d400197e5d5c/webhook/build/ssgbuild > /dev/null
gatsby build
./inject-netlify-identity-widget.js public
curl -s -X POST https://api.stackbit.com/project/5e544cf4f5c3d400197e5d5c/webhook/build/publish > /dev/null
