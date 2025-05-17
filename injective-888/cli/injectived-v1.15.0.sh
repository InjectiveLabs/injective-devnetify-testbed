#!/bin/bash

ulimit -n 120000

docker run -it --rm \
    -p 26657:26657 \
    -p 10337:10337 \
    -v $(pwd)/injective-888:/apps/data/injective-888 \
    public.ecr.aws/l9h3g6c6/injective-core:v1.15.0-devnetify injectived \
    --log-level "info" \
    --home "./injective-888" \
    start
