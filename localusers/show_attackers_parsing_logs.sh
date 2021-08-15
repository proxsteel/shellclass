#!/bin/bash

##Pseudocode:
# Make sure a file was supplied as an argument.
# Display the CSV header.
# Loop through the list of failed attempts and corresponding IP addresses.
# If the number of failed attempts is greater than the limit, display count, IP, and location. 

LOGFILENAME="${1}"
LIMIT='10'

usage_msg () {
    echo "Usage: ${0} [filename.log]" >&2
    #echo "`basename ${0}` [filename]"
    #echo "This is the directory: `dirname ${0}` of the script"
    exit 1
}

# If the user doesn't supply at least one argument, give them help.
if [[ "${#}" -ne 1 ]]; then
    usage_msg
fi
  
if [[ ! -e "${LOGFILENAME}" ]]; then
    echo "Can not open the ${1} file!"
    echo "The ${1} file does not exits!"
    exit 1
fi
#echo "File name is ${1}"

# Display the CSV header.
echo 'Count,IP,Location'

# Loop through the list of failed attempts and corresponding IP addresses.
grep Failed ${LOGFILENAME} | awk '{print $(NF - 3)}' | sort | uniq -c | sort -nr |  while read COUNT IP #sort -nr -- sort numeric and reverse ; uniq -c -- count
do
  # If the number of failed attempts is greater than the limit, display count, IP, and location.
  if [[ "${COUNT}" -gt "${LIMIT}" ]]
  then
    LOCATION=$(geoiplookup ${IP} | awk -F ', ' '{print $2}')
    echo "${COUNT},${IP},${LOCATION}"
  fi
done
exit 0
