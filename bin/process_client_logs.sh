#!/usr/bin/env bash

for file in $@
do
	echo "$(awk 'match($0, /([a-zA-Z0-9 ]+):[a-zA-Z0-9_ \[\]:]+ Failed password for ([a-zA-Z0-9/-_]+) from ([0-9/.]+)/, groups) {print groups[1] " " groups[2] " "  groups[3]}' < $file)" >> failed_login_data.txt
        echo "$(awk 'match($0, /([a-zA-Z0-9 ]+):[a-zA-Z0-9_ \[\]:]+ Failed password for invalid user ([a-zA-Z0-9/-_]+) from ([0-9/.]+)/, groups) {print groups[1] " " groups[2] " " groups[3]}' < $file)" >> failed_login_data.txt
	
echo $out0
done
