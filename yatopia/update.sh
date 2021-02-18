#!/bin/bash
declare -A runtimes
runtimes[adopt8]="adoptopenjdk/openjdk8:alpine-jre"
runtimes[adopt11]="adoptopenjdk/openjdk11:alpine-jre"
runtimes[adopt15]="adoptopenjdk/openjdk15:alpine-jre"

curl -s https://ci.codemc.io/job/YatopiaMC/job/Yatopia/api/json | jq -r ".jobs[].name" | while read -r job; do
  read -r kind version < <(echo "$job" | sed "s/%2F/ /")

  if [ "$kind" == "ver" ]; then
    manifest=$(curl -s "https://ci.codemc.io/job/YatopiaMC/job/Yatopia/job/$job/lastSuccessfulBuild/api/json")
    build=$(echo "$manifest" | jq -r ".number")

    for runtimeName in "${!runtimes[@]}"; do
      runtime="${runtimes[$runtimeName]}"
      mkdir -p "$version/$runtimeName"

      sed \
        -e "s#__RUNTIME__#$runtime#" \
        -e "s/{RUNTIME_NAME}/$runtimeName/" \
        -e "s/{YATOPIA_VERSION}/$version/" \
        -e "s/{YATOPIA_BUILD}/$build/" \
        Dockerfile.template >"$version/$runtimeName/Dockerfile"
    done
  fi
done
