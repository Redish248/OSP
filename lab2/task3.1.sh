#!/bin/bash


if [ $# -eq 1 ]; then
	if [ -e "$1" ]; then
		ls -lta | grep "^l" | nawk '$11 ~ /'"$1"'/{print $9}'
	else
		echo “file $1 does not exist.”
	fi
	else echo “Must have one argument!”
fi

