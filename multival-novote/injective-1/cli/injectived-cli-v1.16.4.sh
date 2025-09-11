#!/bin/bash

docker run -it --rm \
    -v $(pwd)/injective-1:/apps/data/injective-1 \
    injectivelabs/injective-core:v1.16.4 injectived \
    --home "./injective-1/validators/0" \
    ${*:-"query"}
