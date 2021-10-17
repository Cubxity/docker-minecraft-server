#!/bin/bash

curl -s https://ci.tivy.ca/api/json | jq -r ".jobs[].name" | while read -r job; do
  IFS=- read -r name version <<<"$job"

  if [ "$name" != "Airplane" ] || [[ "$version" =~ ^Purpur-.* ]]; then
    continue
  fi

  manifest=$(curl -s "https://ci.tivy.ca/job/Airplane-$version/lastSuccessfulBuild/api/json")
  build=$(echo "$manifest" | jq -r ".number")

  echo "[airplane] building airplane-$version-$build-$RUNTIME_NAME"

  docker buildx build \
    --build-arg "RUNTIME=$RUNTIME_IMAGE" \
    --build-arg "RUNTIME_NAME=$RUNTIME_NAME" \
    --build-arg "AIRPLANE_VERSION=$version" \
    --build-arg "AIRPLANE_BUILD=$build" \
    --tag "$REPOSITORY:airplane-$version-$build-$RUNTIME_NAME" \
    --tag "$REPOSITORY:airplane-$version-$RUNTIME_NAME" \
    --cache-from "type=registry,ref=$REPOSITORY:airplane-$version-$build-$RUNTIME_NAME" \
    --cache-to "type=registry,ref=$REPOSITORY:airplane-$version-$build-$RUNTIME_NAME,mode=max" \
    --file "airplane/$RUNTIME_OS/Dockerfile" \
    --platform "$RUNTIME_PLATFORM" \
    --push \
    . || exit 1
done
