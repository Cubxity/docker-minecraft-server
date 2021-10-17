#!/bin/bash

curl -s https://ci.tivy.ca/api/json | jq -r ".jobs[].name" | while read -r job; do
  IFS=- read -r name flavor version <<< "$job"

  if [ "$name" != "Airplane" ] || [[ "$flavor" != "Purpur" ]]; then
    continue
  fi

  manifest=$(curl -s "https://ci.tivy.ca/job/Airplane-Purpur-$version/lastSuccessfulBuild/api/json")
  build=$(echo "$manifest" | jq -r ".number")

  echo "[airplanepurpur] building airplanepurpur-$version-$build-$RUNTIME_NAME"

  docker buildx build \
    --build-arg "RUNTIME=$RUNTIME_IMAGE" \
    --build-arg "RUNTIME_NAME=$RUNTIME_NAME" \
    --build-arg "AIRPLANEPURPUR_VERSION=$version" \
    --build-arg "AIRPLANEPURPUR_BUILD=$build" \
    --tag "$REPOSITORY:airplanepurpur-$version-$build-$RUNTIME_NAME" \
    --tag "$REPOSITORY:airplanepurpur-$version-$RUNTIME_NAME" \
    --cache-from "type=registry,ref=$REPOSITORY:airplanepurpur-$version-$build-$RUNTIME_NAME" \
    --cache-to "type=registry,ref=$REPOSITORY:airplanepurpur-$version-$build-$RUNTIME_NAME,mode=max" \
    --file "airplanepurpur/$RUNTIME_OS/Dockerfile" \
    --platform "$RUNTIME_PLATFORM" \
    --push \
    .
done
