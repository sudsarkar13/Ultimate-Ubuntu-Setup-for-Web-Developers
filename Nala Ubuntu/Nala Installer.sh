#!/bin/bash

# File to store logs
LOG_FILE="logs.txt"

# Remove the existing log file if it exists
rm -f $LOG_FILE

# Redirect stdout and stderr to a new log file
exec > >(tee $LOG_FILE)
exec 2> >(tee $LOG_FILE >&2)

# Nala for all
echo "Nala is a front-end for libapt-pkg. Specifically we interface using the python-apt api."
echo
echo "Starting nala installation"
sudo apt install nala
echo
echo "Installation Complete"
echo "Verifying installation..."
sudo nala --version
echo "Verification complete"
echo
# Final Check
echo "Save and close other apps that you are using now, we will check for updates, fix installations"
echo
echo "We will start updating in 30 seconds..."
sleep 30
sudo apt update
sudo apt-file update
sudo apt list --upgradable
sudo apt upgrade -y
echo
echo "Fixing Installations..."
sudo apt --fix-broken install -y
echo
echo "Rebooting Ubuntu in 1 min..."
sleep 60
exit 1