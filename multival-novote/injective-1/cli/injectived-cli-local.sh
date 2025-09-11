#!/bin/bash

injectived \
--home "./injective-1/validators/0" \
${*:-"query"}
