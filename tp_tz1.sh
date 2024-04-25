#!/bin/bash


inp_dir=$1
outp_dir=$2

mkdir -p "$outp_dir"

filecopier() {
	local source=$1
	local destination=$2
	local base=$(basename "$source")
	local path="$destination/$base"
	local fc=1
	while [ -f "$path" ]; do
		path="$destination/${base%.*}_$fc.${base##*.}"
		((fc++))
	done
	cp "$source" "$path"
}
export -f filecopier
find "$inp_dir" -type f -exec bash -c 'filecopier "$0" "$1"' {} "$outp_dir" \;
echo "Всё готово"
