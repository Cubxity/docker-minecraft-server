#!/bin/bash
declare -A runtimes
runtimes[adopt8]="adoptopenjdk/openjdk8:jre8u282-b08-alpine"
runtimes[adopt11]="adoptopenjdk/openjdk11:jre-11.0.10_9-alpine"
runtimes[adopt15]="adoptopenjdk/openjdk15:jre-15.0.2_7-alpine"

curl -s "https://purpur.pl3x.net/api/v1/purpur" | jq -r ".versions[]" | while read -r version; do
  build=$(curl -s "https://purpur.pl3x.net/api/v1/purpur/1.16.5" | jq -r ".builds.latest")
  minor=$(echo "$version" | sed 's/^[0-9]*\.\([0-9]*\).*/\1/')

  for runtimeName in "${!runtimes[@]}"; do
    if [ $((minor < 15)) == 1 ] && [ $runtimeName == "adopt15" ]; then
      continue
    fi

    runtime="${runtimes[$runtimeName]}"
    mkdir -p "$version/$runtimeName"

    sed \
      -e "s#__RUNTIME__#$runtime#" \
      -e "s/{RUNTIME_NAME}/$runtimeName/" \
      -e "s/{PURPUR_VERSION}/$version/" \
      -e "s/{PURPUR_BUILD}/$build/" \
      Dockerfile.template >"$version/$runtimeName/Dockerfile"
  done
done
