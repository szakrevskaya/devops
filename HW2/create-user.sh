#!/bin/bash
ROOT_UID=0
SUCCESS=0
E_USEREXISTS=70

# Run as root
if [ "$UID" -ne "$ROOT_UID" ]
then
  echo "Must be root to run this script."
  exit $E_NOTROOT
fi  

#test, if both argument are there
if [ $# -eq 2 ]; then
username=$1
pass=$2

	# Check if user already exists.
	grep -q "$username" /etc/passwd
	if [ $? -eq $SUCCESS ] 
	then	
	echo "User $username does already exist."
  	echo "please chose another username."
	exit $E_USEREXISTS
	fi  
	
	#Add a new user
	
	useradd -p `mkpasswd "$pass"` -d /home/"$username" -m -g users -s /bin/bash "$username"
	#Allow no one else to access the home directory of the user
	chmod 750 /home/"$username" 
	echo "the account is setup"

else
        echo  " Expected usage: ./autoadder username password"
fi

exit 0