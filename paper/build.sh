#!/bin/bash
declare -A alpine_runtimes
alpine_runtimes[adopt8]="adoptopenjdk/openjdk8:jre8u292-b10-alpine"
alpine_runtimes[adopt11]="adoptopenjdk/openjdk11:jre-11.0.10_9-alpine"
alpine_runtimes[adopt16]="adoptopenjdk/openjdk16:jre-16.0.1_9-alpine"

curl -s https://papermc.io/api/v2/projects/paper/ | jq -r -c ".versions[]" | while read -r version; do
  build=$(curl -s "https://papermc.io/api/v2/projects/paper/versions/$version" | jq -r ".builds[-1]")
  hash=$(curl -s "https://papermc.io/api/v2/projects/paper/versions/$version/builds/$build" | jq -r ".downloads.application.sha256")

  IFS="." read -r major minor patch <<<"${version//-*/}"

  for runtimeName in "${!alpine_runtimes[@]}"; do
    # Only allow AdoptOpenJDK 11 for >= 1.12
    if [ $minor -lt 12 ] && [ $runtimeName == "adopt11" ]; then
      continue
    fi

    # Only allow AdoptOpenJDK 16 for >= 1.16.5
    if [[ ($minor -lt 16 || ($minor -eq 16 && $patch -lt 5)) && $runtimeName == "adopt16" ]]; then
      continue
    fi

    # Disallow older version of Java fpr >= 1.17
    if [ $minor -ge 17 ] && [ $runtimeName != "adopt16" ]; then
      continue
    fi

    echo "[paper] building paper-$version-$build-$runtimeName"

    docker build \
      --build-arg "RUNTIME=${alpine_runtimes[$runtimeName]}" \
      --build-arg "RUNTIME_NAME=$runtimeName" \
      --build-arg "PAPER_VERSION=$version" \
      --build-arg "PAPER_BUILD=$build" \
      --build-arg "PAPER_SHA256=$hash" \
      --tag "cubxity/minecraft-server:paper-$version-$build-$runtimeName" \
      --tag "cubxity/minecraft-server:paper-$version-$runtimeName" \
      -f paper/alpine/Dockerfile \
      .
  done
done
