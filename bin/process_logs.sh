#!/usr/bin/env bash
scratch=tmp

rm -rf tmp
mkdir tmp

for file in $@
do
	mkdir tmp/$(basename $file .tgz)
	dir=tmp/$(basename $file .tgz)
	tar -xzf $file -C tmp/$(basename $file .tgz)
	echo $dir
	./bin/process_client_logs.sh $dir
	./bin/create_username_dist.sh $dir
	./bin/create_hours_dist.sh $dir
	./bin/create_country_dist.sh $dir
	./bin/assemble_report.sh $dir
done
