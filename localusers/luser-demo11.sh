#!/bin/bash

# This script generates a random password.
# The user can set the password length with -l and add a special character with -s.
# Verbose mode can be enabled with -v.

function usage {
    echo "USAGE: ${0} [-vs] [-l LENGHT]" >&2
    echo 'Generates a random password.' >&2
    echo '  -l LENGHT Specify the passwrod lenght' >&2
    echo '  -s        Append a special character to the password.' >&2
    echo '  -v        Increase verbosity.' >&2
    exit 1
}

log_syslog() {
    local MESSAGE="${@}"
    if [[ "${VERBOSE}" = 'true' ]]; then
        echo "${MESSAGE}"
    fi
}
# Set a default password length.
LENGTH=48
#echo "Default length is: ${LENGTH}"

while getopts l:vs OPTION; do   #OPTION variable declared in the While-loop and getops parsses the options ":" after a leter means "must takes an argument" separated by white space.
    case ${OPTION} in
        v)
            VERBOSE='true'
            log_syslog 'Verbose mode activated!'
            ;;
        l)
            LENGTH="${OPTARG}"   #OPTARG, OPTIND are getops's variables if an option takes an argument the getopts place it in OPTARG
            ;;
        s)
            USE_SPECIAL_CHAR='true'
            ;;
        ?)
            usage
            ;;
    esac
done
#echo "Custom length is: ${LENGTH}"
#GETOPTS doesn't change positional parameters, echo to check that
echo "The number of arguments ${#}"    
echo "All passed args are: ${@}"
echo "Frist arg: ${1}"
echo "Second arg: ${2}"
echo "Thisr arg: ${3}"
echo "Fourht arg: ${4}"
#inspect OPTIOND
echo "OPTIND: ${OPTIND}"   #stores the position of the next argument

# Remove the options while leaving the remaining arguments.
shift "$(( OPTIND - 1 ))"   #OPTIND if extra argumetns are passed which are not suported it's stored in ${1} and if condition rise an error like USAGE
#shift reduce N(taken from OPTIND) units if $@ not zero then an extra argument is passed to getopts and needs to be handled
echo "After Shift"
echo "The number of arguments ${#}"    
echo "All passed args are: ${@}"
echo "Frist arg: ${1}"
echo "Second arg: ${2}"
echo "Thisr arg: ${3}"
echo "Fourht arg: ${4}"

echo "OPTIND: ${OPTIND}"

if [[ "${#}" -gt 0 ]]; then
    usage
fi

log_syslog 'Generating a password.'

PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH})

# Append a special character if requested to do so.
if [[ "${USE_SPECIAL_CHAR}" = 'true' ]] 
then
  log_syslog 'Selecting a random special character.'
  SPECIAL_CHARACTER=$(echo '!@#$%^&*()_-+=' | fold -w1 | shuf | head -c1)
  PASSWORD="${PASSWORD}${SPECIAL_CHARACTER}"
fi

log_syslog 'Done.'
log_syslog 'Here is the password:'

# Display the password.
echo "${PASSWORD}"

exit 0