#!/bin/bash

# Gather information about the computer
adComputerName="$(dsconfigad -show | grep "Computer Account" | awk '{print $4}')"
adDomain="$(dsconfigad -show | grep "Active Directory Domain" | awk '{print $5}')"
adString="$(dscl /Search read /Computers/$adComputerName | grep dsAttrTypeNative:distinguishedName | cut -c 37-)"
username="$(id -F)"
timestamp="$(date +'%d-%m-%Y - %H:%M')"
hardwareModel="$(sysctl hw.model | cut -c 11-)"
serieNummer="$(ioreg -c IOPlatformExpertDevice -d 2 | awk -F\" '/IOPlatformSerialNumber/{print $(NF-1)}')"
systemVersion="$(sw_vers | grep ProductVersion | cut -c 17-)"	

# Creates a temporary with the gathered data, correctly formatted for AD
echo "dn: $adString" > /tmp/adReport
echo "changetype: modify" >> /tmp/adReport
echo "replace: description" >> /tmp/adReport
echo "description: $username - Logon: $timestamp / Model: $hardwareModel / Serial: $serieNummer / OS: MacOS $systemVersion" >> /tmp/adReport	

# Write data back to AD
ldapmodify -h "$adDomain" -f /tmp/adReport	

# Remove the temporary file with the gathered data
rm /tmp/adReport

exit 0