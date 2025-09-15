#!/bin/bash

UPGRADE_HANDLER_VERSION=${UPGRADE_HANDLER_VERSION:-""}

injectived devnetify \
    --home ./injective-888/validators/0 \
    -y -O ./injective-888/custom_overrides.yaml \
    -V ./injective-888/validators \
    -K ./injective-888/instances/0/accounts.json \
    $([ ! -z "${UPGRADE_HANDLER_VERSION}" ] && echo "-u ${UPGRADE_HANDLER_VERSION}") \
    injective-888
