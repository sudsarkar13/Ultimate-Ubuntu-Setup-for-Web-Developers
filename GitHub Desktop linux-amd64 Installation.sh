#!/bin/bash

# Update & Upgrade packages
sudo apt update
sudo apt upgrade -y
echo
# For installation requirement we need gdebi-core
echo "Installing requirement (gdebi)..."
echo
sudo apt-get install gdebi-core
echo
echo "Verifying installation..."
sudo gdebi --version
echo "Installing gdebi complete"
echo
echo "Fetching latest release..."
wget https://github.com/shiftkey/desktop/releases/download/release-3.3.1-linux1/GitHubDesktop-linux-amd64-3.3.1-linux1.deb
echo "Downloading Complete..."
echo
sudo gdebi GitHubDesktop-linux-amd64-3.3.1-linux1.deb
echo
echo "Installation Succesfull"
echo
echo "Checking Ubuntu updates & Closing..."
sudo apt update
sudo apt upgrade -y