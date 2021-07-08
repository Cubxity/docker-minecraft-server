#!/bin/bash
declare -A runtimes
runtimes[adopt16]="adoptopenjdk/openjdk16:jre-16.0.1_9-alpine"

curl -s https://ci.tivy.ca/api/json | jq -r ".jobs[].name" | while read -r job; do
  IFS=- read -r name version <<< "$job"

  if [ "$name" != "Airplane" ] || [[ "$version" =~ ^Purpur-.* ]]; then
    continue
  fi

  manifest=$(curl -s "https://ci.tivy.ca/job/Airplane-$version/lastSuccessfulBuild/api/json")
  build=$(echo "$manifest" | jq -r ".number")

  for runtimeName in "${!runtimes[@]}"; do
    echo "[airplane] building airplane-$version-$runtimeName"

    # AIRPLANE_VERSION only indicates the version in the CI job
    docker build \
      --build-arg "RUNTIME=${runtimes[$runtimeName]}" \
      --build-arg "RUNTIME_NAME=$runtimeName" \
      --build-arg "AIRPLANE_VERSION=$version" \
      --build-arg "AIRPLANE_BUILD=$build" \
      --tag "cubxity/minecraft-server:airplane-$version-$build-$runtimeName" \
      --tag "cubxity/minecraft-server:airplane-$version-$runtimeName" \
      -f airplane/Dockerfile \
      .
  done
done
