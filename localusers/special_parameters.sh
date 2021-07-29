#!/bin/bash

#only difference between $@ and $* is when last one is enclosed in "$*"
for TOKEN in "$*"; do
  echo $TOKEN
done

echo "---------"
echo $#
echo $0
echo $*
echo $?
