#!/bin/bash
declare -A runtimes
runtimes[adopt16]="adoptopenjdk/openjdk16:jre-16.0.1_9-alpine"

version=1.17

manifest=$(curl -s https://ci.codemc.io/job/Spottedleaf/job/Tuinity-$version/lastSuccessfulBuild/api/json)
build=$(echo "$manifest" | jq -r ".number")

for runtimeName in "${!runtimes[@]}"; do
  echo "[tuinity] building tuinity-$version-$build-$runtimeName"

  docker build \
    --build-arg "RUNTIME=${runtimes[$runtimeName]}" \
    --build-arg "RUNTIME_NAME=$runtimeName" \
    --build-arg "TUINITY_VERSION=$version" \
    --build-arg "TUINITY_BUILD=$build" \
    --tag "cubxity/minecraft-server:tuinity-$version-$build-$runtimeName" \
    --tag "cubxity/minecraft-server:tuinity-$version-$runtimeName" \
    -f tuinity/Dockerfile \
    .
done
