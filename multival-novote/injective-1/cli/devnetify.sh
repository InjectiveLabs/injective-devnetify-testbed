#!/bin/bash

docker compose -f ./injective-1/docker-compose.devnetify.yml up
sleep 1 # 5s + 1s total max time
docker compose -f ./injective-1/docker-compose.devnetify.yml down
