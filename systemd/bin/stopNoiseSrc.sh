#!/usr/bin/env bash

set -u

if [ -z "$NOISE_SRC_INSTANCE" ]; then
    echo "NOISE_SRC_INSTANCE environment variable is not set." >&2
    exit 1
fi

/usr/bin/docker stop \
    noise-src-epics-ioc-${NOISE_SRC_INSTANCE}
