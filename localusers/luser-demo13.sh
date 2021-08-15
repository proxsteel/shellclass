#!/bin/bash

# This script shows the open network ports on a system.
# Use -4 as an argument to limit to tcpv4 ports.
# Use -6 as an argument to limit to tcpv6 ports.
# ${1} first option passed to the script

netstat -nutl ${1} | grep : | awk '{print $4}' | awk -F ':' '{print $NF}' #NF is AWK variable that stores the last Field information {LAST FIELD}