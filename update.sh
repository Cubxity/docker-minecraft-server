#!/bin/sh

(
  cd ./tuinity || exit
  ./update.sh
)
(
  cd ./yatopia || exit
  ./update.sh
)
(
  cd ./paper || exit
  ./update.sh
)