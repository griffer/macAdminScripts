#!/bin/bash
# If no path is provided, we exit the script
if [[ -z "$1" ]]; then
	echo "No path provided!"
	exit 1
fi

# Define what the flattened packages extension should be named
flattenExtension="FLATTEN.pkg"

# Function takes a path to a package, and flattens package at provided path
flattenPkg() {
	filename=$(basename -- "$1")
	extension="${filename##*.}"
	filename="${filename%.*}"
	directory=$(dirname "${1}")
	# Only attempt flatten if a file with .pkg extension is passed
	if [ "$extension" == "pkg" ]; then
		echo "Flattening ==> $1"
		pkgutil --flatten "${1}" "${directory}/${filename}${flattenExtension}"
	fi
}

# Loop over provided path and flatten all packages found
flattenLoop() {
	echo "$1"
	files="$1/*"
	for pkg in $files
	do
		flattenPkg "$pkg"
	done
}

# If a pkg path is provided flatten the package
if [[ -f "${1}" ]]; then
	flattenPkg "$1"
fi

# If a folder path is provided, trigger loop over all packages
if [[ -d "${1}" ]]; then
	flattenLoop "$1"
fi

exit 0