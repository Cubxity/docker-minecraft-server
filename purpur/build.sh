#!/bin/bash

curl -s "https://api.pl3x.net/v2/purpur/" | jq -r ".versions[]" | while read -r version; do
  build=$(curl -s "https://api.pl3x.net/v2/purpur/$version/" | jq -r ".builds.latest")

  IFS="." read -r major minor patch <<<"${version//-*/}"

  # Only allow Java >= 11 for >= 1.12
  if [ $minor -lt 12 ] && [ $RUNTIME_VERSION -ge 11 ]; then
    continue
  fi

  # Disallow Java < 16 fpr >= 1.17
  if [ $minor -ge 17 ] && [ $RUNTIME_VERSION -lt 16 ]; then
    continue
  fi

  echo "[purpur] building purpur-$version-$build-$runtimeName"

  docker buildx build \
    --build-arg "RUNTIME=$RUNTIME_IMAGE" \
    --build-arg "PURPUR_VERSION=$version" \
    --build-arg "PURPUR_BUILD=$build" \
    --tag "$REPOSITORY:purpur-$version-$build-$RUNTIME_NAME" \
    --tag "$REPOSITORY:purpur-$version-$RUNTIME_NAME" \
    --cache-from "type=registry,ref=$REPOSITORY:purpur-$version-$build-$RUNTIME_NAME" \
    --cache-to "type=registry,ref=$REPOSITORY:purpur-$version-$build-$RUNTIME_NAME,mode=max" \
    --file "purpur/$RUNTIME_OS/Dockerfile" \
    --platform "$RUNTIME_PLATFORM" \
    --push \
    . || exit 1
done
