#!/bin/bash

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