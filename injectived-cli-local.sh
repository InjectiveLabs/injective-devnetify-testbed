#!/bin/bash

ulimit -n 120000

injectived \
--home "./injective-888" \
$*
