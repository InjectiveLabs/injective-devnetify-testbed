#!/bin/bash

docker run -it --rm \
    -v $(pwd)/injective-888:/apps/data/injective-888 \
    injectivelabs/injective-core:v1.16.4 injectived \
    --home "./injective-888/validators/0" \
    ${*:-"query"}
