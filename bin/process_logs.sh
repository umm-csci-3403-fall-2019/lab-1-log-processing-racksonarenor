#!/usr/bin/env bash
scratch=tmp

rm -rf tmp
mkdir tmp

for file in $@
do
	mkdir tmp/$(basename $file .tgz)
	tar -xzf $file -C tmp/$(basename $file .tgz)
done
