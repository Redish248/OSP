#!/bin/bash

if [ $# -eq 1 ]; then
	for file in $(ls -l | grep "^d" | tr -s "\t " "@" | awk -F@ '{print $0}'); 
	do
		owner=`echo "$file" | nawk -F@ '{print $3} '`
		group=`echo "$file" | nawk -F@ '{print $4} '`
		permissions=`echo "$file" | nawk -F@ '{print $1} '`
		name=`echo "$file" | nawk -F@ '{print $9} '`
		if [[ (${permissions:3:1} == "x") && ($1 == $owner) ]]; then
			echo $name
		else
			if [[(${permissions:6:1} == "x")]]; then
				test_group=`groups "$1" | grep "$group"`
				if [[($test_group != "")]]; then
					echo $name
				fi
			else
				if [[(${permissions:9:1} == "x")]]; then
					echo $name
				fi
			fi		
		fi
	done
else 
	echo "Must have one argument!"	
fi

