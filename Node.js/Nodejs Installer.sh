#!/bin/bash

# File to store logs
LOG_FILE="logs.txt"

# Remove the existing log file if it exists
rm -f $LOG_FILE

# Redirect stdout and stderr to a new log file
exec > >(tee $LOG_FILE)
exec 2> >(tee $LOG_FILE >&2)

# Script to set up a new Ubuntu desktop for Web Developers.

# Setup tested on Ubuntu 22.04.3 LTS Release: 22.04 Codename: jammy
echo "This installation script is created & tested in Ubuntu 22.04.3 LTS Release: 22.04 Codename: jammy by Sudeepta Sarkar on 13/01/2024 i.e. 13th January 2024"
sleep 3
echo "To know the creator visit https://github.com/sudsarkar13/Ultimate-Ubuntu-Setup-for-Web-Developers"
xdg-open "https://github.com/sudsarkar13/Ultimate-Ubuntu-Setup-for-Web-Developers" 2> /dev/null &
sleep 10
echo
echo "Setup tested on Ubuntu 22.04.3 LTS Release: 22.04 Codename: jammy and as well as it will be updated accordingly with the response."
sleep 2

# Welcome to the Ultimate Ubuntu setup.
Your_Name=$(getent passwd $(whoami) | cut -d ':' -f 5 | cut -d ',' -f 1) # Get the full name of the current user
echo "Welcome to the Ultimate Ubuntu setup \"$Your_Name\""
echo
echo "To continue with the setup you need a high-speed internet connection"
while true; do
  echo -n "So, are you ready to begin with the setup? (Y/N): "
  read U_Input # Corrected the variable name here

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
sleep 5
# Now check if nodejs is intalled or not.
echo "Checking nodejs is installed or not..."
if command -v node &> /dev/null; then
  echo "nodejs is already installed"
  echo "Skipping nodejs installation"
else
  echo "nodejs is not installed"
  echo "Installing nodejs..."
  nvm install --lts
fi

echo "Installation completed."

sleep 5
# Now check if npm is installed or not
echo "Checking npm is installed or not..."
if command -v npm &> /dev/null; then
  echo "npm is already installed"
  echo "Skipping npm installation"
else
  echo "npm is not installed"
  echo "Installing npm..."
  nvm install-latest-npm
fi
echo "Installation completed."
echo
sleep 5
echo "Setup completed. Happy coding!"
echo
echo -n "Quitting in 10 seconds..."
for i in {10..1}; do
  echo -ne "\rQuitting in $i seconds..."
  sleep 1
done
echo -e "\rQuitting now..."
