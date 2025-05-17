#!/bin/bash

ulimit -n 120000

docker run -it --rm \
    -v $(pwd)/injective-888:/apps/data/injective-888 \
    public.ecr.aws/l9h3g6c6/injective-core:v1.15.0-devnetify injectived \
    --home "./injective-888" \
    ${*:-"query"}
