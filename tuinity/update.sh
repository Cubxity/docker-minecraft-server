#!/bin/bash
declare -A runtimes
runtimes[adopt8]="adoptopenjdk/openjdk8:jre8u282-b08-alpine"
runtimes[adopt11]="adoptopenjdk/openjdk11:jre-11.0.10_9-alpine"
runtimes[adopt15]="adoptopenjdk/openjdk15:jre-15.0.2_7-alpine"

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
