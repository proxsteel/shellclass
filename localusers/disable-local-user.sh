#!/bin/bash
#########################################################################################################################################################
#REQUIREMENTS:
#Enforces that it be executed with superuser (root) privileges.  
#If the script is not executed with superuser privileges it will not attempt to create a user and returns an exit status of 1.  
#All messages associated with this event will be displayed on standard error.

#Provides a usage statement much like you would find in a man page if the user does not supply an account name on the command line and returns an exit status of 1.  
#All messages associated with this event will be displayed on standard error.

#Disables (expires/locks) accounts by default.

#Allows the user to specify the following options:

# -d  Deletes accounts instead of disabling them.
# -r  Removes the home directory associated with the account(s).
# -a  Creates an archive of the home directory associated with the accounts(s) and stores the archive in the /archives directory.  
#     (NOTE: /archives is not a directory that exists by default on a Linux system.  The script will need to create this directory if it does not exist.)

#Any other option will cause the script to display a usage statement and exit with an exit status of 1.

#Accepts a list of usernames as arguments.  
#At least one username is required or the script will display a usage statement much like you would find in a man page and return an exit status of 1.  
#All messages associated with this event will be displayed on standard error.

#Refuses to disable or delete any accounts that have a UID less than 1,000.

#Only system accounts should be modified by system administrators.  Only allow the help desk team to change user accounts.

#Informs the user if the account was not able to be disabled, deleted, or archived for some reason.

#Displays the username and any actions performed against the account.
#########################################################################################################################################################
#
# This script disables, deletes, and/or archives users on the local system.
#
# Display the usage and exit.
ARCHIVE_DIR='/archive'

usage_msg () {
    echo "Usage: ${0} [-dra] USER [USERN]" >&2
    echo 'Disable multiple accaunts on a local linux.' >&2
    echo '  -d        Deletes accounts instead of disabling' >&2
    echo '  -r        Removes HOME directory.' >&2
    echo '  -a        Creates an Archive of the HOME Directory.' >&2
    exit 1
}

log_msg () {
    local MESSAGE="${@}"
    echo "${MESSAGE}"
}
# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]; then
    log_msg "************************************************************"
    log_msg 'In order to run this script ROOT privileges are required'
    echo 
    log_msg "Try: sudo ${0} [-dra] USER [USERN]"
    log_msg "************************************************************"
    exit 1
fi

# Parse the options.
while getopts dra OPTION; do
    case ${OPTION} in
        d) 
           DELETE_USER='true' 
           echo 'Deleting from passwd file...'
           ;;
        r) 
           REMOVE_OPTION='-r' 
           echo 'Removing user HOME dir'
           ;;
        a) ARCHIVE='true' ;;
        ?) usage_msg ;;
    esac
done
#inspect OPTIOND
echo "OPTIND: ${OPTIND}"   #stores the position of the next argument
# Remove the options while leaving the remaining arguments.
shift "$(( OPTIND - 1 ))"
#inspect OPTIOND
echo "After shift OPTIND: ${OPTIND}"   #stores the position of the next argument
echo "Extra arguments: ${@}"

# If the user doesn't supply at least one argument, give them help.
if [[ ${#} -lt 1 ]]; then
    usage_msg
fi
# Loop through all the usernames supplied as arguments.
USER_NAME="${@}"
#echo "${USER_NAME}"

for NAME in ${USER_NAME}; do
    echo "Processing USERNAME: ${NAME}"
    # Make sure the UID of the account is at least 1000.
    if [[ "$(id -u ${NAME})" -lt 1000 ]]; then
        log_msg "The ${NAME} is a system account and you are not allowed manipulate it"
        exit 1
    fi

    # Create an archive if requested to do so.
    if [[ "${ARCHIVE}" = 'true' ]]; then
        # Make sure the ARCHIVE_DIR directory exists
        if [[ ! -d "${ARCHIVE_DIR}" ]]; then
            log_msg "Creating ${ARCHIVE_DIR} directory"
            mkdir -p ${ARCHIVE_DIR}
            if [[ "${?}" -ne 0 ]]; then
                log_msg "The Archive directory ${ARCHIVE_DIR} could not be created"
                exit 1
            fi
        fi
        # Archive the user's home directory and move it into the ARCHIVE_DIR
        HOME_DIR="/home/${NAME}"
        ARCHIVE_FILE="${ARCHIVE_DIR}/${NAME}.tgz"
        if [[ -d "${HOME_DIR}" ]]; then
            echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}"
            tar -zcf ${ARCHIVE_FILE} ${HOME_DIR} &> /dev/null
            if [[ "${?}" -ne 0 ]]; then
                log_msg "Could not create the archive: ${ARCHIVE_FILE}" >&2
                exit 1
            fi
        else
            log_msg "${HOME_DIR} does not exists or it is not a directory" >&2
            exit 1
        fi
    fi # END of archiving if true
    
    if [[ "${DELETE_USER}" = 'true' ]]; then
        #delete the account
        userdel ${REMOVE_OPTION} ${NAME}
        # Check to see if the userdel command succeeded.
        if [[ "${?}" -ne 0 ]]; then
            echo "Something went wrong, can not delete this ${NAME} user"
            exit 1
        fi
    # We don't want to tell the user that an account was deleted when it hasn't been.
    else 
        echo "Disabling the ${NAME} account" 
        chage -E 0 ${NAME}

        if [[ "${?}" -ne 0 ]]; then
            echo "Something went wrong, can not delete this ${NAME} user"
            exit 1
        fi
    fi # END of DELETE_USER

done

exit 0