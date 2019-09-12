#!/usr/bin/env bash
rm -f $1/tmp_failed_country_data.txt
rm -f $1/tmp_joined_country_data.txt
rm -f $1/tmp_country_ids.txt
rm -f $1/tmp_sorted_country_ids.txt
rm -f $1/tmp_country_amount_data.txt
rm -f $1/tmp_data.txt
rm -f $1/country_dist.html



for file in $(find $1 -type f)
do
	echo "$(awk 'match($0, /[a-zA-Z0-9]{3} +[0-9]{1,2} [0-9]{2} [a-zA-Z0-9_\-\[\]]+ ([0-9\.]+)/, groups) {print groups[1]}' < $file)" >> $1/tmp_failed_country_data.txt
done
sort $1/tmp_failed_country_data.txt > $1/tmp_sorted_country_data.txt
join $1/tmp_sorted_country_data.txt etc/country_IP_map.txt > $1/tmp_joined_country_data.txt

echo "$(awk 'match($0, /[0-9\.]+ ([A-Z]{2})/, groups) {print groups[1]}' < $1/tmp_joined_country_data.txt)" > $1/tmp_country_ids.txt
sort $1/tmp_country_ids.txt > $1/tmp_sorted_country_ids.txt
uniq $1/tmp_sorted_country_ids.txt -c > $1/tmp_country_amount_data.txt

echo "$(awk 'match($0, /[ ]+([0-9]+)[ ]+([A-Z]{2})/, groups) {print "data.addRow([\x27" groups[2] "\x27, " groups[1] "]);"}' < $1/tmp_country_amount_data.txt)" >> $1/tmp_data.txt

./bin/wrap_contents.sh $1/tmp_data.txt html_components/country_dist $1/country_dist.html

rm -f $1/tmp_failed_country_data.txt
rm -f $1/tmp_joined_country_data.txt
rm -f $1/tmp_country_ids.txt
rm -f $1/tmp_sorted_country_ids.txt
rm -f $1/tmp_country_amount_data.txt
rm -f $1/tmp_data.txt

