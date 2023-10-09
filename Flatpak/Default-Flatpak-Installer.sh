#!/bin/bash

# Check if Flatpak is installed
if command -v flatpak &> /dev/null; then
    # Flatpak is already installed
    echo "Flatpak is already installed. Version:"
    flatpak --version
    sleep 2.5
    exit 0
fi

# Install Flatpak
echo "Installing Flatpak..."
sudo apt update
sudo apt install -y flatpak

# Install the Flatpak plugin for Software app
echo "Installing Flatpak plugin for Software app..."
sudo apt install -y gnome-software-plugin-flatpak

# Add Flathub repository
echo "Adding Flathub repository..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo
echo "Flatpak installation and setup completed."
echo "You can now install Flatpak apps using your Software Center or run 'flatpak install' from the command line."
echo
# Reboot to apply changes
echo "Rebooting the system to apply changes..."
sleep 5
sudo reboot
