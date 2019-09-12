#!/usr/bin/env bash
rm -f $1/tmp_failed_hours_data.txt
rm -f $1/hours_dist.html
rm -f $1/tmp_sorted_failed_hours_data.txt
rm -f $1/tmp_hours_amount_data.txt
rm -f $1/tmp_data.txt
for file in $(find $1 -type f)
do
	echo "$(awk 'match($0, /[a-zA-Z0-9]{3} +[0-9]{1,2} ([0-9]{2}) [a-zA-Z0-9_\-\[\]]+/, groups) {print groups[1]}' < $file)" >> $1/tmp_failed_hours_data.txt
done
sort $1/tmp_failed_hours_data.txt > $1/tmp_sorted_failed_hours_data.txt
uniq $1/tmp_sorted_failed_hours_data.txt -c >> $1/tmp_hours_amount_data.txt

echo "$(awk 'match($0, /[ ]+([0-9]+)[ ]+([0-9]+)/, groups) {print "data.addRow([\x27" groups[2] "\x27, " groups[1] "]);"}' < $1/tmp_hours_amount_data.txt)" >> $1/tmp_data.txt

./bin/wrap_contents.sh $1/tmp_data.txt html_components/hours_dist $1/hours_dist.html

rm -f $1/tmp_failed_hours_data.txt
rm -f $1/tmp_sorted_failed_hours_data.txt
rm -f $1/tmp_hours_amount_data.txt
rm -f $1/tmp_data.txt

