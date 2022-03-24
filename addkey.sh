#!/bin/bash

username=${1%/}
path_to_public_key=${2}


echo $#

if [ $# -eq 0 ]; then 
  echo "no arguments supplied"
  exit
fi

         
if [ -z "${username}" ]; then
	echo "Please provide valid user name"
	echo -e $help
	exit
fi

if [ -z "${path_to_public_key}" ]; then
        echo "Please provide valid path to public key"
        echo -e $help
        exit
fi

if [ ! -f "${path_to_public_key}" ]; then
        echo "Please provide a valid public key file"
        echo -e $help
        exit
fi

useradd -c "Temp user" -m  ${username}
usermod -aG wheel ${username}
cd /home/${username}
mkdir .ssh
chmod 700 .ssh
chown ${username}:${username} .ssh
cat ${path_to_public_key} >> .ssh/authorized_keys
chmod 600 .ssh/authorized_keys
chown ${username}:${username} .ssh/authorized_keys
echo "added user "  ${username}