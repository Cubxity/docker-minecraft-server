#!/bin/bash
declare -A runtimes
runtimes[adopt8]="adoptopenjdk/openjdk8:alpine-jre"
runtimes[adopt11]="adoptopenjdk/openjdk11:alpine-jre"
runtimes[adopt15]="adoptopenjdk/openjdk15:alpine-jre"

manifest=$(curl -s https://ci.codemc.io/job/Spottedleaf/job/Tuinity/lastSuccessfulBuild/api/json)
build=$(echo "$manifest" | jq -r ".number")v

for runtimeName in "${!runtimes[@]}"; do
  runtime="${runtimes[$runtimeName]}"
  mkdir -p "$runtimeName"

  sed \
    -e "s#__RUNTIME__#$runtime#" \
    -e "s/{RUNTIME_NAME}/$runtimeName/" \
    -e "s/{TUINITY_BUILD}/$build/" \
    Dockerfile.template >"$runtimeName/Dockerfile"
done
