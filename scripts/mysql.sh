#!/bin/bash
username=${1%/}
path_to_public_key=${2}

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

