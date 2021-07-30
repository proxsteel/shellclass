#!/bin/bash

#basic script that deletes system users
#see also:
#--1
# man chage/useradd -- -E || -I
# sudo chage -E 0 USERNAME  || sudo chage -E -1 USERNAME    # 0 zero days expire; -1 to remove expiration
#--2
# sudo passwd -l USERNAME #locking user only if no SSH kyes are in use otherwise doesnt work
# sudo passwd -u USERNAME #unlock
#--3
# cat /etc/shells
# sudo usermod -s /sbin/nologin USERNAME # 2> = This account is currently not available.
# sudo usermod -s /bin/bash USERNAME     # revert back up

#A simple script that deletes users

# Run as root

if [[ ${UID} -ne 0 ]]; then
    echo 'Root privilege is required!'
    echo "Try sudo ${0} USERNAME"
    exit 1
fi


USER_NAME="${1}"

if [[ "${#}" -lt 1 ]]; then
    echo "USAGE: `basename ${0}` [USERANME]"
    exit 1
fi 

userdel ${USER_NAME} 2> ERROR_MSG

if [[ "${?}" -ne 0 ]]; then
    echo "User ${USER_NAME} can not be deleted"
    echo "The cause might be: $(cat ./ERROR_MSG)"
    exit 1
fi

echo "the username ${USER_NAME} was deleted successfuly"

exit 0

