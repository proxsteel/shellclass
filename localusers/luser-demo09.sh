#!/bin/bash

# This script is intended to demonstrate CASE loop in bash

#if [[ "${1}" == 'start' ]]; then
#  echo 'Starting now!'
#elif [[ "${1}" == 'stop' ]]; then
#  echo 'Stoping now!'
#elif [[ "${1}" == 'status' ]]; then
#  echo 'Status is: x'
#else
#  echo "Supply a valid option!"
#  echo "USAGE: `basename ${0}` start | stop | status"
#  exit 1
#fi
  

case "${1}" in
  start)
    echo 'Starting now!'
    ;;
  stop)
    echo 'Stoping now!'
    ;;
  status|stat|--status|--stats)
    echo 'Status is: x'
    ;;
  *)
    echo "Supply a valid option!" #&> /tmp/case_file.log
    echo "USAGE: `basename ${0}` start | stop | status" >&2 #&>> /tmp/case_file.log
    exit 1
    ;;
esac

# Here is a compact version of the case statement.
#case "${1}" in
#  start) echo 'Starting.' ;;
#  stop) echo 'Stopping.' ;;
#  status) echo 'Status:' ;;
#  *)
#    echo 'Supply a valid option.' >&2
#    exit 1
#    ;;
#esac
