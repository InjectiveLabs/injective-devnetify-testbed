#!/bin/bash

INJECTIVED="docker run -it --rm \
    -v $(pwd)/injective-888:/apps/data/injective-888 \
    -v $(pwd)/custom_overrides.yaml:/apps/data/custom_overrides.yaml:ro \
    public.ecr.aws/l9h3g6c6/injective-core:v1.15.0-devnetify injectived"

$INJECTIVED --home "./injective-888" devnetify --skip-confirmation --custom-overrides ./custom_overrides.yaml injective-888 inj1wpsrkfdqncagtj726cpwzrz4q2yf6gv4m9ah7l
