#!/bin/bash

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
echo -n "Enter your name: "
read Your_Name
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

# Checks for updates available & upgrades the packages required. 
sudo apt update
sudo apt upgrade -y
echo
# Adding unsnap (Quickly migrate from using snap packages to flatpaks)
echo "Quickly and easily migrate from using snap for applications to flatpak. unsnap runs as a two-stage process. unsnap itself generates the scripts to do the actual migration. This enables users to view and/or edit the scripts prior to execution to validate or tweak them."
echo "Cloning unsnap using git..."
git clone https://github.com/popey/unsnap
cd unsnap
./unsnap
echo
./unsnap auto
echo
cd ..
echo
sleep 5
echo "Final Checking..."
sudo apt update
sudo apt upgrade -y