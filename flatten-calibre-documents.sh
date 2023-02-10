#!/bin/bash

Help()
{
	# Display Help
	echo "flatten-calibre-library.sh"
	echo
	echo "Syntax: flatten-calibre-library.sh [-l|o|h]"
	echo "options:"
	echo "l     Set Calibre library path (Default: \$HOME/Calibre Library)"
	echo "h     Print this Help."
	echo "o     Set output folder (Default: \$HOME/Calibre Flattened Library)"
	echo
	echo "Leonardo Idone"
}

_calibre_dir="$HOME/Calibre Library"
_calibre_flatten_dir="$HOME/Calibre Flattened Library"

while getopts ":l:o:h" option; do
	case $option in
		l) # set calibre dir
			_calibre_dir="${OPTARG}";;
		o) # set calibre flatten dir
			_calibre_flatten_dir="${OPTARG}";;
		h) # display Help
			Help
			exit;;
		\?) # Invalid option
			echo "Error: Invalid option"
			exit;;
	esac
done

mkdir -p "${_calibre_flatten_dir}"

# Dirty but cool hack
find "${_calibre_dir}" -print0 | while IFS= read -r -d '' file; do echo "$file"; done \
	| grep -E "\.(azw3|djvu|epub|mobi|pdf)*$" \
	| while read -r line 
do 
	echo "${line}"
	cp "${line}" "${_calibre_flatten_dir}"
done
