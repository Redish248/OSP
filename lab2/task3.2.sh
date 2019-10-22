#!/bin/bash

if [ $# -eq 1 ]; then
	awk -F: '{if ($1 == "'"$1"'") {print $4}}' /etc/group | sed 's/,/\n/' | sort
else 
	echo “Must have one argument!”
fi

