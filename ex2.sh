#!/bin/bash

COUNT=0

rec() {
   if [ -d "$1" ]; then
      ls "$1" | while read name; do
         rec "$1/$name"
      done
   else
      if [ ${1: -2} == ".c" -o ${1: -2} == ".h" ]; then
         echo "$1"
      fi
   fi
}

while read X; do
	COUNT=$((COUNT +  $(cat "$X" | sed '/^\s*$/d' | wc -l)))
done <<< $(rec "$1")

echo $COUNT