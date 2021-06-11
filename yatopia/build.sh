#!/bin/bash
declare -A runtimes
runtimes[adopt16]="adoptopenjdk/openjdk16:jre-16.0.1_9-alpine"

curl -s https://ci.codemc.io/job/YatopiaMC/job/Yatopia/api/json | jq -r ".jobs[].name" | while read -r job; do
  read -r kind version < <(echo "$job" | sed "s/%2F/ /")

  if [ "$kind" == "ver" ]; then
    manifest=$(curl -s "https://ci.codemc.io/job/YatopiaMC/job/Yatopia/job/$job/lastSuccessfulBuild/api/json")
    build=$(echo "$manifest" | jq -r ".number")

    for runtimeName in "${!runtimes[@]}"; do
      echo "[yatopia] building yatopia-$version-$build-$runtimeName"

      docker build \
        --build-arg "RUNTIME=${runtimes[$runtimeName]}" \
        --build-arg "RUNTIME_NAME=$runtimeName" \
        --build-arg "YATOPIA_VERSION=$version" \
        --build-arg "YATOPIA_BUILD=$build" \
        --tag "cubxity/minecraft-server:yatopia-$version-$build-$runtimeName" \
        --tag "cubxity/minecraft-server:yatopia-$version-$runtimeName" \
        -f yatopia/Dockerfile \
        .
    done
  fi
done
