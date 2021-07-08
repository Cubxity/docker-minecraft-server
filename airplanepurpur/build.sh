#!/bin/bash
declare -A runtimes
runtimes[adopt16]="adoptopenjdk/openjdk16:jre-16.0.1_9-alpine"

curl -s https://ci.tivy.ca/api/json | jq -r ".jobs[].name" | while read -r job; do
  IFS=- read -r name flavor version <<< "$job"

  if [ "$name" != "Airplane" ] || [[ "$flavor" != "Purpur" ]]; then
    continue
  fi

  manifest=$(curl -s "https://ci.tivy.ca/job/Airplane-Purpur-$version/lastSuccessfulBuild/api/json")
  build=$(echo "$manifest" | jq -r ".number")

  for runtimeName in "${!runtimes[@]}"; do
    echo "[airplanepurpur] building airplanepurpur-$version-$runtimeName"

    # AIRPLANEPURPUR_VERSION only indicates the version in the CI job
    docker build \
      --build-arg "RUNTIME=${runtimes[$runtimeName]}" \
      --build-arg "RUNTIME_NAME=$runtimeName" \
      --build-arg "AIRPLANEPURPUR_VERSION=$version" \
      --build-arg "AIRPLANEPURPUR_BUILD=$build" \
      --tag "cubxity/minecraft-server:airplanepurpur-$version-$build-$runtimeName" \
      --tag "cubxity/minecraft-server:airplanepurpur-$version-$runtimeName" \
      -f airplanepurpur/Dockerfile \
      .
  done
done
