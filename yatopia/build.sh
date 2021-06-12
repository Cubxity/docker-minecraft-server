#!/bin/bash
declare -A runtimes
runtimes[adopt8]="adoptopenjdk/openjdk8:jre8u292-b10-alpine"
runtimes[adopt11]="adoptopenjdk/openjdk11:jre-11.0.10_9-alpine"
runtimes[adopt16]="adoptopenjdk/openjdk16:jre-16.0.1_9-alpine"

curl -s https://ci.codemc.io/job/YatopiaMC/job/Yatopia/api/json | jq -r ".jobs[].name" | while read -r job; do
  read -r kind version < <(echo "$job" | sed "s/%2F/ /")

  if [ "$kind" == "ver" ]; then
    manifest=$(curl -s "https://ci.codemc.io/job/YatopiaMC/job/Yatopia/job/$job/lastSuccessfulBuild/api/json")
    build=$(echo "$manifest" | jq -r ".number")

    IFS="." read -r major minor patch <<<"${version//-*/}"

    for runtimeName in "${!runtimes[@]}"; do
       # Only allow AdoptOpenJDK 16 for >= 1.16.5
      if [[ ($minor -lt 16 || ($minor -eq 16 && $patch -lt 5)) && $runtimeName == "adopt16" ]]; then
        continue
      fi

      # Disallow older version of Java fpr >= 1.17
      if [ $minor -ge 17 ] && [ $runtimeName != "adopt16" ]; then
        continue
      fi

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
