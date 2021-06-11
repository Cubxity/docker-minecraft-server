#!/bin/bash
declare -A runtimes
runtimes[adopt16]="adoptopenjdk/openjdk16:jre-16.0.1_9-alpine"

manifest=$(curl -s https://ci.codemc.io/job/Spottedleaf/job/Tuinity/lastSuccessfulBuild/api/json)
build=$(echo "$manifest" | jq -r ".number")

for runtimeName in "${!runtimes[@]}"; do
  echo "[tuinity] building tuinity-$build-$runtimeName"

  docker build \
    --build-arg "RUNTIME=${runtimes[$runtimeName]}" \
    --build-arg "RUNTIME_NAME=$runtimeName" \
    --build-arg "TUINITY_VERSION=$version" \
    --build-arg "TUINITY_BUILD=$build" \
    --tag "cubxity/minecraft-server:tuinity-$build-$runtimeName" \
    --tag "cubxity/minecraft-server:tuinity-$runtimeName" \
    -f tuinity/Dockerfile \
    .
done
