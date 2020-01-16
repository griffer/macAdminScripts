## macAdminScripts
A handfull of scripts, which might be of use to other macOS admins.

I never got around to share some of my small scripting tidbits. Partly because i doubt their usefullness to others, and partly because i never gathered them in once place.

So here is my attempt to try and start uploading new scripts as i put them together.


### adReportDescription.sh
At a customer, their Windows PC’s where set up to report hardware information back to the description field in AD.

This script provides the same functionality for MacOS. It gathers current user, logon timestamp, hardware model, serial number and OS version.
It then generates a file with the correct syntax, and reports the information back to the machine object in AD.

In our environment we have a bit more logic wrapped around the script, but the bare basics provided here works fine. It could easily be dropped into for instance Outset.

### changeAccountPassword.sh
A script to change the password of a local administrator user account.

More specifically, it solved a problem i encountered, where the local admin account where using a wide variety of passwords.

This script takes a “;” separated list of old passwords, checks if any of the provided passwords are valid (using a call to “sudo -Sv”). If the password is correct, the script continues and changes the account password, the keychain password and the FileVault password.

If none of the provided passwords are correct, the script will fail with exit 1.

### ipv6Disable.sh
Had an issue where we had to disable IPV6 to troubleshoot some network issues. I cobbled together this script which iterates over all network interfaces and disables IPV6 (I only had to ignoring iPhones and Bluetooth in my script, your environment might be a lot more complicated).

### pkgFlatten.sh
Having to tear apart yet another printer driver, i grew tired of running `"pkgutil --flatten"` on a heap of small packages (the output of running `"pkgutil --expand"` on the main package). This script takes the path to either a single package, or a folder of packages. It flattens them, adding a "FLATTEN" to the name of the package.

### sophosUninstall.sh
A script to uninstall/remove Sophos endpoint protection, without having to provide a tamper protection password.