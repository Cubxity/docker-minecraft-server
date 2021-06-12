#!/bin/bash
declare -A runtimes
runtimes[adopt8]="adoptopenjdk/openjdk8:jre8u292-b10-alpine"
runtimes[adopt11]="adoptopenjdk/openjdk11:jre-11.0.10_9-alpine"
runtimes[adopt16]="adoptopenjdk/openjdk16:jre-16.0.1_9-alpine"

manifest=$(curl -s https://ci.codemc.io/job/Spottedleaf/job/Tuinity/lastSuccessfulBuild/api/json)
build=$(echo "$manifest" | jq -r ".number")

for runtimeName in "${!runtimes[@]}"; do
  echo "[tuinity] building tuinity-$build-$runtimeName"

  docker build \
    --build-arg "RUNTIME=${runtimes[$runtimeName]}" \
    --build-arg "RUNTIME_NAME=$runtimeName" \
    --build-arg "TUINITY_BUILD=$build" \
    --tag "cubxity/minecraft-server:tuinity-$build-$runtimeName" \
    --tag "cubxity/minecraft-server:tuinity-$runtimeName" \
    -f tuinity/Dockerfile \
    .
done
