#!/bin/bash

ulimit -n 120000

docker run -it --rm \
    -p 26657:26657 \
    -p 10337:10337 \
    -v $(pwd)/injective-1:/apps/data/injective-1 \
    public.ecr.aws/l9h3g6c6/injective-core:v1.16.2-devnetify.3 injectived \
    --log-level "info" \
    --home "./injective-1" \
    start
