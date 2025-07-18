#!/bin/bash

ulimit -n 120000

docker run -it --rm \
    -p 26657:26657 \
    -p 10337:10337 \
    -v $(pwd)/.injectived:/apps/data/injective-888 \
    public.ecr.aws/l9h3g6c6/injective-core:v1.16.0-beta.2 injectived \
    --log-level "info" \
    --home "./injective-888" \
    start
