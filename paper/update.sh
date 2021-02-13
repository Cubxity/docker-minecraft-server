#!/bin/bash
declare -A runtimes
runtimes[adopt15]="adoptopenjdk/openjdk15:alpine-jre"
runtimes[adopt14]="adoptopenjdk/openjdk14:alpine-jre"
runtimes[adopt13]="adoptopenjdk/openjdk13:alpine-jre"
runtimes[adopt11]="adoptopenjdk/openjdk11:alpine-jre"

curl -s https://papermc.io/api/v2/projects/paper/ | jq -r -c ".versions[]" | while read -r version; do
  build=$(curl -s "https://papermc.io/api/v2/projects/paper/versions/$version" | jq -r ".builds[-1]")
  hash=$(curl -s "https://papermc.io/api/v2/projects/paper/versions/$version/builds/$build" | jq -r ".downloads.application.sha256")

  for runtimeName in "${!runtimes[@]}"; do
    runtime="${runtimes[$runtimeName]}"
    mkdir -p "$version/$runtimeName"

    sed \
      -e "s#__RUNTIME__#$runtime#" \
      -e "s/{RUNTIME_NAME}/$runtimeName/" \
      -e "s/{PAPER_VERSION}/$version/" \
      -e "s/{PAPER_BUILD}/$build/" \
      -e "s/{PAPER_SHA256}/$hash/" \
      Dockerfile.template >"$version/$runtimeName/Dockerfile"
  done
done
