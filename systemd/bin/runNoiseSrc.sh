#!/usr/bin/env bash

set -u

if [ -z "$NOISE_SRC_INSTANCE" ]; then
    echo "NOISE_SRC_INSTANCE environment variable is not set." >&2
    exit 1
fi

export NOISE_SRC_CURRENT_PV_AREA_PREFIX=NOISE_SRC_${NOISE_SRC_INSTANCE}_PV_AREA_PREFIX
export NOISE_SRC_CURRENT_PV_DEVICE_PREFIX=NOISE_SRC_${NOISE_SRC_INSTANCE}_PV_DEVICE_PREFIX
export NOISE_SRC_CURRENT_NOISE_GEN=NOISE_SRC_${NOISE_SRC_INSTANCE}_NOISE_GEN
export NOISE_SRC_CURRENT_CARRIER_GEN=NOISE_SRC_${NOISE_SRC_INSTANCE}_CARRIER_GEN
export NOISE_SRC_CURRENT_TELNET_PORT=NOISE_SRC_${NOISE_SRC_INSTANCE}_TELNET_PORT
# Only works with bash
export NOISE_SRC_PV_AREA_PREFIX=${!NOISE_SRC_CURRENT_PV_AREA_PREFIX}
export NOISE_SRC_PV_DEVICE_PREFIX=${!NOISE_SRC_CURRENT_PV_DEVICE_PREFIX}
export NOISE_SRC_NOISE_GEN=${!NOISE_SRC_CURRENT_NOISE_GEN}
export NOISE_SRC_CARRIER_GEN=${!NOISE_SRC_CURRENT_CARRIER_GEN}
export NOISE_SRC_TELNET_PORT=${!NOISE_SRC_CURRENT_TELNET_PORT}

# Create volume for autosave and ignore errors
/usr/bin/docker create \
    -v /opt/epics/startup/ioc/tune-epics-ioc/iocBoot/iocTune/autosave \
    --name tune-epics-ioc-${NOISE_SRC_INSTANCE}-volume \
    lnlsdig/tune-epics-ioc:${IMAGE_VERSION} \
    2>/dev/null || true

# Remove a possible old and stopped container with
# the same name
/usr/bin/docker rm \
    tune-epics-ioc-${NOISE_SRC_INSTANCE} || true

/usr/bin/docker run \
    --net host \
    -t \
    --rm \
    --volumes-from tune-epics-ioc-${NOISE_SRC_INSTANCE}-volume \
    --name tune-epics-ioc-${NOISE_SRC_INSTANCE} \
    lnlsdig/tune-epics-ioc:${IMAGE_VERSION} \
    -t "${NOISE_SRC_TELNET_PORT}" \
    -n "${NOISE_SRC_NOISE_GEN}" \
    -c "${NOISE_SRC_CARRIER_GEN}" \
    -P "${NOISE_SRC_PV_AREA_PREFIX}" \
    -R "${NOISE_SRC_PV_DEVICE_PREFIX}"
