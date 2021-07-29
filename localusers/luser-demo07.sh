#!/bin/bash

# demosnstrate the use of SHIFT and WHILE loops.

#infinite loop example see man true && sleep
#while [[ true ]]; do
#  echo "${RANDOM}"
#  sleep 1
#done

## Display the first three parameters.
#echo "Parameter 1: ${1}"
#echo "Parameter 1: ${2}"
#echo "Parameter 1: ${3}"
#echo ""

while [[ "${#}" -ge 1 ]]; do
  echo "Total number of arguments: ${#}"
  echo "Parameter 1: ${1}"
  echo "Parameter 1: ${2}"
  echo "Parameter 1: ${3}"
  echo ""
  shift #by default is shift 1 in this case Shift closed the infinite loop
done