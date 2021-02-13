#!/bin/bash
IMAGE_NAME="cubxity/minecraft-server"

for file in */*; do
  IFS=/ read -r version variant <<< "$file"
  docker buildx build --pull --push -t "$IMAGE_NAME:$version-paper-$variant" -f "$file/Dockerfile" .
done
