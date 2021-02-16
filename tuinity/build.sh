#!/bin/bash
IMAGE_NAME="cubxity/minecraft-server"

for variant in */; do
  variant=${variant%*/}

  tag="$IMAGE_NAME:tuinity-$variant"
  docker build -t "$tag" -f "${variant}/Dockerfile" .
  docker push "$tag"
done
