#!/bin/sh
# Provide a ";" seperated list of potential old passwords
oldPasswords="oldPassword1;oldPassword2;oldPassword3"
# New password to use
newPassword="newPassword"
# Useraccount for which the password is to be changed
userAccount="adminAccount"

IFS=';'

changePassword() {
	# Change account password
	/usr/bin/dscl . passwd /Users/${userAccount} "${1}" "${newPassword}"
	# Change keychain password
	sudo security set-keychain-password -o "${1}" -p "${newPassword}" /Users/${userAccount}/Library/Keychains/login.keychain
	# Find users generatedUUID
	uuid=$(dscl . -read /Users/${userAccount} GeneratedUID | cut -c 15-)
	# Change filevault password using the UUID gathered above
	diskutil apfs changePassphrase / -user "${uuid}" -oldPassphrase "${1}" -newPassphrase "${newPassword}"
	exit 0
}

echo "Changing password for account: $userAccount"

# Loop over the potential old passwords
for password in $oldPasswords
do
		# Trying a password, triggering the changePassword function
		# if case the provided password is correct.
        echo "Trying password: $password"
		sudo su - ${userAccount} -c "echo \"${password}\" | sudo -Sv"        
		if [ $? -eq 0 ]; then
		    echo "Correct password, continuing"
		    changePassword "${password}"
		else
		    echo "Wrong password, attempting next..."
		fi
done

exit 1