#!/bin/bash
declare -A runtimes
runtimes[adopt11]="adoptopenjdk/openjdk11:jre-11.0.10_9-alpine"
runtimes[adopt16]="adoptopenjdk/openjdk16:jre-16.0.1_9-alpine"

for runtimeName in "${!runtimes[@]}"; do
  echo "[airplane] building airplane-$runtimeName"

  docker build \
    --build-arg "RUNTIME=${runtimes[$runtimeName]}" \
    --build-arg "RUNTIME_NAME=$runtimeName" \
    --tag "cubxity/minecraft-server:airplane-$runtimeName" \
    -f airplane/Dockerfile \
    .
done
