#!/bin/bash
declare -A runtimes
runtimes[adopt8]="adoptopenjdk/openjdk8:jre8u282-b08-alpine"
runtimes[adopt11]="adoptopenjdk/openjdk11:jre-11.0.10_9-alpine"
runtimes[adopt16]="adoptopenjdk/openjdk16:jre-16.0.1_9-alpine"

curl -s "https://purpur.pl3x.net/api/v1/purpur" | jq -r ".versions[]" | while read -r version; do
  build=$(curl -s "https://purpur.pl3x.net/api/v1/purpur/$version" | jq -r ".builds.latest")

  IFS="." read -r major minor patch <<<"${version//-*/}"

  for runtimeName in "${!runtimes[@]}"; do
    if [[ ($minor -lt 16 || ($minor -eq 16 && $patch -lt 5)) && $runtimeName == "adopt16" ]]; then
      continue
    fi

    echo "[purpur] building purpur-$version-$build-$runtimeName"

    docker build \
      --build-arg "RUNTIME=${runtimes[$runtimeName]}" \
      --build-arg "RUNTIME_NAME=$runtimeName" \
      --build-arg "PURPUR_VERSION=$version" \
      --build-arg "PURPUR_BUILD=$build" \
      --tag "cubxity/minecraft-server:purpur-$version-$build-$runtimeName" \
      --tag "cubxity/minecraft-server:purpur-$version-$runtimeName" \
      -f purpur/Dockerfile \
      .
  done
done
