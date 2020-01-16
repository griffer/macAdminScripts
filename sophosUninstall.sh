#!/bin/bash
# Remove Sophos SAAS installation
if [ -e "/Library/Application Support/Sophos/saas/Installer.app/Contents/MacOS/tools/InstallationDeployer" ]; then
	echo "Removing Sophos 9 installation..."
	sudo defaults write /Library/Preferences/com.sophos.sav TamperProtectionEnabled -bool false
	sudo rm "/Library/Sophos Anti-Virus/SophosSecure.keychain"
	sudo "/Library/Application Support/Sophos/saas/Installer.app/Contents/MacOS/tools/InstallationDeployer" --force_remove
fi
exit 0