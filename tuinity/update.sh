#!/bin/bash
declare -A runtimes
runtimes[adopt8]="adoptopenjdk/openjdk8:jre8u275-b01-alpine"
runtimes[adopt11]="adoptopenjdk/openjdk11:jre-11.0.9.1_1-alpine"
runtimes[adopt15]="adoptopenjdk/openjdk15:jre-15.0.1_9-alpine"

manifest=$(curl -s https://ci.codemc.io/job/Spottedleaf/job/Tuinity/lastSuccessfulBuild/api/json)
build=$(echo "$manifest" | jq -r ".number")

for runtimeName in "${!runtimes[@]}"; do
  runtime="${runtimes[$runtimeName]}"
  mkdir -p "$runtimeName"

  sed \
    -e "s#__RUNTIME__#$runtime#" \
    -e "s/{RUNTIME_NAME}/$runtimeName/" \
    -e "s/{TUINITY_BUILD}/$build/" \
    Dockerfile.template >"$runtimeName/Dockerfile"
done
