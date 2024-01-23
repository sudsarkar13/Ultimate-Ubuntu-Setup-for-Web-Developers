#!/bin/bash
# Script to set up a new Ubuntu desktop for Web Developers.

# Setup tested on Ubuntu 22.04.3 LTS Release: 22.04 Codename: jammy
echo "This installation script is created & tested in Ubuntu 22.04.3 LTS Release: 22.04 Codename: jammy by Sudeepta Sarkar on 13/01/2024 i.e. 13th January 2024"
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
echo
echo "To continue with the setup you need a high-speed internet connection"
while true; do 
echo -n "So, are you ready to begin with the setup? (Y/N): "
read U_Input  # Corrected the variable name here

# Convert the input to uppercase
U_Input=$(echo "$U_Input" | tr '[:lower:]' '[:upper:]')
    
if [[ "$U_Input" == "Y" ]]; then
echo "Starting the setup..."
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

# Improved block to ensure nvm installation is functional
echo "Checking if Node Version Manager (nvm) is installed..."
if [ -s "$NVM_DIR/nvm.sh" ]; then
  echo "NVM is already installed. Skipping installation."
  # Ensure the environment variables are set
  . "$NVM_DIR/nvm.sh"
  . "$NVM_DIR/bash_completion"
else
  echo "nvm is not installed. Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  # Define NVM_DIR and attempt to load it into the environment
  export NVM_DIR="${XDG_CONFIG_HOME:-$HOME/.nvm}"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
fi
echo "Installation completed."
sleep 5
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
gnome-terminal -- bash -c ' "Nodejs Installer.sh"; exec bash'
exit