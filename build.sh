#!/bin/sh

(
  cd ./tuinity || exit
  ./build.sh
)
(
  cd ./paper || exit
  ./build.sh
)
