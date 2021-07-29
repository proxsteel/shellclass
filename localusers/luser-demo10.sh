#!/bin/bash

# This is to demonstrate a FUNCTION in bash

#method one

log() {
    echo 'You called the log function!'
}

log #callig the created function named log

#method two

function log2 {
    echo 'You called the log2 function!'
}

log2 

#local variables in fucntions
log_local() {
    local MESSAGE="${@}"  #declaring a local variable inside of the function
    if [[ "${VERBOSE}" = 'true' ]]; then
      echo "${MESSAGE}"
    fi
}

log_local 'This is using a local variable inside a function'   #passing an argument to the function
VERBOSE="true" #global variable and it might affect the loging in depdendence of it position in script
log_local 'Fun stuff!'

#move VERBOSE to LOCAL in function
log_local() {
    local VERBOSE="${1}"
    shift
    local MESSAGE="${@}"  #declaring a local variable inside of the function
    if [[ "${VERBOSE}" = 'true' ]]; then
      echo "${MESSAGE}"
    fi
}

VERBOSITY="true"
log_local 'true' 'This is using a local variable inside a function'   #passing an argument to the function exluding ${1} parameter by ommiting 'true' arg. or var subbst. ${VERBOSITY}
log_local "${VERBOSITY}" 'Fun stuff, Yay!'

#global readonly variables
log_local() {
    local MESSAGE="${@}"  #declaring a local variable inside of the function
    if [[ "${VERBOSE}" = 'true' ]]; then
      echo "${MESSAGE}"
    fi
}

readonly VERBOSE="true"
log_local 'This is using a local variable inside a function and a global readonly one'   #passing an argument to the function
log_local 'Fun stuff, Yaaaayyyyyyyyy!'

#this function sends a message to the syslog and STDOUT
log_syslog() {
    local MESSAGE="${@}"  #declaring a local variable inside of the function
    if [[ "${VERBOSE1}" = 'true' ]]; then
      echo "${MESSAGE}"
    fi
    logger -t "${0}" "${MESSAGE}"
}

backup_file() {
    # This function creates a backup of a file.  Returns non-zero status on error.
    local FILE="${1}"
    # Make sure the file exists. test -f or [ -f ]
    if [[ -f "${FILE}" ]]; then
        local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
        #echo "$(basename ${FILE})"
        #echo "${BACKUP_FILE}"
        log_syslog "$(basename ${0}) -- Backing up ${FILE} to ${BACKUP_FILE}."
        
        cp -p ${FILE} ${BACKUP_FILE} # -p option will preserve file's original metadata like creation date... 
    else
        echo "The ${FILE} does not exists"
        return 1
    fi


}

readonly VERBOSE1="true"
log_syslog 'SYSTEM log file has been modified'   #passing an argument to the function
log_syslog 'TEST 4'

backup_file /etc/passwd

# Make a decision based on the exit status of the function.
# Note this is for demonstration purposes.  You could have
# put this functionality inside of the backup_file function.
if [[ "${?}" -eq '0' ]]
then
  log 'File backup succeeded!'
else
  log 'File backup failed!'
  exit 1
fi