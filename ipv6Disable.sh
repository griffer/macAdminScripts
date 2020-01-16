#!/bin/bash
interfaces=$(networksetup -listallnetworkservices | tail -n +2)
# Set the field separator to new line
IFS=$'\n'

# Iterate over each line
for i in $interfaces
do
	if [ "$i" == "iPhone" ]; then
  		echo "iPhone, ignore..."
  	elif [ "$i" == "Bluetooth PAN" ]; then
  		echo "Bluetooth, ignore..."
	else
		networksetup -setv6off "$i"
	fi
done
exit 0