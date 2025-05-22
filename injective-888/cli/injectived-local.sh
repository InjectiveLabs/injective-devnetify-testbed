#!/bin/bash

ulimit -n 120000

injectived \
--log-level "info" \
--home "./injective-888" \
--json-rpc.api "eth,web3,net,txpool,debug,personal,inj" \
start
