#!/bin/bash

if [ $# -eq 1 ]; then
	if [ -e "$1" ]; then
		owner=`ls -l | nawk '$9 ~ /'"$1"'/ {print $3} '`
		group=`ls -l | nawk '$9 ~ /'"$1"'/ {print $4} '`
		permissions=`ls -l | nawk '$9 ~ /'"$1"'/ {print $1} '`
		if [[(${permissions:3:1} = "x")]]; then
			echo $owner	
		fi
		if [[(${permissions:6:1} = "x")]]; then
			getent group $group | awk -F: '{print $4}' | sed 's/,/\n/g'	
		fi
		if [[(${permissions:9:1} = "x")]]; then
			for user in `getent passwd | awk -F: '{print $1}'`
			do
				if [[("$user" = "$owner")]]; then
					continue
				fi
				for usr in `getent group "$group" | awk -F: '{print $4}' | sed 's/,/\n/g'`
				do
					if [[("$user" = "$usr")]]; then
						continue 2
					fi
				done
				echo "$user" 
			done
		fi		
	else
		echo "Directory $1 doesn't exist." 
	fi  
else 
	echo "Must have one argument!"	
fi

