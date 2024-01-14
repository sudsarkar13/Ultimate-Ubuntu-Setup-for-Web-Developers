#!/bin/bash
# Script to set up a new Ubuntu desktop for Web Developers.

# Setup tested on Ubuntu 22.04.3 LTS Release: 22.04 Codename: jammy
echo "This installation script is created & tested in Ubuntu 22.04.3 LTS Release: 22.04 Codename: jammy by Sudeepta Sarkar on 02/10/2023 i.e. 2nd October 2023"
sleep 3
echo "To know the creator visit https://github.com/sudsarkar13/Ultimate-Ubuntu-Setup-for-Web-Developers"
xdg-open "https://github.com/sudsarkar13/Ultimate-Ubuntu-Setup-for-Web-Developers" 2>/dev/null &
sleep 10
echo
echo "Setup tested on Ubuntu 22.04.3 LTS Release: 22.04 Codename: jammy and as well as it will be updated accordingly with the response."
sleep 2

# Welcome to the Ultimate Ubuntu setup.
Your_Name=$(getent passwd $(whoami) | cut -d ':' -f 5 | cut -d ',' -f 1)  # Get the full name of the current user
echo "Welcome to the Ultimate Ubuntu setup \"$Your_Name\""
echo "To continue with the setup you need a high-speed internet connection"
while true; do 
echo -n "So, are you ready to begin with the setup? (Y/N): "
read U_Input  # Corrected the variable name here

# Convert the input to uppercase
U_Input=$(echo "$U_Input" | tr '[:lower:]' '[:upper:]')
    
if [[ "$U_Input" == "Y" ]]; then
echo "Starting the setup..."
# Add your setup steps here or below


# Loop condition do not interfere here highly restricted area keep in mind developers no need to worry you are allowed to modify the code for your convinience.
break
elif [[ "$U_Input" == "N" ]]; then
echo "Exiting the setup in 10 seconds... "
sleep 1
for i in {9..1}; do
echo -n -e "\rRemaining time: $i"
done
echo -e "\rExiting the setup. Goodbye!"
exit 1
break
else
echo "Invalid input. Please enter 'Y' or 'N'."
fi
done

# Installation Procedure beginning from here onwards.

# Add the WineHQ Ubuntu repository
echo "Checking for updates & upgrades available..."
sudo apt update
sudo apt upgrade -y
sleep 2
echo
echo "Downloading WineHQ key for Ubuntu from stable channel..."
wget -nc https://dl.winehq.org/wine-builds/winehq.key
echo
echo "Installing WineHQ key"
sudo apt-key add winehq.key
echo "Adding WineHQ repository for Ubuntu..."
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ jammy main'

# Update packages and install WineHQ
echo "Installing WineHQ while checking for updates..."
sudo apt update
sudo apt install --install-recommends winehq-stable
echo
# Verify the installation
echo "Verifying the installation..."
wine --version
sleep 10

# Auto clear the unrequired install files
echo "Clearing the unrequired install files..."
sudo apt-get autoremove -y
sudo apt-get autoclean -y
echo "Unrequired install files have been cleared."
echo
sleep 5
echo "Setup completed."
echo
echo -n "Quitting in 10 seconds..."
for i in {10..1}; do
  echo -ne "\rQuitting in $i seconds..."
  sleep 1
done
echo -e "\rQuitting now..."
exit