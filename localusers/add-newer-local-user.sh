#!/bin/bash


# Make sure the script is being executed with superuser privileges.

if [[ "${UID}" -ne 0 ]]; then
  echo
  echo '***************************************************'
  echo "* Special permits are required to run this script *" 1>&2  #old style and STDOUT to STDERR too
  echo "* Try: sudo $(basename ${0})'              *" 1>&2
  echo "* Your current username is: `id -un`               *" >&2  #new style
  echo '***************************************************'
  echo
  exit 1
fi

# If the user doesn't supply at least one argument, then give them help.
NUMBER_OF_ARGS="${#}"

if [[ "${NUMBER_OF_ARGS}" -lt 1 ]]; then
  echo
  echo '********************************************************************'
  echo "* At least one argument is required to run this script successfuly *" >&2
  echo "* USAGE: ${0} USER_NAME [Name Lastname] ...   *" >&2
  echo '********************************************************************'
  echo 
  exit 1
fi

# The first parameter is the user name.
USER_NAME="${1}"
shift
# The rest of the parameters are for the account comments.
COMMENT="${@}"
#echo "${USER_NAME}"
#echo "${COMMENT}"

# Generate a password. PASSWORD="${RANDOM}"$(date +%s%H | sha256sum | head -c15)
PASSWORD="${RANDOM}"$(date +%s%H | sha256sum | head -c15)
#echo "${PASSWORD}"

# Create the user with the password.
ERROR_MSG="/tmp/adduser_errors.log"
useradd -c "${COMMENT}" -m "${USER_NAME}" &>> "${ERROR_MSG}"  #just > would be enough for the last failed user but just for learning purpose I used appending >>

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]; then
  echo
  echo '********************************************************************'
  echo "* ERROR: Failed to create username: ${USER_NAME}.                         *" >&2
  #echo "* The message(s) of error -- $(cat /tmp/script_errors.log | tail -n1)  *" >&2  
  echo "* The message(s) of error -- $(cat ${ERROR_MSG} | tail -n1)  *" >&2        
  echo '********************************************************************'
  echo 
  exit 1
fi

# Set the password.

# NOTE: You can also use the following command:
#    echo "${USER_NAME}:${PASSWORD}" | chpasswd
echo ${PASSWORD} | passwd --stdin ${USER_NAME} &> /dev/null

# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]; then
  echo
  echo '********************************************************************'
  echo "*ERROR: Password can not be created for this username: ${USER_NAME}*" >&2
  echo '********************************************************************'
  echo 
  exit 1
fi

# Force password change on first login.
passwd -e ${USER_NAME} &> /dev/null

# Display the username, password, and the host where the user was created.
echo 
echo "Username: ${USER_NAME}"
echo 
echo "Password: ${PASSWORD}"
echo 
echo "Hostname: ${HOSTNAME}"

exit 0