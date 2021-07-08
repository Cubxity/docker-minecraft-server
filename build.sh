#!/bin/sh

for flavor in paper tuinity airplane airplanepurpur purpur; do
  "./$flavor/build.sh"
done

docker push --all-tags cubxity/minecraft-server
