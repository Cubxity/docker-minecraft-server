#!/bin/sh

(
  cd ./tuinity || exit
  ./update.sh
)
(
  cd ./paper || exit
  ./update.sh
)