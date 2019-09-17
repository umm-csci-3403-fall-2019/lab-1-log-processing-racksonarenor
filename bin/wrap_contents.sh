#!/usr/bin/env bash

rm -f "$3"
cat "$2_header.html" >> "$3"
cat "$1" >> "$3"
cat "$2_footer.html" >> "$3"
