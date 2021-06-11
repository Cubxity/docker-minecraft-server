#!/bin/bash
declare -A runtimes
runtimes[adopt8]="adoptopenjdk/openjdk8:jre8u282-b08-alpine"
runtimes[adopt11]="adoptopenjdk/openjdk11:jre-11.0.10_9-alpine"
runtimes[adopt16]="adoptopenjdk/openjdk16:jre-16.0.1_9-alpine"

curl -s https://papermc.io/api/v2/projects/paper/ | jq -r -c ".versions[]" | while read -r version; do
  build=$(curl -s "https://papermc.io/api/v2/projects/paper/versions/$version" | jq -r ".builds[-1]")
  hash=$(curl -s "https://papermc.io/api/v2/projects/paper/versions/$version/builds/$build" | jq -r ".downloads.application.sha256")

  IFS="." read -r major minor patch <<<"${version//-*/}"

  for runtimeName in "${!runtimes[@]}"; do
    if [ $minor -lt 12 ] && [ $runtimeName == "adopt11" ]; then
      continue
    fi

    if [[ ($minor -lt 16 || ($minor -eq 16 && $patch -lt 5)) && $runtimeName == "adopt16" ]]; then
      continue
    fi

    echo "[paper] building paper-$version-$build-$runtimeName"

    docker build \
      --build-arg "RUNTIME=${runtimes[$runtimeName]}" \
      --build-arg "RUNTIME_NAME=$runtimeName" \
      --build-arg "PAPER_VERSION=$version" \
      --build-arg "PAPER_BUILD=$build" \
      --build-arg "PAPER_SHA256=$hash" \
      --tag "cubxity/minecraft-server:paper-$version-$build-$runtimeName" \
      --tag "cubxity/minecraft-server:paper-$version-$runtimeName" \
      -f paper/Dockerfile \
      .
  done
done
