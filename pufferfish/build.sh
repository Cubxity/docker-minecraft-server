#!/bin/bash

curl -s https://ci.pufferfish.host/api/json | jq -r ".jobs[].name" | while read -r job; do
  IFS=- read -r name version <<<"$job"

  if [ "$name" != "Pufferfish" ] || [[ "$version" =~ ^Purpur-.* ]]; then
    continue
  fi

  manifest=$(curl -s "https://ci.pufferfish.host/job/Pufferfish-$version/lastSuccessfulBuild/api/json")
  build=$(echo "$manifest" | jq -r ".number")
  path=$(echo "$manifest" | jq -r ".artifacts[0].relativePath")

  echo "[pufferfish] building pufferfish-$version-$build-$RUNTIME_NAME"

  docker buildx build \
    --build-arg "RUNTIME=$RUNTIME_IMAGE" \
    --build-arg "RUNTIME_NAME=$RUNTIME_NAME" \
    --build-arg "PUFFERFISH_VERSION=$version" \
    --build-arg "PUFFERFISH_BUILD=$build" \
    --build-arg "PUFFERFISH_PATH=$path" \
    --tag "$REPOSITORY:pufferfish-$version-$build-$RUNTIME_NAME" \
    --tag "$REPOSITORY:pufferfish-$version-$RUNTIME_NAME" \
    --cache-from "type=registry,ref=$REPOSITORY:pufferfish-$version-$build-$RUNTIME_NAME" \
    --cache-to "type=registry,ref=$REPOSITORY:pufferfish-$version-$build-$RUNTIME_NAME,mode=max" \
    --file "pufferfish/$RUNTIME_OS/Dockerfile" \
    --platform "$RUNTIME_PLATFORM" \
    --push \
    . || exit 1
done
