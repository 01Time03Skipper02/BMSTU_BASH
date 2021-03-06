#!/bin/bash

if [ $# -lt 2 ]; then
	rand=$RANDOM
	echo "Error; logs in error$rand.txt"
	echo "Usage: $0 arg1 arg2" 1>&2 > error$rand.txt
	exit 1
fi

FILE=$1

if ! [ -f $FILE ]; then
	rand=$RANDOM
	echo "Error; logs in error$rand.txt"
	echo "Can't find file from arg1" 1>&2 > error$rand.txt
	exit 1
fi

if ! [ -x $FILE ]; then
	rand=$RANDOM
	echo "Error; logs in error$rand.txt"
	echo "File in arg1 must be executuble" 1>&2 > error$rand.txt
	exit 1
fi

re='^[0-9]+$'
delay=$2

if ! [[ $delay =~ $re ]]; then
	rand=$RANDOM
	echo "Error; logs in error$rand.txt"
	echo "Arg2 is not a number" 1>&2 > error$rand.txt
	exit 1
fi

rand=$RANDOM
PID=-1

while true; do
	time=$(date +%s)
	if ! ps -p  $PID > /dev/null 2>&1; then
		echo "Successful launch; logs in logs$rand.txt"
		echo "Start time is ${time}s" >> logs$rand.txt
		bash $FILE 1>>logs$rand.txt &
		PID=$!
	else
		echo "Program is already running..; logs in logs$rand.txt"
		echo "Program is already running in ${time}s" >> logs$rand.txt
	fi
	sleep ${delay}m
done