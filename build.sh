#!/bin/sh

for flavor in paper tuinity purpur yatopia; do
  "./$flavor/build.sh"
done
