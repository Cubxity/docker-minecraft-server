#!/bin/bash

curl -s https://papermc.io/api/v2/projects/paper/ | jq -r -c ".versions[]" | while read -r version; do
  build=$(curl -s "https://papermc.io/api/v2/projects/paper/versions/$version" | jq -r ".builds[-1]")
  hash=$(curl -s "https://papermc.io/api/v2/projects/paper/versions/$version/builds/$build" | jq -r ".downloads.application.sha256")

  IFS="." read -r major minor patch <<<"${version//-*/}"

  # Only allow Java >= 11 for >= 1.12
  if [ $minor -lt 12 ] && [ $RUNTIME_VERSION -ge 11 ]; then
    continue
  fi

  # Disallow Java < 16 fpr >= 1.17
  if [ $minor -ge 17 ] && [ $RUNTIME_VERSION -lt 16 ]; then
    continue
  fi

  echo "[paper] building paper-$version-$build-$RUNTIME_NAME"

  docker buildx build \
    --build-arg "RUNTIME=$RUNTIME_IMAGE" \
    --build-arg "PAPER_VERSION=$version" \
    --build-arg "PAPER_BUILD=$build" \
    --build-arg "PAPER_SHA256=$hash" \
    --tag "$REPOSITORY:paper-$version-$build-$RUNTIME_NAME" \
    --tag "$REPOSITORY:paper-$version-$RUNTIME_NAME" \
    --cache-from "type=registry,ref=$REPOSITORY:paper-$version-$build-$RUNTIME_NAME" \
    --cache-to "type=registry,ref=$REPOSITORY:paper-$version-$build-$RUNTIME_NAME,mode=max" \
    --file "paper/$RUNTIME_OS/Dockerfile" \
    --platform "$RUNTIME_PLATFORM" \
    --push \
    . || exit 1
done
