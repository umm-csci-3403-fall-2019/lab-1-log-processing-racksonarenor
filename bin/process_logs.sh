#!/usr/bin/env bash
dir=$(mktemp -d -t fi-XXXXXXXXXX)
echo $dir
for file in $@
do
	mkdir $dir/$(basename $file .tgz)
	tar -xzf $file -C $dir/$(basename $file .tgz)
done
./bin/process_client_logs.sh $dir
./bin/create_username_dist.sh $dir
./bin/create_hours_dist.sh $dir
./bin/create_country_dist.sh $dir
./bin/assemble_report.sh $dir
cp $dir/failed_login_summary.html failed_login_summary.html
