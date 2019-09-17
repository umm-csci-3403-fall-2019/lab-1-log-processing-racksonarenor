#!/usr/bin/env bash
rm -f "$1"/tmp_failed_username_data.txt
rm -f "$1"/username_dist.html
rm -f "$1"/tmp_sorted_failed_username_data.txt
rm -f "$1"/tmp_username_amount_data.txt
rm -f "$1"/tmp_data.txt
#for file in $(find $1 -type f)
#do
#	echo "$(awk 'match($0, /[a-zA-Z0-9]{3} +[0-9]{1,2} [0-9]{2} ([a-zA-Z0-9_\-\[\]]+)/, groups) {print groups[1]}' < $file)" >> $1/tmp_failed_username_data.txt
#done
awk 'match($0, /[a-zA-Z0-9]{3} +[0-9]{1,2} [0-9]{2} ([a-zA-Z0-9_\-\[\]]+)/, groups) {print groups[1]}' < "$1"/failed_login_data.txt >> "$1"/tmp_failed_username_data.txt
sort "$1"/tmp_failed_username_data.txt > "$1"/tmp_sorted_failed_username_data.txt
uniq "$1"/tmp_sorted_failed_username_data.txt -c >> "$1"/tmp_username_amount_data.txt

awk 'match($0, /[ ]+([0-9]+)[ ]+([a-zA-Z0-9_\-]+)/, groups) {print "data.addRow([\x27" groups[2] "\x27, " groups[1] "]);"}' < "$1"/tmp_username_amount_data.txt >> "$1"/tmp_data.txt

./bin/wrap_contents.sh "$1"/tmp_data.txt html_components/username_dist "$1"/username_dist.html
