#!/usr/bin/env bash

{
  cat "$1"/country_dist.html
  cat "$1"/hours_dist.html
  cat "$1"/username_dist.html
} > "$1"/concat_doc.txt

./bin/wrap_contents.sh "$1"/concat_doc.txt html_components/summary_plots "$1"/failed_login_summary.html

rm -f "$1"/concat_doc.txt
