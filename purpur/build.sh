#!/bin/bash
declare -A alpine_runtimes
alpine_runtimes[adopt8]="adoptopenjdk/openjdk8:jre8u292-b10-alpine"
alpine_runtimes[adopt11]="adoptopenjdk/openjdk11:jre-11.0.10_9-alpine"
alpine_runtimes[adopt16]="adoptopenjdk/openjdk16:jre-16.0.1_9-alpine"

curl -s "https://api.pl3x.net/v2/purpur/" | jq -r ".versions[]" | while read -r version; do
  build=$(curl -s "https://api.pl3x.net/v2/purpur/$version/" | jq -r ".builds.latest")

  IFS="." read -r major minor patch <<<"${version//-*/}"

  for runtimeName in "${!alpine_runtimes[@]}"; do
     # Only allow AdoptOpenJDK 16 for >= 1.16.5
    if [[ ($minor -lt 16 || ($minor -eq 16 && $patch -lt 5)) && $runtimeName == "adopt16" ]]; then
      continue
    fi

    # Disallow older version of Java fpr >= 1.17
    if [ $minor -ge 17 ] && [ $runtimeName != "adopt16" ]; then
      continue
    fi

    echo "[purpur] building purpur-$version-$build-$runtimeName"

    docker build \
      --build-arg "RUNTIME=${alpine_runtimes[$runtimeName]}" \
      --build-arg "RUNTIME_NAME=$runtimeName" \
      --build-arg "PURPUR_VERSION=$version" \
      --build-arg "PURPUR_BUILD=$build" \
      --tag "cubxity/minecraft-server:purpur-$version-$build-$runtimeName" \
      --tag "cubxity/minecraft-server:purpur-$version-$runtimeName" \
      -f purpur/alpine/Dockerfile \
      .
  done
done
