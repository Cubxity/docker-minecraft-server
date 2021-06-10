#!/bin/bash
IMAGE_NAME="cubxity/minecraft-server"

for file in */*; do
  IFS=/ read -r version variant <<<"$file"

  tag="$IMAGE_NAME:yatopia-$version-$variant"
  docker build -t "$tag" -f "$file/Dockerfile" .
  docker push "$tag"
done
