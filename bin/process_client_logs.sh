#!/usr/bin/env bash


for file in $(find $1 -type f)
do
	#This gets all attempts to login to users that actually exist
	echo "$(awk 'match($0, /([a-zA-Z0-9 ]+):[a-zA-Z0-9_ \[\]:]+ Failed password for ([a-zA-Z0-9\-_]+) from ([0-9/.]+)/, groups) {print groups[1] " " groups[2] " "  groups[3]}' < $file)" >> $1/tmp_failed_login_data.txt
	#This gets all attempts to login to users that do not exist 
	echo "$(awk 'match($0, /([a-zA-Z0-9 ]+):[a-zA-Z0-9_ \[\]:]+ Failed password for invalid user ([a-zA-Z0-9\-_]+) from ([0-9/.]+)/, groups) {print groups[1] " " groups[2] " " groups[3]}' < $file)" >> $1/tmp_failed_login_data.txt
done

awk NF $1/tmp_failed_login_data.txt >> $1/failed_login_data.txt
